Class {
	#name : #APriceSelectorModel,
	#superclass : #AModel,
	#instVars : [
		'organization',
		'items',
		'number',
		'baseAmount',
		'selection'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
APriceSelectorModel class >> documents [
	^ self configClass prices
]

{ #category : #adding }
APriceSelectorModel class >> nextIndex [
	^ self configClass nextPriceIndex
]

{ #category : #actions }
APriceSelectorModel >> accept [
	^ {  }
]

{ #category : #actions }
APriceSelectorModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
]

{ #category : #actions }
APriceSelectorModel >> addItem [
	| swap baseConvert mul |
	swap := self accountEditor makeSwap.
	baseConvert := self baseConvert: (swap swapAmount).
	mul := swap amount / (swap swapAmount amount / baseConvert amount).
	swap amount: mul.
	self items updateOrAddAmount: swap asAmount.
]

{ #category : #accessing }
APriceSelectorModel >> baseAmount [
	^ baseAmount ifNil: [ '' ]
]

{ #category : #accessing }
APriceSelectorModel >> baseAmount: anObject [
	baseAmount := anObject.
	self changed: #baseAmount.
]

{ #category : #actions }
APriceSelectorModel >> baseConvert: anAmount [
	| bs |
	(self items amounts like: anAmount)
		ifNil: [ bs := AAmount new amount: 1 ]
		ifNotNil: [ :a| bs := a asAmount ].
	^ bs.
]

{ #category : #accessing }
APriceSelectorModel >> basePrice [
	^ (self baseConvert: (AAmount new add: baseAmount; amount: 1)) amount
]

{ #category : #accessing }
APriceSelectorModel >> baseRelation [
	| r r2 |
	r := AAmount new add: self baseAmount; yourself.
	r2 := self items like: r.
	r2 ifNil: [ r2 := r. 	r2 amount: 1 ]
		ifNotNil: [ r2 := r2 clone ].
	^ r2
]

{ #category : #copying }
APriceSelectorModel >> clone [
	| p |
	p := self class addNew.
	p organization: self organization.
	p baseAmount: self baseAmount.
	p items addAccount: self items.
	^ p
]

{ #category : #accessing }
APriceSelectorModel >> items [
	| a |
	a := AAccount new
		add: self number; add: self organization; yourself.
	items := AConfig accounts select: a.
	^ items
]

{ #category : #accessing }
APriceSelectorModel >> items: anObject [
	items := anObject
]

{ #category : #actions }
APriceSelectorModel >> makeKassa [
	| kassa |
	kassa := AKassaModel addNew.
	kassa priceAccount: self configClass priceName , self number.
	kassa organization: self organization.
	kassa currency: self baseAmount.
	kassa contractor: 'User'.
	^ kassa
]

{ #category : #accessing }
APriceSelectorModel >> number [
	^ number ifNil: [ number := '' ]
]

{ #category : #accessing }
APriceSelectorModel >> number: anObject [
	number := anObject.
	self changed: #number
]

{ #category : #actions }
APriceSelectorModel >> open [
	^ APriceSelectorGlamour openOn: self
]

{ #category : #accessing }
APriceSelectorModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
APriceSelectorModel >> organization: anObject [
	organization := anObject.
	self changed: #organization
]

{ #category : #actions }
APriceSelectorModel >> priceFor: anAmount [
	|sw|
	sw := anAmount asSwap.
	sw amount: 1.
	sw swapAmount:
		(AAmount new add: self baseAmount;
		amount: (self basePrice / anAmount amount) asFloat).
	^ sw
]

{ #category : #actions }
APriceSelectorModel >> removeAccounts [
	| acc acc2 |
	acc := AAccount new add: (self priceName, self number); yourself.
	self accounts remove: acc.
	acc2 := AAccount new add: (self contraPriceName, self number); yourself.
	self accounts remove: acc2.
]

{ #category : #actions }
APriceSelectorModel >> removeItem [
	self items amounts
		remove: self accountEditor makeSwap
		ifAbsent: [ ].
]

{ #category : #accessing }
APriceSelectorModel >> selection [
	^ selection
]

{ #category : #accessing }
APriceSelectorModel >> selection: anObject [
	|sel b |
	sel := anObject asSwap clone.
	b := self baseRelation.
	sel swapAmount amount: (b amount / sel amount).
	sel amount: 1.
	sel swapAmount add: self baseAmount.
	"self accountEditor updateEditor: sel."
	selection := sel.
	self changed: #selection
]

{ #category : #accessing }
APriceSelectorModel >> strongSelection: aSelection [
	self selection: aSelection.
	self answer: aSelection.
]
