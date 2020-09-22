"
Модель цен 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #APriceModel,
	#superclass : #AModel,
	#instVars : [
		'organization',
		'date',
		'items',
		'number',
		'baseAmount',
		'selection',
		'accountEditor'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
APriceModel class >> documents [
	^ self configClass prices
]

{ #category : #adding }
APriceModel class >> nextIndex [
	^ self configClass nextPriceIndex
]

{ #category : #actions }
APriceModel >> accept [
	| vs result t |
	t := Time
		millisecondsToRun: [ self cancelAccepted.
			vs := AVirtualSwapBuilder new.
			vs right add: self priceName , self number.
			vs left add: self contraPriceName , self number.
			vs first add: self organization.
			vs second add: self configClass emptyAccountName.
			vs firstAmounts: self items amounts.
			result := vs build.
			self accounts addAll: result.
			self savedAccounts: result.
			result do: [ :el | self accounts add: el ] ].
	self
		trace:
			self number , ' price document is created. Milliseconds to run: '
				, t asString , String cr
]

{ #category : #accessing }
APriceModel >> accountEditor [
	^ accountEditor ifNil: [ accountEditor := AAccountEditor new ].
]

{ #category : #accessing }
APriceModel >> accountEditor: anAccountEditor [
	accountEditor := anAccountEditor.
]

{ #category : #actions }
APriceModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
]

{ #category : #actions }
APriceModel >> addItem [
	| swap baseConvert mul |
	swap := self accountEditor makeSwap.
	baseConvert := self baseConvert: (swap swapAmount).
	mul := swap amount / (swap swapAmount amount / baseConvert amount).
	swap amount: mul.
	self items updateOrAddAmount: swap asAmount.
]

{ #category : #accessing }
APriceModel >> baseAmount [
	^ baseAmount ifNil: [ '' ]
]

{ #category : #accessing }
APriceModel >> baseAmount: anObject [
	baseAmount := anObject.
	self changed: #baseAmount.
]

{ #category : #actions }
APriceModel >> baseConvert: anAmount [
	| bs |
	(self items amounts like: anAmount)
		ifNil: [ bs := AAmount new amount: 1 ]
		ifNotNil: [ :a| bs := a asAmount ].
	^ bs.
]

{ #category : #accessing }
APriceModel >> basePrice [
	^ (self baseConvert: (AAmount new add: baseAmount; amount: 1)) amount
]

{ #category : #accessing }
APriceModel >> baseRelation [
	| r r2 |
	r := AAmount new add: self baseAmount; yourself.
	r2 := self items like: r.
	r2 ifNil: [ r2 := r. 	r2 amount: 1 ]
		ifNotNil: [ r2 := r2 clone ].
	^ r2
]

{ #category : #copying }
APriceModel >> clone [
	| p |
	p := self class addNew.
	p organization: self organization.
	p baseAmount: self baseAmount.
	p items addAccount: self items.
	^ p
]

{ #category : #accessing }
APriceModel >> date [
	^ date ifNil: [ date := self today ]
]

{ #category : #accessing }
APriceModel >> date: anObject [
	date := anObject.
	self changed: #date
]

{ #category : #accessing }
APriceModel >> items [
	^ items ifNil: [ items := AAccount new ]
]

{ #category : #accessing }
APriceModel >> items: anObject [
	items := anObject
]

{ #category : #actions }
APriceModel >> makeKassa [
	| kassa |
	kassa := AKassaModel addNew.
	kassa priceAccount: self configClass priceName , self number.
	kassa organization: self organization.
	kassa currency: self baseAmount.
	kassa contractor: 'User'.
	^ kassa
]

{ #category : #accessing }
APriceModel >> number [
	^ number ifNil: [ number := '' ]
]

{ #category : #accessing }
APriceModel >> number: anObject [
	number := anObject.
	self changed: #number
]

{ #category : #actions }
APriceModel >> open [
	^ APriceGlamour openOn: self
]

{ #category : #accessing }
APriceModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
APriceModel >> organization: anObject [
	organization := anObject.
	self changed: #organization
]

{ #category : #actions }
APriceModel >> priceFor: anAmount [
	|sw|
	sw := anAmount asSwap.
	sw amount: 1.
	sw swapAmount:
		(AAmount new add: self baseAmount;
		amount: (self basePrice / anAmount amount) asFloat).
	^ sw
]

{ #category : #actions }
APriceModel >> removeAccounts [
	| acc acc2 |
	acc := AAccount new add: (self priceName, self number); yourself.
	self accounts remove: acc.
	acc2 := AAccount new add: (self contraPriceName, self number); yourself.
	self accounts remove: acc2.
]

{ #category : #actions }
APriceModel >> removeItem [
	self items amounts
		remove: self accountEditor makeSwap
		ifAbsent: [ ].
]

{ #category : #actions }
APriceModel >> searchItem [
	| el |
	[el := ABarcodeSelectorModel new openModal.
	el ifNotNil: [ self updateEditor: el ]] fork.
]

{ #category : #accessing }
APriceModel >> selection [
	^ selection
]

{ #category : #accessing }
APriceModel >> selection: anObject [
	|sel b |
	sel := anObject asSwap clone.
	b := self baseRelation.
	sel swapAmount amount: (b amount / sel amount).
	sel amount: 1.
	sel swapAmount add: self baseAmount.
	self accountEditor updateEditor: sel.
	selection := sel.
	self changed: #selection
]
