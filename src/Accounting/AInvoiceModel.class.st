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
		'items',
		'store',
		'selectionItem',
		'accountEditor',
		'itemsList',
		'receiptName',
		'currencyName'
	],
	#category : #'Accounting-Model'
}

{ #category : #'as yet unclassified' }
AInvoiceModel class >> baseTitle [
	^ 'Invoice' translated
]

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
	t := Time
		millisecondsToRun: [ self cancelAccepted.
			swaps := self buildSwaps.
			self accounts addAll: swaps.
			self savedAccounts: swaps ].
	self
		trace:
			self number asString , ' invoice is saved. Milliseconds to run: '
				, t asString , String cr.
	^ swaps
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

{ #category : #actions }
AInvoiceModel >> changeReceipt [
	self receiptName = '' ifTrue: [ ^ self ].
	self items amounts do: [ :el|
		el swapAmount removeAll.
		el swapAmount add: self receiptName ].
	self changed: #itemsList with: self.
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
AInvoiceModel >> currencyName [
	^ currencyName ifNil: [ currencyName := '' ]
]

{ #category : #accessing }
AInvoiceModel >> currencyName: anObject [
	currencyName := anObject.
	self changed: #currencyName.
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
AInvoiceModel >> downItem [
	self items downAmount: (self accountEditor makeSwap).
	self changed: #itemsList with: self.
]

{ #category : #actions }
AInvoiceModel >> downItem: aSwap [
	self items downAmount: aSwap.
]

{ #category : #accessing }
AInvoiceModel >> firstName [
	^ self number, ' - ', self contractNumber
]

{ #category : #initialization }
AInvoiceModel >> initialize [
	super initialize.
	date := self today.
]

{ #category : #initialization }
AInvoiceModel >> initializeSelection: anAnnouncer [
	anAnnouncer
		when: MorphTreeSelectionChanged
		do: [ :a | (a selection lastSelectedNode) ifNotNil: [ :n|
								self accountEditor updateEditor: n item ] ].
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
AInvoiceModel >> itemsList [
	itemsList := FMorphTreeModel new.
	
	self initializeSelection: itemsList announcer. 
	
	itemsList columnLabel: 'Count' translated selector: #amount morph: [:v :c|
		c startWidth: 50.
		v asString asMorph ].
	
	itemsList
		columnLabel: 'Goodies' translated
		selector: #yourself
		morph: [ :v :c | 
			| col |
			c startWidth: 300.
			col := v asOrderedCollection.
			(col isEmpty
				ifFalse: [ col inject: '' into: [ :sum :el| sum, el asString, ' ' ]  ]
				ifTrue: [ '' ]) asMorph ].
			
	itemsList
		columnLabel: 'Price' translated
		selector: #swapAmount
		morph: [ :v :c | 
			c startWidth: 50.
			v amount asString asMorph ].
		
	itemsList
		columnLabel: 'Currency' translated
		selector: #swapAmount
		morph: [ :v :c | 
			| col |
			c startWidth: 100.
			col := v asOrderedCollection.
			(col isEmpty
				ifFalse: [ col first asString ]
				ifTrue: [ '' ]) asMorph ].
			
	itemsList rootItems: self items amounts.
	^ itemsList
]

{ #category : #rendering }
AInvoiceModel >> moprhController [
	^ FDirectController new.
]

{ #category : #rendering }
AInvoiceModel >> morphRenderer [
	^ AInvoiceMorphRenderer new
]

{ #category : #rendering }
AInvoiceModel >> morphView [
	^ self moprhController
			listen: #yourself from: self.
]

{ #category : #rendering }
AInvoiceModel >> morphViewInWindow [
	| m w |
	m := self morphView.
	w := StandardWindow new.
	w title: (self number, '-', self organization, ' - ', self contractor, ' ', 'Invoice' translated).
	w addMorph: m frame: LayoutFrame new.
	w open.
	^ m
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

{ #category : #accessing }
AInvoiceModel >> receiptName [
	^ receiptName ifNil: [ receiptName := '' ]
]

{ #category : #accessing }
AInvoiceModel >> receiptName: anObject [
	receiptName := anObject.
	self changed: #receiptName
]

{ #category : #actions }
AInvoiceModel >> removeItem [
	self items amounts
		remove: (self accountEditor currentSwap) ifAbsent: [ ].
	self changed: #itemsList with: self.
]

{ #category : #actions }
AInvoiceModel >> removeSwapItem [
	self items amounts
			remove: (self accountEditor makeSwap) ifAbsent: [ nil ].
	self changed: #itemsList with: self.
]

{ #category : #accessing }
AInvoiceModel >> secdondName [
	^ self contractor, ' - ', self organization
]

{ #category : #accessing }
AInvoiceModel >> secondName [
	^ self contractor, ' - ', self organization
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
AInvoiceModel >> upItem [
	self items upAmount: (self accountEditor makeSwap).
	self changed: #itemsList with: self.
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
	self changed: #itemsList with: self.
]
