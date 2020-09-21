Class {
	#name : #ABarcodeSelectorModel,
	#superclass : #AModel,
	#instVars : [
		'accountEditor',
		'items'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
ABarcodeSelectorModel class >> documents [
	^ self configClass prices
]

{ #category : #adding }
ABarcodeSelectorModel class >> nextIndex [
	^ self configClass nextPriceIndex
]

{ #category : #actions }
ABarcodeSelectorModel >> addItem [
	| swap |
	swap := self accountEditor makeSwap.
	self items updateOrAddAmount: swap asAmount.
]

{ #category : #accessing }
ABarcodeSelectorModel >> items [
	^ AConfig barcodes
]

{ #category : #accessing }
ABarcodeSelectorModel >> items: anObject [
]

{ #category : #actions }
ABarcodeSelectorModel >> open [
	^ ABarcodeSelectorGlamour openOn: self
]

{ #category : #actions }
ABarcodeSelectorModel >> removeItem [
	self items amounts
		remove: self accountEditor makeSwap
		ifAbsent: [ ].
]

{ #category : #accessing }
ABarcodeSelectorModel >> strongSelection: aSelection [
	self selection: aSelection.
	self answer: aSelection.
]
