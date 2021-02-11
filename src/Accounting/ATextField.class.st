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
	txtMorph hideScrollBarsIndefinitely.
	^ txtMorph yourself.
]

{ #category : #'model access' }
ATextField >> setTextBasic: aText [
	
	self textMorph contents = aText contents ifTrue: [ ^ self ].
	((self textMorph contents size = 0) and: [self wrapFlag])
		ifTrue: [ 
			self textMorph
				contents: aText 
				wrappedTo: self innerExtent x ]
		ifFalse: [
			self textMorph newContents: aText].
]
