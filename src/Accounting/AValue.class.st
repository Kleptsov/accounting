"
AVolume хранит величину в двух измерениях увеличение и уменьшение. Т.е. накапливает увеличение и уменьшение.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	minus:		<Object>
	plus:		<Object>


    Implementation Points
"
Class {
	#name : #AValue,
	#superclass : #Object,
	#instVars : [
		'plus',
		'minus'
	],
	#category : #'Accounting-Core'
}

{ #category : #accessing }
AValue >> invert [
	|tmp|
	tmp := plus.
	plus := minus.
	minus := tmp.
]

{ #category : #accessing }
AValue >> minus [
	^ minus ifNil: [ minus := 0 ]
]

{ #category : #accessing }
AValue >> minus: aValue [
	self plus; minus.
	aValue isNumber
		ifTrue: [ plus := plus - aValue ]
		ifFalse: [	plus := plus - aValue plus.
						minus := minus - aValue minus. ]
]

{ #category : #accessing }
AValue >> plus [
	^ plus ifNil: [ plus := 0 ].
	
]

{ #category : #accessing }
AValue >> plus: aValue [
	self plus; minus.
	aValue isNumber
		ifTrue: [ plus := plus +aValue ]
		ifFalse: [	plus := plus + aValue plus.
						minus := minus + aValue minus. ]
]

{ #category : #printing }
AValue >> printOn: aStream [
	aStream nextPutAll: 'value('; nextPutAll: (self plus - self minus) asString; nextPutAll: ')'.
]

{ #category : #printing }
AValue >> printString [
	^ (self plus - self minus) asString
]

{ #category : #accessing }
AValue >> reset [
	plus := 0.
	minus := 0.
]

{ #category : #accessing }
AValue >> value [
	^ self plus - self minus.
]

{ #category : #accessing }
AValue >> value: aValue [
	aValue > 0 ifTrue: [ self plus: aValue ].
	aValue < 0 ifTrue: [ self minus: aValue ].
]
