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
		'barcode'
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

{ #category : #operations }
AKassaModel >> addNewGoodies [
	| sw |
	sw := self accountEditor makeSwap.
	self items addAmount: sw.
	self changed: #sum
]

{ #category : #operations }
AKassaModel >> barcode [
	^ barcode ifNil: [ barcode := '' ]
]

{ #category : #operations }
AKassaModel >> barcode: anObject [
	barcode := anObject.
	self updateAccountItems.
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
	self changed: #currency
]

{ #category : #operations }
AKassaModel >> currencyRelation [
	| a p |
	a := AAccount new add: self currency; yourself.
	p := self pricesAccount.
	(p amounts like: a)
		ifNil: [ ^ 1 ]
		ifNotNil: [ :acc| ^ acc amount ].
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

{ #category : #operations }
AKassaModel >> goodsRelation: anAccount [
	| p |
	p := self pricesAccount.
	(p amounts like: anAccount)
		ifNil: [ ^ nil ]
		ifNotNil: [ :acc| ^ acc amount ].
]

{ #category : #accessing }
AKassaModel >> items [
	^ items ifNil: [ items := AAccount new ]
]

{ #category : #accessing }
AKassaModel >> items: anObject [
	items := anObject
]

{ #category : #operations }
AKassaModel >> makeCurrency: somePrices [
	| cur |
	cur := somePrices amounts like: (AAccount new add: self currency; yourself).
	^ cur.
	
]

{ #category : #operations }
AKassaModel >> makePrices [
	| acc prices |
	acc :=  AAccount new
			add: self priceAccount;
			add: self organization;
			yourself.
	prices := self accounts select: acc.
	^ prices
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
	self changed: #organization
]

{ #category : #accessing }
AKassaModel >> priceAccount [
	^ priceAccount ifNil: [ priceAccount := '' ]
]

{ #category : #accessing }
AKassaModel >> priceAccount: anObject [
	priceAccount := anObject.
	self changed: #priceAccount
]

{ #category : #operations }
AKassaModel >> priceFor: anObject [
	| prices priceGoods cur sum goods |
	prices := self makePrices.
	priceGoods := prices amounts like: anObject.
	priceGoods ifNil: [ self inform: 'price not found'. ^ false ].
	cur := self makeCurrency: prices.
	cur ifNil: [ self inform: 'currency not found'. ^ false ].
	sum := (cur amount / priceGoods amount) asFloat.
	goods := anObject clone swapAmount: (cur clone amount: sum); amount: 1.
	self items addAmount: goods.
	self inform: 'Added'.
	^ true.
	
]

{ #category : #accessing }
AKassaModel >> pricesAccount [
	| pt |
	pt := AAccount new
		add: self organization;
		add: self priceAccount;
		yourself.
	^ AConfig accounts select: pt.
]

{ #category : #operations }
AKassaModel >> removeItem [
	self items amounts remove: (self accountEditor makeSwap) ifAbsent: [  ].
	self changeResult.
]

{ #category : #actions }
AKassaModel >> searchItem [
	| p |
	[p := APriceSelectorModel new openModal.
	p ifNil: [ ^ self ].
	self accountEditor updateEditor: p] fork
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

{ #category : #operations }
AKassaModel >> updateAccountItems [
	| sw |
	sw := super updateAccountItems.
	sw isEmpty ifTrue: [ ^ self ].
	sw := sw asSwap.
	(self goodsRelation: sw) ifNil: [ ^ self ]
		ifNotNil: [ :s| sw amount: s ].
	sw swapAmount amount: self currencyRelation.
	sw swapAmount amount: (sw swapAmount amount / sw amount).
	sw amount: 1.
	sw swapAmount add: self currency.
	self items addAmount: sw.
	self accountEditor updateEditor: sw.
	self changed: #sum.
	barcode := ''. self changed: #barcode.
	^ sw
]
