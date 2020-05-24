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
		'editor',
		'date',
		'items',
		'number',
		'baseAmount',
		'selection'
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
	t := Time millisecondsToRun: 
	[self removeAccounts.
	vs := AVirtualSwapBuilder new.
	vs right add: (self priceName, self number).
	vs left add: (self contraPriceName, self number).
	vs first add: self organization.
	vs second add: self configClass emptyAccountName.
	vs firstAmounts: self items amounts.
	result := vs build.
	result do: [ :el| self accounts add: el ] ].
	self log: self number, ' price document is created. Milliseconds to run: ', t asString, String cr.
	
]

{ #category : #actions }
APriceModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
]

{ #category : #actions }
APriceModel >> addItem [
	| swap baseSwap mul |
	swap := AAmountSwapBuilder new string: self editor; build.
	baseSwap := self baseSwap: (swap swapAmount).
	mul := swap amount / (swap swapAmount amount / baseSwap amount).
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

{ #category : #accessing }
APriceModel >> basePrice [
	^ (self baseSwap: (AAmount new add: baseAmount; amount: 1)) amount
]

{ #category : #actions }
APriceModel >> baseSwap: anAmount [
	| bs |
	(self items amounts like: anAmount)
		ifNil: [ bs := AAmount new amount: 1 ]
		ifNotNil: [ :a| bs := a asAmount ].
	^ bs.
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
APriceModel >> editor [
	^ editor ifNil: [ editor := '' ]
]

{ #category : #accessing }
APriceModel >> editor: anObject [
	editor := anObject asString.
	self changed: #editor
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
	self items amounts remove: self selection ifAbsent: [ ].
]

{ #category : #accessing }
APriceModel >> selection [
	^ selection
]

{ #category : #accessing }
APriceModel >> selection: anObject [
	selection := anObject.
	self editor: anObject.
	self changed: #selection
]
