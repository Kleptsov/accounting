Class {
	#name : #AAccountExplorerModel,
	#superclass : #AModel,
	#instVars : [
		'items',
		'selection',
		'accountEditor'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
AAccountExplorerModel class >> documents [
	^ self configClass prices
]

{ #category : #adding }
AAccountExplorerModel class >> nextIndex [
	^ self configClass nextPriceIndex
]

{ #category : #actions }
AAccountExplorerModel >> accept [
	^ {  }
]

{ #category : #accessing }
AAccountExplorerModel >> accountEditor [
	^ accountEditor ifNil: [ accountEditor := AAccountEditor new ]
]

{ #category : #accessing }
AAccountExplorerModel >> accountEditor: anAccountEditor [
	accountEditor := anAccountEditor
]

{ #category : #actions }
AAccountExplorerModel >> addItem [
	| swap baseConvert mul |
	swap := self accountEditor makeSwap.
	baseConvert := self baseConvert: (swap swapAmount).
	mul := swap amount / (swap swapAmount amount / baseConvert amount).
	swap amount: mul.
	self items updateOrAddAmount: swap asAmount.
]

{ #category : #copying }
AAccountExplorerModel >> clone [
	| p |
	p := self class addNew.
	p organization: self organization.
	p baseAmount: self baseAmount.
	p items addAccount: self items.
	^ p
]

{ #category : #accessing }
AAccountExplorerModel >> items [
	| a |
	a := AAccount new
		addAll: self accountEditor makeAccount; yourself.
	items := AConfig accounts select: a.
	^ items
]

{ #category : #accessing }
AAccountExplorerModel >> items: anObject [
	items := anObject
]

{ #category : #actions }
AAccountExplorerModel >> open [
	^ AAccountExplorerGlamour openOn: self
]

{ #category : #actions }
AAccountExplorerModel >> removeItem [
	self items amounts
		remove: self accountEditor makeSwap
		ifAbsent: [ ].
]

{ #category : #accessing }
AAccountExplorerModel >> selection [
	^ selection
]

{ #category : #accessing }
AAccountExplorerModel >> selection: anObject [
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
AAccountExplorerModel >> strongSelection: aSelection [
	self selection: aSelection.
	self answer: aSelection.
]
