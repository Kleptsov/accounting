"
Модель накладной

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	contractNumber:		<Object>
	contractor:		<Object>
	date:		<Object>
	editor:		<Object>
	items:		<Object>
	number:		<Object>
	organization:		<Object>
	selectionItem:		<Object>
	store:		<Object>


    Implementation Points
"
Class {
	#name : #AInvoiceModel,
	#superclass : #AModel,
	#instVars : [
		'number',
		'contractNumber',
		'organization',
		'contractor',
		'date',
		'editor',
		'items',
		'store',
		'selectionItem',
		'accountEditor'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
AInvoiceModel class >> documents [
	^ self configClass invoices2
]

{ #category : #adding }
AInvoiceModel class >> nextIndex [
	^ self configClass nextInvoiceIndex2 asString
]

{ #category : #actions }
AInvoiceModel >> accept [
	| swaps t |
	t := Time millisecondsToRun:
	[self cancelAccepted.
	swaps := self buildSwaps.
	self accounts addAll: swaps.
	self savedAccounts: swaps].
	self log: self number asString, ' invoice is saved. Milliseconds to run: ', t asString, String cr.
	^ swaps.
]

{ #category : #accessing }
AInvoiceModel >> accountEditor [
	^ accountEditor ifNil: [ accountEditor := AAccountEditor new ]
]

{ #category : #accessing }
AInvoiceModel >> accountEditor: anAccountEditor [
	accountEditor := anAccountEditor.
]

{ #category : #accessing }
AInvoiceModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
	anArray size < 2 ifTrue: [ 
		self store: ''. ^ self ].
	self store: (anArray at: 2).
]

{ #category : #actions }
AInvoiceModel >> addAccount2: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self contractor: (anArray at: 1).
]

{ #category : #actions }
AInvoiceModel >> addItem [
	self items updateOrAddAmount: 
		(AAmountSwapBuilder new string: self editor; build)
]

{ #category : #actions }
AInvoiceModel >> buildSwaps [
	| w |
	w := ASwapBuilder new.
	w 	common addAll: {self invoiceName. (self invoicePrefix, self number). (self numberPrefix, self contractNumber)}.
	w	first add: self organization.
	self store = '' ifFalse: [ w first add: self store ].
	w	second add: self contractor.
	w swaps: self items.
	w common addAll: (ADateTagsBuilder new date: self date; build).
	^ w build.
]

{ #category : #accessing }
AInvoiceModel >> contractNumber [
	^ contractNumber ifNil: [ contractNumber := '' ]
]

{ #category : #accessing }
AInvoiceModel >> contractNumber: anObject [
	contractNumber := anObject.
	self changed: #contractNumber
]

{ #category : #accessing }
AInvoiceModel >> contractor [
	^ contractor ifNil: [ contractor := '' ]
]

{ #category : #accessing }
AInvoiceModel >> contractor: anObject [
	contractor := anObject.
	self changed: #contractor.
]

{ #category : #accessing }
AInvoiceModel >> convertDate [
	^ (DateParser readingFrom: (ReadStream on: self date) pattern: 'd.mm.yyyy') parse
]

{ #category : #actions }
AInvoiceModel >> createFirsts [
	|firsts d|
	d := self convertDate.
	firsts := Set new.
	firsts add: (AConfig contractPrefix, number).
	firsts add: organization.
	firsts add: (AConfig yearPrefix, d year asString).
	firsts add: (AConfig monthPrefix, d monthIndex asString).
	firsts add: (AConfig dayPrefix, d dayOfMonth asString).
	^ firsts.
]

{ #category : #actions }
AInvoiceModel >> createTransfer [
	| transfer |
	transfer := ATransferModel addNew.
	transfer organization: self organization.
	transfer items: self items asAmounts.
	^ transfer.
]

{ #category : #accessing }
AInvoiceModel >> date [
	^ date ifNil: [ date := '' ]
]

{ #category : #accessing }
AInvoiceModel >> date: anObject [
	date := anObject.
	self changed: #date.
]

{ #category : #actions }
AInvoiceModel >> downItem: aSwap [
	self items downAmount: aSwap.
]

{ #category : #accessing }
AInvoiceModel >> items [
	^ items ifNil: [ items := AAccount new ]
]

{ #category : #accessing }
AInvoiceModel >> items: someItems [
	items := someItems.
]

{ #category : #accessing }
AInvoiceModel >> number [
	^ number ifNil: [ number := '' ]
]

{ #category : #accessing }
AInvoiceModel >> number: anObject [
	number := anObject.
	self changed: #number.
]

{ #category : #actions }
AInvoiceModel >> open [
	^ AInvoiceGlamour openOn: self
]

{ #category : #accessing }
AInvoiceModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
AInvoiceModel >> organization: anObject [
	organization := anObject.
	self changed: #organization.
]

{ #category : #actions }
AInvoiceModel >> removeItem [
	self items amounts
		remove: (self accountEditor currentSwap) ifAbsent: [ ]
]

{ #category : #accessing }
AInvoiceModel >> selectionItem [
	^ selectionItem
]

{ #category : #accessing }
AInvoiceModel >> selectionItem: anObject [
	selectionItem := anObject.
	self changed: #selectionItem
]

{ #category : #accessing }
AInvoiceModel >> store [
	^ store ifNil: [ store := '' ]
]

{ #category : #accessing }
AInvoiceModel >> store: anObject [
	store := anObject.
	self changed: #store.
]

{ #category : #actions }
AInvoiceModel >> upItem: aSwap [
	self items upAmount: aSwap.
]

{ #category : #actions }
AInvoiceModel >> updateOrAddSwapItem [
	| sw |
	sw := self accountEditor makeSwap.
	sw ifNil: [ ^ self ].
	self items updateOrAddAmount: sw.
]
