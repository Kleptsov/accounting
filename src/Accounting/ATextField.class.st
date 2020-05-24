Class {
	#name : #ATextField,
	#superclass : #PluggableTextFieldMorph,
	#category : #'Accounting-Morphic'
}

{ #category : #creating }
ATextField class >> on: aModel text: aTextSelector accept: anAcceptSelector acceptAction:  anAcceptAction [
	| txtMorph |
	txtMorph := PluggableTextFieldMorph new.
	txtMorph on: aModel text: aTextSelector accept: anAcceptSelector readSelection: nil menu: nil.
	txtMorph autoAccept: true.
	txtMorph acceptAction: anAcceptAction.
	txtMorph hideVScrollBarIndefinitely: true.
	^ txtMorph yourself.
]
