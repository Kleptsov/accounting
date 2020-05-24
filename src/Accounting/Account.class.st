"
Счет учета. Содержит ассоциированное имя счета, величину счета и содержимое счета

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #Account,
	#superclass : #AbstractAccount,
	#instVars : [
		'amount',
		'items'
	],
	#category : #'Accounting-Core'
}

{ #category : #operations }
Account >> addAccount: anAccount [
	anAccount items do: [ :item|
		(self items like: item)
			ifNil: [ items add: (item cloneWithoutItems) ]
			ifNotNil: [ :itm| itm addAmount: item ] ]
]

{ #category : #operations }
Account >> addAmount: anAmountOrItem [
	anAmountOrItem isNumber
		ifTrue: [ self amount: (self amount + anAmountOrItem) ]
		ifFalse: [ self amount: (self amount + (anAmountOrItem amount) ) ]
]

{ #category : #operations }
Account >> addItems: anAccount [
	anAccount items do: [ :item|
		(self items like: item)
			ifNil: [ items add: (item cloneWithoutItems) ]
			ifNotNil: [ :itm| itm addAmount: item ] ]
]

{ #category : #copying }
Account >> allAccountVariants [
	^ self allVariants
		collect: [ :el|
			self class new
					addAll: el;
					addAccount: self;
					yourself ].
	
]

{ #category : #copying }
Account >> allVariants [
	^ AllVariantsBuilder new
			sourceColl: self asOrderedCollection;
			build.
]

{ #category : #accessing }
Account >> amount [
	^ amount ifNil: [ amount := 0 ]
]

{ #category : #accessing }
Account >> amount: anAmount [
	amount := anAmount asNumber.
]

{ #category : #copying }
Account >> clone [
	| a |
	a := self cloneWithoutItems.
	self items
		collect: [ :item| item cloneWithoutItems ] into: a items.
	^ a.
]

{ #category : #copying }
Account >> cloneWithoutItems [
	| a |
	a := self class new.
	a amount: self amount.
	self collect: [ :el| el ] into: a.
	^ a.
]

{ #category : #operations }
Account >> difAccount: anAccount [
	anAccount items do: [ :item|
		(self items like: item)
			ifNil: [ items add: (item cloneWithoutItems invert) ]
			ifNotNil: [ :itm| itm difAmount: item ] ]
]

{ #category : #operations }
Account >> difAmount: anAmountOrItem [
	anAmountOrItem isNumber
		ifTrue: [ self amount: (self amount - anAmountOrItem) ]
		ifFalse: [ self amount: (self amount - (anAmountOrItem amount) ) ]
]

{ #category : #operations }
Account >> invert [
	self amount: (self amount * (-1))
]

{ #category : #operations }
Account >> invertItems [
	self items do: [ :item|
		item invert ]
]

{ #category : #accessing }
Account >> items [
	^ items ifNil: [ items := Set new ]
]

{ #category : #printing }
Account >> printCSVItemsOn: aStream [
	| size |
	size := self items size.
	self items do: [ :el|
		size := size - 1.
		el printCSVOn: aStream.
		size = 0 ifFalse: [ aStream nextPutAll: String cr. ] ]
]

{ #category : #printing }
Account >> printCSVOn: aStream [
	|size|
	aStream nextPutAll: self amount asString;
		nextPut: $,;
		nextPut: $".
	size := self size.
	self do: [ :tag|
		size := size - 1.
		aStream nextPutAll: tag asString.
		size = 0 ifFalse: [ aStream nextPut: Character space ]
	].
	aStream nextPut: $".
]
