"
Модель виртуального обмена.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AVirtualSwapBuilder,
	#superclass : #ASwapBuilder,
	#instVars : [
		'right',
		'left'
	],
	#category : #'Accounting-Building'
}

{ #category : #operations }
AVirtualSwapBuilder >> build [
	|acc1 acc2 acc3 acc4 |
	acc1 := self buildFirst.
	acc2 := self buildSecond.
	acc3 := self buildThird.
	acc4 := self buildFourth.
	result :=  { acc1. acc2. acc3. acc4 } asOrderedCollection.
	^ result.
]

{ #category : #operations }
AVirtualSwapBuilder >> buildFirst [
	|f|
	f := AAccount new.
	f addAll: common; addAll: first; addAll: right.
	f addAmounts: (firstAmounts collect:[ :a| a clone]).
	f addAmounts: (secondAmounts collect:[ :a| a clone invert]).
	^ f.
]

{ #category : #operations }
AVirtualSwapBuilder >> buildFourth [
	|s|
	s := AAccount new.
	s addAll: common; addAll: second; addAll: left.
	s addAmounts: (secondAmounts collect:[ :a| a clone invert]).
	s addAmounts: (firstAmounts collect:[ :a| a clone]).
	^ s.
]

{ #category : #operations }
AVirtualSwapBuilder >> buildSecond [
	|s|
	s := AAccount new.
	s addAll: common; addAll: second; addAll: right.
	s addAmounts: (secondAmounts collect:[ :a| a clone]).
	s addAmounts: (firstAmounts collect:[ :a| a clone invert]).
	^ s.

]

{ #category : #operations }
AVirtualSwapBuilder >> buildThird [
	|f|
	f := AAccount new.
	f addAll: common; addAll: first; addAll: left.
	f addAmounts: (firstAmounts collect:[ :a| a clone invert]).
	f addAmounts: (secondAmounts collect:[ :a| a clone]).
	^ f.
]

{ #category : #initialization }
AVirtualSwapBuilder >> initialize [
	super initialize.
	right := AAccount new.
	left := AAccount new.
]

{ #category : #accessing }
AVirtualSwapBuilder >> left [
	^ left
]

{ #category : #accessing }
AVirtualSwapBuilder >> left: anObject [
	left := anObject
]

{ #category : #accessing }
AVirtualSwapBuilder >> right [
	^ right
]

{ #category : #accessing }
AVirtualSwapBuilder >> right: anObject [
	right := anObject
]
