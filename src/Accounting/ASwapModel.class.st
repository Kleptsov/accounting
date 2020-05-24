"
Модель реализует бартерные обмен товаров, так и покупки в магазине или у кого-нибудь

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	contractor:		<Object>
	contractorAccount:		<Object>
	date:		<Object>
	editor:		<Object>
	items:		<Object>
	number:		<Object>
	organization:		<Object>
	organizationAccount:		<Object>
	selectionItem:		<Object>


    Implementation Points
"
Class {
	#name : #ASwapModel,
	#superclass : #AModel,
	#instVars : [
		'number',
		'organization',
		'organizationAccount',
		'organizationAccount2',
		'contractor',
		'contractorAccount',
		'contractorAccount2',
		'date',
		'editor',
		'amountItem',
		'accItem1',
		'accItem2',
		'sumItem',
		'currencyItem',
		'items',
		'selectionItem'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
ASwapModel class >> documents [
	^ self configClass swaps2
]

{ #category : #adding }
ASwapModel class >> nextIndex [
	^ self configClass nextSwapIndex2 asString
]

{ #category : #accessing }
ASwapModel >> accItem1 [
	^ accItem1 ifNil: [ accItem1 := '' ]
]

{ #category : #accessing }
ASwapModel >> accItem1: anObject [
	accItem1 := anObject.
	self changed: #accItem1.
]

{ #category : #accessing }
ASwapModel >> accItem2 [
	^ accItem2 ifNil: [ accItem2 := '' ]
]

{ #category : #accessing }
ASwapModel >> accItem2: anObject [
	accItem2 := anObject.
	self changed: #accItem2
]

{ #category : #actions }
ASwapModel >> accept [
	| swaps t |
	t := Time
		millisecondsToRun: [ self removeAccounts.
			swaps := self createSwaps.
			self accounts addAll: swaps ].
	self
		trace:
			self number asString , ' invoice is saved. Milliseconds to run: '
				, t asString , String cr.
	^ swaps
]

{ #category : #actions }
ASwapModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
	anArray size < 2 ifTrue: [ self organizationAccount: ''.
										self organizationAccount2: ''.
										 ^ self ].
	self organizationAccount: (anArray at: 2).
	anArray size < 3 ifTrue: [ self organizationAccount2: ''.
									^ self ].
	self organizationAccount2: (anArray at: 3).
]

{ #category : #actions }
ASwapModel >> addAccount2: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self contractor: (anArray at: 1).
	anArray size < 2 ifTrue: [ 
		self contractorAccount: ''.
		self contractorAccount2: ''.
		^ self ].
	self contractorAccount: (anArray at: 2).
	anArray size < 3 ifTrue: [ 
		self contractorAccount2: ''.
		^ self ].
	self contractorAccount2: (anArray at: 3).
]

{ #category : #actions }
ASwapModel >> addItem [
	self items updateOrAddAmount: 
		(AAmountSwapBuilder new string: self editor; build).
]

{ #category : #accessing }
ASwapModel >> amountItem [
	^ amountItem ifNil: [ amountItem := '' ]
]

{ #category : #accessing }
ASwapModel >> amountItem: anObject [
	amountItem := anObject.
	self changed: #amountItem.
]

{ #category : #accessing }
ASwapModel >> contractor [
	^ contractor ifNil: [ contractor := '' ]
]

{ #category : #accessing }
ASwapModel >> contractor: anObject [
	contractor := anObject.
	self changed: #contractor.
]

{ #category : #accessing }
ASwapModel >> contractorAccount [
	^ contractorAccount ifNil: [ contractorAccount := '' ]
]

{ #category : #accessing }
ASwapModel >> contractorAccount2 [
	^ contractorAccount2 ifNil: [ contractorAccount2 := '' ]
]

{ #category : #accessing }
ASwapModel >> contractorAccount2: anObject [
	contractorAccount2 := anObject.
	self changed: #contractorAccount2.
]

{ #category : #accessing }
ASwapModel >> contractorAccount: anObject [
	contractorAccount := anObject.
	self changed: #contractorAccount.
]

{ #category : #accessing }
ASwapModel >> convertDate [
	^ (DateParser readingFrom: (ReadStream on: self date) pattern: 'd.mm.yyyy') parse
]

{ #category : #actions }
ASwapModel >> createSwaps [
	| w |
	w := ASwapBuilder new.
	w 	common addAll: {self swapName. (self numberPrefix, self number)}.
	w 	first add: self organization.
	self organizationAccount = '' ifFalse: [w  first add: self organizationAccount].
	self organizationAccount2 = '' ifFalse: [ w first add: self organizationAccount2 ].
	w 	second add: self contractor.
	self contractorAccount = '' ifFalse: [w 	second add: self contractorAccount].
	self contractorAccount2 = '' ifFalse: [ w second add: self contractorAccount2 ].
	w swaps: self items.
	w common addAll: (ADateTagsBuilder new date: self date; build).
	^ w build
]

{ #category : #accessing }
ASwapModel >> currencyItem [
	^ currencyItem ifNil: [ currencyItem := '' ]
]

{ #category : #accessing }
ASwapModel >> currencyItem: anObject [
	currencyItem := anObject.
	self changed: #currencyItem.
]

{ #category : #accessing }
ASwapModel >> date [
	^ date ifNil: [ date := self today ]
]

{ #category : #accessing }
ASwapModel >> date: anObject [
	date := anObject.
	self changed: #date.
]

{ #category : #actions }
ASwapModel >> downItem: aSwap [
	self items downAmount: aSwap.
]

{ #category : #accessing }
ASwapModel >> editor [
	^ editor ifNil: [ editor := '' ]
]

{ #category : #accessing }
ASwapModel >> editor: anObject [
	editor := anObject
]

{ #category : #accessing }
ASwapModel >> items [
	^ items ifNil: [ items := AAccount new ]
]

{ #category : #accessing }
ASwapModel >> items: someItems [
	items := someItems.
]

{ #category : #accessing }
ASwapModel >> number [
	^ number ifNil: [ number := '' ]
]

{ #category : #accessing }
ASwapModel >> number: anObject [
	number := anObject.
	self changed: #number.
]

{ #category : #actions }
ASwapModel >> open [
	^ ASwapGlamour openOn: self
]

{ #category : #accessing }
ASwapModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
ASwapModel >> organization: anObject [
	organization := anObject.
	self changed: #organization.
]

{ #category : #accessing }
ASwapModel >> organizationAccount [
	^ organizationAccount ifNil: [ organizationAccount := '' ]
]

{ #category : #accessing }
ASwapModel >> organizationAccount2 [
	^ organizationAccount2 ifNil: [ organizationAccount2 := '' ]
]

{ #category : #accessing }
ASwapModel >> organizationAccount2: anObject [
	organizationAccount2 := anObject.
	self changed: #organizationAccount2.
]

{ #category : #accessing }
ASwapModel >> organizationAccount: anObject [
	organizationAccount := anObject.
	self changed: #organizationAccount.
]

{ #category : #actions }
ASwapModel >> removeAccounts [
	| acc |
	acc := AAccount new.
	acc add: self numberPrefix, self number.
	acc add: self swapName.
	self accounts remove: acc.
]

{ #category : #actions }
ASwapModel >> removeItem [
	self  items amounts remove: selectionItem ifAbsent: [  ]
]

{ #category : #accessing }
ASwapModel >> selectionItem [
	^ selectionItem
]

{ #category : #accessing }
ASwapModel >> selectionItem: anObject [
	selectionItem := anObject.
	self changed: #selectionItem.
]

{ #category : #accessing }
ASwapModel >> sumItem [
	^ sumItem ifNil: [ sumItem := '' ]
]

{ #category : #accessing }
ASwapModel >> sumItem: anObject [
	sumItem := anObject.
	self changed: #sumItem.
]

{ #category : #actions }
ASwapModel >> upItem: aSwap [
	self items upAmount: aSwap.
]

{ #category : #actions }
ASwapModel >> updateEditor: anSwap [
	| coll |
	anSwap ifNil: [ ^ self ].
	self selectionItem: anSwap.
	self amountItem: anSwap amount asString.
	coll := anSwap asOrderedCollection.
	coll isEmpty
		ifFalse: [ self accItem1: coll first asString ]
		ifTrue: [self accItem1: ''; accItem2: '' ].
	coll size > 1
		ifTrue: [ self accItem2: coll second asString ]
		ifFalse: [self accItem2: ''].
	self sumItem: anSwap swapAmount amount asString.
	self currencyItem: anSwap swapAmount asOrderedCollection first asString.
]

{ #category : #actions }
ASwapModel >> updateOrAddSwapItem [
	| sw |
	(self amountItem = '' or:
		[ self sumItem = '' or:
			[ self currencyItem = '' ] ])
				ifTrue: [ Error signal: 'Empty field amount or sum or currency'. ^ self ].
	(self accItem1 = '' and: [ self accItem2 = '' ] )
		ifTrue: [ Error signal: 'Empty unit or properties goods' ].
	sw := ASwap new.
	sw amount: (self amountItem asNumber).
	self accItem1 = '' ifFalse: [ sw add: accItem1 asString ].
	self accItem2 = '' ifFalse: [ sw add: accItem2 asString ].
	sw swapAmount amount: (self sumItem asNumber);
			add: self currencyItem.
	self items updateOrAddAmount: sw.
]
