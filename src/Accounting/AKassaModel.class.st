"
Модель кассы

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
	organization:		<Object>
	priceAccount:		<Object>
	store:		<Object>


    Implementation Points
"
Class {
	#name : #AKassaModel,
	#superclass : #AModel,
	#instVars : [
		'number',
		'priceAccount',
		'organization',
		'store',
		'contractor',
		'contractorAccount',
		'date',
		'selection',
		'items',
		'currency',
		'clientSum',
		'accountEditor',
		'barcode',
		'priceFormer'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
AKassaModel class >> documents [
	^ self configClass kassaChecks
]

{ #category : #adding }
AKassaModel class >> nextIndex [
	^ self configClass nextKassaCheckIndex
]

{ #category : #operations }
AKassaModel >> accept [
	| sw res |
	sw := ASwapBuilder new.
	sw first add: self organization; add: self store.
	sw second add: self contractor.
	sw firstAmounts add: (AAmount new amount: self sum asNumber; add: self currency; yourself).
	sw secondAmounts: self items amounts.
	res := sw build.
	self cancelAccepted.
	self accounts addAll: res.
	self savedAccounts: res.
	^ res.
]

{ #category : #accessing }
AKassaModel >> accountEditor [
	^ accountEditor ifNil: [ accountEditor := AAccountEditor new ]
]

{ #category : #accessing }
AKassaModel >> accountEditor: anAccountEditor [
	accountEditor := anAccountEditor
]

{ #category : #actions }
AKassaModel >> addGoods [
	self priceFormer destination
		ifNotNil: [ :el| 
			self items addAmount: el.
			self accountEditor updateEditor: el.
			barcode := ''.
			self
				changed: #itemsList with: self;
				changed: #sum;
				changed: #change;
				changed: #clientSum;
				changed: #barcode].
]

{ #category : #operations }
AKassaModel >> addItem [
	| a div |
	a := self accountEditor makeSwap.
	div := a amount.
	a amount: 1.
	a swapAmount amount: (a swapAmount amount / div) asFloat.
	self items addAmount: a.
	self changeResult.
]

{ #category : #accessing }
AKassaModel >> barcode [
	^ barcode ifNil: [ barcode := '' ]
]

{ #category : #accessing }
AKassaModel >> barcode: aBarcode [
	barcode := aBarcode.
	self priceFormer barcode: aBarcode.
	self addGoods.
	self changed: #barcode.
]

{ #category : #operations }
AKassaModel >> change [
	| s cs |
	s := self sum.
	[s asNumber] on: Error do: [ :ex| ^ '' ].
	cs := self clientSum.
	[cs asNumber] on: Error do: [ :ex| ^ '' ].
	^ ((self clientSum asNumber) - (self sum asNumber)) asString
	
]

{ #category : #operations }
AKassaModel >> change: anObject [

]

{ #category : #operations }
AKassaModel >> changeResult [
	self changed: #sum;
		changed: #clientSum;
		changed: #change.
]

{ #category : #accessing }
AKassaModel >> clientSum [
	^ clientSum ifNil: [ clientSum := '' ].
	
]

{ #category : #accessing }
AKassaModel >> clientSum: anObject [
	clientSum := anObject.
	self changed: #clientSum.
	self changed: #change.
]

{ #category : #accessing }
AKassaModel >> contractor [
	^ contractor ifNil: [ contractor := '' ].
]

{ #category : #accessing }
AKassaModel >> contractor: anObject [
	contractor := anObject.
	self changed: #contractor
]

{ #category : #accessing }
AKassaModel >> contractorAccount [
	^ contractorAccount ifNil: [ contractorAccount := '' ].
]

{ #category : #accessing }
AKassaModel >> contractorAccount: anObject [
	contractorAccount := anObject.
	self changed: #contractorAccount
]

{ #category : #accessing }
AKassaModel >> convertDate [
	^ (DateParser readingFrom: (ReadStream on: self date) pattern: 'd.mm.yyyy') parse
]

{ #category : #actions }
AKassaModel >> createAccounts [
	| builder |
	builder := AVirtualSwapBuilder new.
	builder first addAll: self createFirsts.
	builder second addAll: self createSeconds.
	builder right add: self contractName.
	builder left add: self contractObligationName.
	builder common addAll: { self numberPrefix, number.}.
	builder swaps: self items.
	^ builder build.
]

{ #category : #actions }
AKassaModel >> createFirsts [
	|firsts d|
	d := self convertDate.
	firsts := Set new.
	firsts add: organization.
	firsts add: (self yearPrefix, d year asString).
	firsts add: (self monthPrefix, d monthIndex asString).
	firsts add: (self dayPrefix, d dayOfMonth asString).
	^ firsts.
]

{ #category : #copying }
AKassaModel >> createNextCheck [
	| km |
	km := self class addNew.
	km priceAccount: self priceAccount.
	km organization: self organization.
	km store: self store.
	km contractor: self contractor.
	km currency: self currency.
	km clientSum: ''.
	^ km
]

{ #category : #actions }
AKassaModel >> createSeconds [
	|seconds d |
	d := self convertDate.
	seconds := Set new.
	seconds add: self contractor.
	seconds add: (self yearPrefix, d year asString).
	seconds add: (self monthPrefix, d monthIndex asString).
	seconds add: (self dayPrefix, d dayOfMonth asString).
	^ seconds
]

{ #category : #accessing }
AKassaModel >> currency [
	^ currency ifNil: [ currency := '' ]
]

{ #category : #accessing }
AKassaModel >> currency: anObject [
	currency := anObject.
	self priceFormer currency: currency.
	self changed: #currency
]

{ #category : #accessing }
AKassaModel >> date [
	^ date ifNil: [ date := self today ].
]

{ #category : #accessing }
AKassaModel >> date: anObject [
	date := anObject.
	self changed: #date
]

{ #category : #initialization }
AKassaModel >> initializeSelection: anAnnouncer [
	anAnnouncer
		when: MorphTreeSelectionChanged
		do: [ :a | (a selection lastSelectedNode) ifNotNil: [ :n|
								self accountEditor updateEditor: n item ] ].
]

{ #category : #accessing }
AKassaModel >> items [
	^ items ifNil: [ items := AAccount new ]
]

{ #category : #accessing }
AKassaModel >> items: anObject [
	items := anObject
]

{ #category : #accessing }
AKassaModel >> itemsList [
	| itemsList |
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
		columnLabel: 'Sum' translated
		selector: #swapAmount
		morph: [ :v :c| 
			c startWidth: 50.
			v amount asString].
		
	itemsList
		columnLabel: 'Goodies' translated, ' 2'
		selector: #swapAmount
		morph: [ :v :c | 
			| col |
			c startWidth: 50.
			col := v asOrderedCollection.
			(col isEmpty
				ifFalse: [ col first asString ]
				ifTrue: [ '' ]) asMorph ].
			
	itemsList rootItems: self items amounts.
	^ itemsList
]

{ #category : #operations }
AKassaModel >> minusItem [
	| a div |
	a := self accountEditor makeSwap.
	div := a amount.
	a amount: 1.
	a swapAmount amount: (a swapAmount amount / div) asFloat.
	self items difAmount: a.
	self changeResult.
]

{ #category : #rendering }
AKassaModel >> morphController [
	^ FDirectController new.
]

{ #category : #rendering }
AKassaModel >> morphRenderer [
	^ AKassaMorphRenderer new
]

{ #category : #rendering }
AKassaModel >> morphView [
	^ self morphController
			listen: #yourself from: self.
]

{ #category : #rendering }
AKassaModel >> morphViewInWindow [
	| m w |
	m := self morphView.
	w := StandardWindow new.
	w title: (self number, ' ', 'Payment' translated).
	w addMorph: m frame: LayoutFrame new.
	w open.
	^ m
]

{ #category : #accessing }
AKassaModel >> number [
	^ number ifNil: [ number := '' ]
]

{ #category : #accessing }
AKassaModel >> number: anObject [
	number := anObject.
	self changed: #number.
]

{ #category : #opening }
AKassaModel >> open [
	^ AKassaCheckGlamour openOn: self
]

{ #category : #accessing }
AKassaModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
AKassaModel >> organization: anObject [
	organization := anObject.
	self priceFormer organization: organization.
	self changed: #organization
]

{ #category : #accessing }
AKassaModel >> priceAccount [
	^ priceAccount ifNil: [ priceAccount := '' ]
]

{ #category : #accessing }
AKassaModel >> priceAccount: anObject [
	priceAccount := anObject.
	self priceFormer priceAccount: anObject.
	self changed: #priceAccount
]

{ #category : #accessing }
AKassaModel >> priceFormer [
	^ priceFormer ifNil: [ 
		priceFormer := APriceFormer new
			currency: self currency;
			organization: self organization;
			yourself ]
]

{ #category : #operations }
AKassaModel >> removeItem [
	self items amounts remove: (self accountEditor makeSwap) ifAbsent: [  ].
	self changeResult.
]

{ #category : #actions }
AKassaModel >> searchItem [
	| p m returnAnswer |
	[
		returnAnswer := AReturnAnswer new.
		m := ABarcodeSelectorModel new.
		m answer: returnAnswer.
		m open.
		p := returnAnswer waitAnswer.
		self priceFormer source: p.
		self addGoods.
	] fork.
]

{ #category : #accessing }
AKassaModel >> selection [
	^ selection
]

{ #category : #accessing }
AKassaModel >> selection: anObject [
	selection := anObject.
	self changed: #selection.
	self accountEditor updateEditor: anObject.
]

{ #category : #accessing }
AKassaModel >> store [
	^ store ifNil: [ store := '' ]
]

{ #category : #accessing }
AKassaModel >> store: anObject [
	store := anObject.
	self changed: #store
]

{ #category : #accessing }
AKassaModel >> sum [
	^ (self items amounts
		inject: 0 into: [ :sum :el| sum + el swapAmount amount ]) asString
]

{ #category : #accessing }
AKassaModel >> sum: aSum [
	self changed: #sum
]
