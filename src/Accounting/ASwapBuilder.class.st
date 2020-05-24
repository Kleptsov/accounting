"
Модель обмена

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ASwapBuilder,
	#superclass : #ABuilder,
	#instVars : [
		'common',
		'first',
		'second',
		'firstAmounts',
		'secondAmounts',
		'result'
	],
	#category : #'Accounting-Building'
}

{ #category : #operations }
ASwapBuilder >> build [
	|acc1 acc2|
	acc1 := self buildFirst.
	acc2 := self buildSecond.
	result := { acc1. acc2 } asOrderedCollection.
	^ result.
]

{ #category : #operations }
ASwapBuilder >> buildFirst [
	|f|
	f := AAccount new.
	f addAll: common; addAll: first.
	f addAmounts: (firstAmounts collect: [ :a| a clone]).
	f addAmounts: (secondAmounts collect:[ :a| a clone invert]).
	^ f.

]

{ #category : #operations }
ASwapBuilder >> buildSecond [
	|s|
	s := AAccount new.
	s addAll: common; addAll: second.
	s addAmounts: (secondAmounts collect: [ :a| a clone]) .
	s addAmounts: (firstAmounts collect:[ :a| a clone invert]).
	^ s.

]

{ #category : #accessing }
ASwapBuilder >> common [
	^ common
]

{ #category : #accessing }
ASwapBuilder >> common: anObject [
	common := anObject
]

{ #category : #accessing }
ASwapBuilder >> first [
	^ first
]

{ #category : #accessing }
ASwapBuilder >> first: anObject [
	first := anObject
]

{ #category : #accessing }
ASwapBuilder >> firstAmounts [
	^ firstAmounts
]

{ #category : #accessing }
ASwapBuilder >> firstAmounts: anObject [
	firstAmounts := anObject
]

{ #category : #initialization }
ASwapBuilder >> initialize [
	super initialize.
	common := ATags new.
	first := ATags new.
	second := ATags new.
	firstAmounts := OrderedCollection new.
	secondAmounts := OrderedCollection new.
	result := OrderedCollection new.
]

{ #category : #accessing }
ASwapBuilder >> second [
	^ second
]

{ #category : #accessing }
ASwapBuilder >> second: anObject [
	second := anObject
]

{ #category : #accessing }
ASwapBuilder >> secondAmounts [
	^ secondAmounts
]

{ #category : #accessing }
ASwapBuilder >> secondAmounts: anObject [
	secondAmounts := anObject
]

{ #category : #accessing }
ASwapBuilder >> swaps: someSwaps [
	someSwaps amounts do: [ :s|
		firstAmounts add: (AAmount new amount: (s amount); addAll: s; yourself).
		secondAmounts add: (s swapAmount clone).	
	]
]
