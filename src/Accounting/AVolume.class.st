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
	#name : #AVolume,
	#superclass : #Object,
	#instVars : [
		'plus',
		'minus'
	],
	#category : #'Accounting-Core'
}

{ #category : #accessing }
AVolume >> minus [
	minus ifNil: [ minus := 0 ]
]

{ #category : #accessing }
AVolume >> minus: aValue [
	minus ifNil: [ minus := 0 ].
	minus := minus - aValue.
]

{ #category : #accessing }
AVolume >> plus [
	^ plus ifNil: [ plus := 0 ].
	
]

{ #category : #accessing }
AVolume >> plus: aValue [
	plus ifNil: [ plus := 0 ].
	plus := plus + aValue.
]

{ #category : #accessing }
AVolume >> value [
	^ self plus - self minus.
]

{ #category : #accessing }
AVolume >> value: aValue [
	aValue > 0 ifTrue: [ self plus: aValue ].
	aValue < 0 ifTrue: [ self minus: aValue ].
]
