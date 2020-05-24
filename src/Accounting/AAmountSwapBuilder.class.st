"
Создание обмена из массива или строки

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	amount1:		<Object>
	amount2:		<Object>
	array:		<Object>
	swap:		<Object>


    Implementation Points
"
Class {
	#name : #AAmountSwapBuilder,
	#superclass : #Object,
	#instVars : [
		'swap',
		'array',
		'amount1',
		'amount2'
	],
	#category : #'Accounting-Building'
}

{ #category : #'instance creation' }
AAmountSwapBuilder class >> fromArray: anArray [
	^ self new
		array: anArray;
		build
]

{ #category : #'instance creation' }
AAmountSwapBuilder class >> fromString: aString [
	^ self new
		string: aString;
		build
]

{ #category : #accessing }
AAmountSwapBuilder >> amount1 [
	^ amount1
]

{ #category : #accessing }
AAmountSwapBuilder >> amount1: anObject [
	amount1 := anObject
]

{ #category : #accessing }
AAmountSwapBuilder >> amount2 [
	^ amount2
]

{ #category : #accessing }
AAmountSwapBuilder >> amount2: anObject [
	amount2 := anObject
]

{ #category : #accessing }
AAmountSwapBuilder >> array [
	^ array
]

{ #category : #accessing }
AAmountSwapBuilder >> array: anObject [
	array := anObject
]

{ #category : #building }
AAmountSwapBuilder >> build [
	|d|
	d := AArrayDivider new array: array; divide.
	amount1 := AAmountBuilder new array: (d at: 1); build.
	amount2 := AAmountBuilder new array: (d at: 2); build.
	swap addAll: amount1; amount: amount1 amount.
	swap swapAmount: amount2.
	^ swap.
	
]

{ #category : #initialization }
AAmountSwapBuilder >> initialize [
	super initialize.
	swap := ASwap new.
]

{ #category : #accessing }
AAmountSwapBuilder >> string: aString [
	| accArray acc1Array acc2Array |
	accArray := aString asString findTokens: '='.
	acc1Array := (accArray at: 1) findTokens: ' '.
	acc2Array := (accArray at: 2) findTokens: ' '.
	acc1Array at: 1 put: (acc1Array at: 1) asNumber.
	acc2Array at: 1 put: (acc2Array at: 1) asNumber.
	array := acc1Array, { '=' }, acc2Array
]

{ #category : #accessing }
AAmountSwapBuilder >> swap [
	^ swap
]

{ #category : #accessing }
AAmountSwapBuilder >> swap: anObject [
	swap := anObject
]
