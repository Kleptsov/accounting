"
Создание товарной величины из массива

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	amount:		<Object>
	array:		<Object>


    Implementation Points
"
Class {
	#name : #AAmountBuilder,
	#superclass : #Object,
	#instVars : [
		'amount',
		'array'
	],
	#category : #'Accounting-Building'
}

{ #category : #'instance creation' }
AAmountBuilder class >> fromArray: anArray [
	^ self new
		array: anArray;
		build.
]

{ #category : #accessing }
AAmountBuilder >> amount [
	^ amount
]

{ #category : #accessing }
AAmountBuilder >> amount: anObject [
	amount := anObject
]

{ #category : #accessing }
AAmountBuilder >> array [
	^ array
]

{ #category : #accessing }
AAmountBuilder >> array: anObject [
	array := anObject.
]

{ #category : #building }
AAmountBuilder >> build [
	self array do: [ :el|
		el isNumber
			ifTrue: [ amount amount: el ]
			ifFalse: [ amount add: el asString ] ].
	^ amount
]

{ #category : #initialization }
AAmountBuilder >> initialize [
	super initialize.
	amount := AAmount new.
]

{ #category : #accessing }
AAmountBuilder >> string: aString [
	array := (aString findTokens: ' ').
	array at: 1 put: (array at: 1) asNumber.
]
