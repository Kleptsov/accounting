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

{ #category : #operations }
ASwap >> addAmount: anAmount [
	amount := amount + anAmount amount.
	anAmount class = self class
		ifTrue: [ swapAmount
						ifNil: [ swapAmount := anAmount swapAmount clone ]
						ifNotNil: [ anAmount swapAmount
											ifNotNil: [ swapAmount amount: swapAmount amount + anAmount swapAmount amount ] ] ]
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

{ #category : #operations }
ASwap >> difAmount: anAmount [
	amount := amount - anAmount amount.
	anAmount class = self class
		ifTrue: [ swapAmount
						ifNil: [ swapAmount := anAmount swapAmount clone invert ]
						ifNotNil: [ anAmount swapAmount
											ifNotNil: [ swapAmount amount: swapAmount amount - anAmount swapAmount amount ] ] ]
]

{ #category : #printing }
ASwap >> printCSVOn: aStream [
	super printCSVOn: aStream.
	aStream nextPut: $,.
	swapAmount printCSVOn: aStream.
]

{ #category : #printing }
ASwap >> printOn: aStream [
	aStream
		nextPutAll: (amount round: 4) asString.
	self do: [ :t|
		aStream nextPutAll: ' ';
			nextPutAll: t ].
	aStream nextPutAll: ' = '.
	swapAmount printOn: aStream.
]

{ #category : #accessing }
ASwap >> swapAmount [
	^ swapAmount ifNil: [ swapAmount := AAmount new ]
]

{ #category : #accessing }
ASwap >> swapAmount: anObject [
	swapAmount := anObject
]
