Class {
	#name : #APriceFormer,
	#superclass : #Object,
	#instVars : [
		'currency',
		'priceAccount',
		'organization',
		'prices',
		'source',
		'destination',
		'relation'
	],
	#category : #'Accounting-Model'
}

{ #category : #accessing }
APriceFormer >> accountsStore [
	^ AConfig accounts
]

{ #category : #operations }
APriceFormer >> barcode: aBarcode [
	| resultAmount |
	resultAmount := self barcodeStore
		select: (AAccount new add: aBarcode; yourself)
		at: 1.
	resultAmount isEmpty
		ifTrue: [ destination := nil. ]
		ifFalse: [ source := resultAmount.
					self makeDestination ]
]

{ #category : #accessing }
APriceFormer >> barcodeStore [
	^ AConfig barcodes
]

{ #category : #accessing }
APriceFormer >> currency [
	^ currency
]

{ #category : #accessing }
APriceFormer >> currency: anObject [
	currency := anObject
]

{ #category : #accessing }
APriceFormer >> destination [
	^ destination
]

{ #category : #accessing }
APriceFormer >> destination: anObject [
	^ destination := anObject
]

{ #category : #operations }
APriceFormer >> makeDestination [
	self makePrices.
	self makeRelation.
	self makeGoodsRelation.
]

{ #category : #operations }
APriceFormer >> makeGoodsRelation [
	| divider |
	(prices amounts like: source)
		ifNil: [ destination := nil ]
		ifNotNil: [ :goods| destination := goods clone asSwap.
			divider := destination amount.
			destination amount: 1.
			destination swapAmount
				amount: (divider = 0 ifFalse: [(1 / divider) asFloat] ifTrue: [ 0.0000000000001 ] );
				add: currency ].
]

{ #category : #operations }
APriceFormer >> makePrices [
	| acc |
	acc :=  AAccount new
			add: priceAccount;
			add: organization;
			yourself.
	prices := self accountsStore select: acc.
]

{ #category : #operations }
APriceFormer >> makeRelation [
	(prices amounts like: (AAmount new add: currency; yourself))
		ifNil: [ relation := 1 ]
		ifNotNil: [ :acc| relation := acc amount ].
]

{ #category : #accessing }
APriceFormer >> organization [
	^ organization
]

{ #category : #accessing }
APriceFormer >> organization: anObject [
	organization := anObject
]

{ #category : #accessing }
APriceFormer >> priceAccount [
	^ priceAccount
]

{ #category : #accessing }
APriceFormer >> priceAccount: anObject [
	priceAccount := anObject
]

{ #category : #operations }
APriceFormer >> source: aSource [
	source := aSource.
	self makeDestination.
	^ destination
]
