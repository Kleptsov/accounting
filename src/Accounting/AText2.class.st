Class {
	#name : #AText2,
	#superclass : #FText2,
	#category : #'Accounting-Morphic'
}

{ #category : #'as yet unclassified' }
AText2 class >> model: aModel event: anEvent callbackEvent: aCallbackEvent label: aLabel [
	| res |
	res := self new.
	res label: aLabel.
	res textField addModel: aModel event: anEvent callbackEvent: aCallbackEvent.
	^ res.
]
