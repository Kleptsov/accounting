"
Перемещение товаров по счетам организации

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	contractor:		<Object>
	contractorAccount:		<Object>
	contractorAccount2:		<Object>
	date:		<Object>
	editor:		<Object>
	items:		<Object>
	number:		<Object>
	organization:		<Object>
	organizationAccount:		<Object>
	organizationAccount2:		<Object>
	selectionItem:		<Object>


    Implementation Points
"
Class {
	#name : #ATransferModel,
	#superclass : #AModel,
	#instVars : [
		'number',
		'organization',
		'sourceAccount',
		'destAccount',
		'date',
		'items',
		'selectionItem',
		'accountEditor'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
ATransferModel class >> documents [
	^ self configClass transfers
]

{ #category : #adding }
ATransferModel class >> nextIndex [
	^ self configClass nextTransferIndex asString
]

{ #category : #actions }
ATransferModel >> accept [
	| sourceAmounts destAmounts accs t |
	t := Time
		millisecondsToRun: [ self removeAccounts.
			sourceAmounts := self createSourceAmounts.
			destAmounts := self createDestAmounts.
			accs := {sourceAmounts.
			destAmounts}.
			self accounts addAll: accs ].
	self
		trace:
			self number asString , ' transfer saved. Milliseconds to run: '
				, t asString , String cr.
	^ accs
]

{ #category : #accessing }
ATransferModel >> accountEditor [
	^ accountEditor ifNil: [ accountEditor := AAccountEditor new ]
]

{ #category : #actions }
ATransferModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
	anArray size < 2 ifTrue: [ self sourceAccount: ''. ^ self ].
	self sourceAccount: (anArray at: 2).
]

{ #category : #actions }
ATransferModel >> addAccount2: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
	anArray size < 2 ifTrue: [ self destAccount: ''. ^ self ].
	self destAccount: (anArray at: 2).
]

{ #category : #actions }
ATransferModel >> addItem [
	self items updateOrAddAmount: 
		(AAmountBuilder new string: self editor; build).
]

{ #category : #accessing }
ATransferModel >> convertDate [
	^ (DateParser readingFrom: (ReadStream on: self date) pattern: 'd.mm.yyyy') parse
]

{ #category : #actions }
ATransferModel >> createDestAmounts [
	| sacc |
	sacc := AAccount new.
	sacc addAll: {self transferName. (self numberPrefix, self number)}.
	sacc add: self organization.
	(self destAccount = '') ifFalse: [ sacc add: self destAccount ].
	sacc addAll: (ADateTagsBuilder new date: self date; build).
	sacc addAccount: self items.
	^ sacc
]

{ #category : #actions }
ATransferModel >> createSourceAmounts [
	| sacc |
	sacc := AAccount new.
	sacc addAll: {self transferName. (self numberPrefix, self number)}.
	sacc add: self organization.
	(self sourceAccount = '') ifFalse: [ sacc add: self sourceAccount ].
	sacc addAll: (ADateTagsBuilder new date: self date; build).
	sacc difAccount: self items.
	^ sacc
]

{ #category : #accessing }
ATransferModel >> date [
	^ date ifNil: [ date := self today ]
]

{ #category : #accessing }
ATransferModel >> date: anObject [
	date := anObject
]

{ #category : #accessing }
ATransferModel >> destAccount [
	^ destAccount ifNil: [ destAccount := '' ]
]

{ #category : #accessing }
ATransferModel >> destAccount: anObject [
	destAccount := anObject
]

{ #category : #actions }
ATransferModel >> downItem: aSwap [
	self items downAmount: aSwap.
]

{ #category : #accessing }
ATransferModel >> items [
	^ items ifNil: [ items := AAccount new ]
]

{ #category : #accessing }
ATransferModel >> items: someItems [
	items := someItems.
]

{ #category : #accessing }
ATransferModel >> number [
	^ number ifNil: [ number := '' ]
]

{ #category : #accessing }
ATransferModel >> number: anObject [
	number := anObject
]

{ #category : #actions }
ATransferModel >> open [
	^ ATransferGlamour openOn: self
]

{ #category : #accessing }
ATransferModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
ATransferModel >> organization: anObject [
	organization := anObject
]

{ #category : #actions }
ATransferModel >> removeAccounts [
	| acc |
	acc := AAccount new.
	acc add: self numberPrefix, self number.
	acc add: self transferName.
	self accounts remove: acc.
]

{ #category : #actions }
ATransferModel >> removeItem [
	self  items amounts remove: selectionItem ifAbsent: [  ]
]

{ #category : #accessing }
ATransferModel >> selectionItem [
	^ selectionItem
]

{ #category : #accessing }
ATransferModel >> selectionItem: anObject [
	selectionItem := anObject
]

{ #category : #accessing }
ATransferModel >> sourceAccount [
	^ sourceAccount ifNil: [ sourceAccount := '' ]
]

{ #category : #accessing }
ATransferModel >> sourceAccount: anObject [
	sourceAccount := anObject
]

{ #category : #actions }
ATransferModel >> upItem: aSwap [
	self items upAmount: aSwap.
]
