"
Оприходывание на указанный счет

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	date:		<Object>
	destAccount:		<Object>
	editor:		<Object>
	items:		<Object>
	number:		<Object>
	organization:		<Object>
	selectionItem:		<Object>
	sourceAccount:		<Object>


    Implementation Points
"
Class {
	#name : #ARecordingOfModel,
	#superclass : #AModel,
	#instVars : [
		'number',
		'organization',
		'account2',
		'account3',
		'date',
		'editor',
		'items',
		'selectionItem',
		'amountItem',
		'accountItem1',
		'accountItem2',
		'accountItem3',
		'accountEditor'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
ARecordingOfModel class >> documents [
	^ self configClass recordingOfs
]

{ #category : #adding }
ARecordingOfModel class >> nextIndex [
	^ self configClass nextRecordingOfIndex asString
]

{ #category : #actions }
ARecordingOfModel >> accept [
	| amounts t |
	t := Time
		millisecondsToRun: [ self removeAccounts.
			amounts := self createAmounts.
			self accounts add: amounts ].
	self
		trace:
			self number asString , ' transfer saved. Milliseconds to run: '
				, t asString , String cr.
	^ amounts
]

{ #category : #accessing }
ARecordingOfModel >> account2 [
	^ account2 ifNil: [ account2 := '' ]
]

{ #category : #accessing }
ARecordingOfModel >> account2: anObject [
	account2 := anObject.
	self changed: #account2
]

{ #category : #accessing }
ARecordingOfModel >> account3 [
	^ account3 ifNil: [ account3 := '' ]
]

{ #category : #accessing }
ARecordingOfModel >> account3: anObject [
	account3 := anObject.
	self changed: #account3.
]

{ #category : #accessing }
ARecordingOfModel >> accountEditor [
	^ accountEditor ifNil: [ accountEditor := AAccountEditor new ]
]

{ #category : #accessing }
ARecordingOfModel >> accountEditor: anObject [
	accountEditor := anObject
]

{ #category : #accessing }
ARecordingOfModel >> accountItem1 [
	^ accountItem1 ifNil: [ accountItem1 := '' ]
]

{ #category : #accessing }
ARecordingOfModel >> accountItem1: anAccount [
	accountItem1 ifNotNil: [ accountItem1 := anAccount ] ifNil: [ accountItem1 := '' ].
	self changed: #accountItem1
]

{ #category : #accessing }
ARecordingOfModel >> accountItem2 [
	^ accountItem2 ifNil: [ accountItem2 := '' ]
]

{ #category : #accessing }
ARecordingOfModel >> accountItem2: anAccount [
	accountItem2 ifNotNil: [ accountItem2 := anAccount ] ifNil: [ accountItem2 := '' ].
	self changed: #accountItem2
]

{ #category : #accessing }
ARecordingOfModel >> accountItem3 [
	^ accountItem3 ifNil: [ accountItem3 := '' ]
]

{ #category : #accessing }
ARecordingOfModel >> accountItem3: anObject [
	accountItem3 := (anObject ifNotNil: [anObject asString] ifNil: ['']).
	self changed: #accountItem3.
]

{ #category : #actions }
ARecordingOfModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
	anArray size < 2 ifTrue: [ self account2: ''. self account3: ''. ^ self ].
	self account2: (anArray at: 2).
	anArray size < 3 ifTrue: [ self account3: ''. ^ self ].
	self account3: (anArray at: 3)
]

{ #category : #actions }
ARecordingOfModel >> addItem [
	| sw |
	sw := self accountEditor makeSwap.
	self items updateOrAddAmount: sw.
]

{ #category : #accessing }
ARecordingOfModel >> amountItem [
	^ amountItem ifNil: [ amountItem := '' ]
]

{ #category : #accessing }
ARecordingOfModel >> amountItem: anObject [
	amountItem := anObject.
	self changed: #amountItem.
]

{ #category : #accessing }
ARecordingOfModel >> convertDate [
	^ (DateParser readingFrom: (ReadStream on: self date) pattern: 'd.mm.yyyy') parse
]

{ #category : #actions }
ARecordingOfModel >> createAmounts [
	| sacc |
	sacc := AAccount new.
	sacc add: self recordingOfName; add: self numberPrefix, self number.
	sacc add: self organization.
	(self account2 = '') ifFalse: [ sacc add: self account2 ].
	(self account3 = '') ifFalse: [ sacc add: self account3 ].
	sacc addAll: (ADateTagsBuilder new date: self date; build).
	sacc addAccount: self items.
	self inform: self number, ' recording of is saved'.
	^ sacc
]

{ #category : #accessing }
ARecordingOfModel >> date [
	^ date ifNil: [ date := self today ]
]

{ #category : #accessing }
ARecordingOfModel >> date: anObject [
	date := anObject.
	self changed: #date.
]

{ #category : #actions }
ARecordingOfModel >> downItem: aSwap [
	self items downAmount: aSwap.
]

{ #category : #accessing }
ARecordingOfModel >> editor [
	^ editor ifNil: [ editor := '' ]
]

{ #category : #accessing }
ARecordingOfModel >> editor: anObject [
	editor := anObject
]

{ #category : #accessing }
ARecordingOfModel >> items [
	^ items ifNil: [ items := AAccount new ]
]

{ #category : #accessing }
ARecordingOfModel >> items: someItems [
	items := someItems.
]

{ #category : #accessing }
ARecordingOfModel >> number [
	^ number ifNil: [ number := '' ]
]

{ #category : #accessing }
ARecordingOfModel >> number: anObject [
	number := anObject.
	self changed: #number.
]

{ #category : #actions }
ARecordingOfModel >> open [
	^ ARecordingOfGlamour openOn: self
]

{ #category : #accessing }
ARecordingOfModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
ARecordingOfModel >> organization: anObject [
	organization := anObject.
	self changed: #organization
]

{ #category : #actions }
ARecordingOfModel >> removeAccounts [
	| acc |
	acc := AAccount new.
	acc add: self numberPrefix, self number.
	acc add: self recordingOfName.
	self accounts remove: acc.
]

{ #category : #actions }
ARecordingOfModel >> removeItem [
	self items amounts
		remove: self accountEditor makeSwap ifAbsent: [  ]
]

{ #category : #accessing }
ARecordingOfModel >> selectionItem [
	^ selectionItem
]

{ #category : #accessing }
ARecordingOfModel >> selectionItem: anObject [
	selectionItem := anObject.
	self accountEditor updateEditor: anObject. 
]

{ #category : #actions }
ARecordingOfModel >> upItem: aSwap [
	self items upAmount: aSwap.
]

{ #category : #actions }
ARecordingOfModel >> validateAddItem [
	self amountItem = '' ifTrue: [ self amountItem: '1' ].
	(self accountItem1 = '' and: [ self accountItem2 = '' and: [self accountItem3 = '' ]] )
		ifTrue: [ Error signal: 'Empty unit or properties goods' ].
]
