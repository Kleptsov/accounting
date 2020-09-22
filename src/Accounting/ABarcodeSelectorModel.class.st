"
Просмотр, добавление, удаление и выбор элементов имеющие штрихкод.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	accountEditor:		<Object>
	items:		<Object>


    Implementation Points
"
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

{ #category : #accessing }
ABarcodeSelectorModel >> accountEditor [
	^ accountEditor ifNil: [ accountEditor := AAccountEditor new ]
]

{ #category : #accessing }
ABarcodeSelectorModel >> accountEditor: anObject [
	accountEditor := anObject
]

{ #category : #actions }
ABarcodeSelectorModel >> addItem [
	| acc |
	acc := self accountEditor makeSwap asAccount.
	self items remove: acc ifAbsent: [ ].
	self items add: acc.
]

{ #category : #accessing }
ABarcodeSelectorModel >> items [
	^ AConfig barcodes accIndexes.
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
	| acc |
	acc := self accountEditor makeSwap asAccount.
	self items
		remove: acc
		ifAbsent: [ ].
]

{ #category : #accessing }
ABarcodeSelectorModel >> return [
	^ self answer: self accountEditor makeSwap swapAmount
]

{ #category : #accessing }
ABarcodeSelectorModel >> strongSelection: aSelection [
	self accountEditor updateEditor: aSelection.
	^ self return
]
