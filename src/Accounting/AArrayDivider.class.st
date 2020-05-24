"
Разделитель массива для двух счетов

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AArrayDivider,
	#superclass : #Object,
	#instVars : [
		'array',
		'array1',
		'array2'
	],
	#category : #'Accounting-Building'
}

{ #category : #accessing }
AArrayDivider >> array [
	^ array
]

{ #category : #accessing }
AArrayDivider >> array1 [
	^ array1
]

{ #category : #accessing }
AArrayDivider >> array1: anObject [
	array1 := anObject
]

{ #category : #accessing }
AArrayDivider >> array2 [
	^ array2
]

{ #category : #accessing }
AArrayDivider >> array2: anObject [
	array2 := anObject
]

{ #category : #accessing }
AArrayDivider >> array: anObject [
	array := anObject
]

{ #category : #actions }
AArrayDivider >> divide [
	| step |
	step := 1.
	array do: [ :el| 
		el asString = '=' ifTrue: [ step := 2 ].
		step = 1 ifTrue: [ array1 add: el ].
		step = 3 ifTrue: [ array2 add: el ].
		step = 2 ifTrue: [ step := 3 ].
	].
	^ Array with: array1 with: array2.
]

{ #category : #initialization }
AArrayDivider >> initialize [
	super initialize.
	array1 := Set new.
	array2 := Set new.
]
