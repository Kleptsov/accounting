"
Обмен величин

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ASwap,
	#superclass : #AAmount,
	#instVars : [
		'swapAmount'
	],
	#category : #'Accounting-Core'
}

{ #category : #'value operations' }
ASwap >> addAmount: anAmount [
	self initializeVal.
	self val plus: anAmount val.
	anAmount class = self class ifFalse: [ ^ self ].
	self swapAmount. anAmount swapAmount. "lazy initialization"
	swapAmount val plus: anAmount swapAmount val.
	"amount := amount + anAmount amount.
	anAmount class = self class
		ifTrue: [ swapAmount
						ifNil: [ swapAmount := anAmount swapAmount clone ]
						ifNotNil: [ anAmount swapAmount
											ifNotNil: [ swapAmount amount: swapAmount amount + anAmount swapAmount amount ] ] ]"
]

{ #category : #converting }
ASwap >> asAmount [
	| inst |
	inst := AAmount new.
	inst addAll: self.
	inst amount: self amount.
	^ inst
]

{ #category : #copying }
ASwap >> clone [
	| instance |
	instance := self class new.
	instance amount: self amount.
	instance addAll: self.
	instance swapAmount: self swapAmount clone.
	instance update.
	^ instance
]

{ #category : #'value operations' }
ASwap >> difAmount: anAmount [
	self initializeVal.
	self val minus: anAmount val.
	anAmount class = self class ifFalse: [ ^ self ].
	self swapAmount. anAmount swapAmount. "lazy initialization"
	swapAmount val minus: anAmount swapAmount val.
	"amount := amount - anAmount amount.
	anAmount class = self class
		ifTrue: [ swapAmount
						ifNil: [ swapAmount := anAmount swapAmount clone invert ]
						ifNotNil: [ anAmount swapAmount
											ifNotNil: [ swapAmount amount: swapAmount amount - anAmount swapAmount amount ] ] ]"
]

{ #category : #'value operations' }
ASwap >> initializeVal [
	super initializeVal.
	self swapAmount initializeVal.
]

{ #category : #printing }
ASwap >> printCSVOn: aStream [
	super printCSVOn: aStream.
	aStream nextPut: $,.
	swapAmount printCSVOn: aStream.
]

{ #category : #printing }
ASwap >> printOn: aStream [
	aStream nextPutAll: (self amount round: 4) asString.
	self do: [ :t| aStream nextPutAll: ' '; nextPutAll: t ].
	aStream nextPutAll: ' = '.
	swapAmount printOn: aStream.
	"aStream
		nextPutAll: (amount round: 4) asString.
	self do: [ :t|
		aStream nextPutAll: ' ';
			nextPutAll: t ].
	aStream nextPutAll: ' = '.
	swapAmount printOn: aStream."
]

{ #category : #accessing }
ASwap >> swapAmount [
	^ swapAmount ifNil: [ swapAmount := AAmount new ]
]

{ #category : #accessing }
ASwap >> swapAmount: anObject [
	swapAmount := anObject
]
