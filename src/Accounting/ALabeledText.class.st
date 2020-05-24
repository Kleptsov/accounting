Class {
	#name : #ALabeledText,
	#superclass : #Morph,
	#instVars : [
		'aLabel',
		'label',
		'labelMorph',
		'textModel',
		'text',
		'accept',
		'acceptAction',
		'textField',
		'morph'
	],
	#category : #'Accounting-Morphic'
}

{ #category : #creating }
ALabeledText class >> on: model label: aLabel text: aText accept: anAccept acceptAction: anAction [

^ self new
	textModel: model;
	label: aLabel;
	text: aText;
	accept: anAccept;
	acceptAction: anAction;
	initializeMorph.

"| labelMorph  m txtField |
labelMorph := StringMorph contents: anLabel.
	
txtField := ATextField on: model text: aText accept: anAccept acceptAction: anAction.
txtField setProperty: #relativeExtent toValue: 1.0@0.5. 

m := Morph new
		layoutPolicy: (AAbsoluteRelativeLayout new direction: #rightUp);
		extent: 300@60;
		addMorph: txtField;
		addMorph: labelMorph.
m color: (m color alpha: 0.0).
^ m"
]

{ #category : #accessing }
ALabeledText >> accept [
	^ accept
]

{ #category : #accessing }
ALabeledText >> accept: anObject [
	accept := anObject
]

{ #category : #accessing }
ALabeledText >> acceptAction [
	^ acceptAction
]

{ #category : #accessing }
ALabeledText >> acceptAction: anObject [
	acceptAction := anObject
]

{ #category : #initialization }
ALabeledText >> initializeLabel [
	labelMorph := StringMorph contents: self label
]

{ #category : #initialization }
ALabeledText >> initializeMorph [
	self initializeLabel.
	self initializeTextField.
	self
		layoutPolicy: (AAbsoluteRelativeLayout new direction: #rightUp);
		extent: 300@60;
		addMorph: textField;
		addMorph: labelMorph;
		color: (self color alpha: 0.0).
]

{ #category : #initialization }
ALabeledText >> initializeTextField [
	textField := ATextField on: textModel text: text accept: accept acceptAction: acceptAction.
	textField setProperty: #relativeExtent toValue: 1.0@0.5. 
]

{ #category : #accessing }
ALabeledText >> label [
	^ label
]

{ #category : #accessing }
ALabeledText >> label: anObject [
	label := anObject
]

{ #category : #accessing }
ALabeledText >> labelMorph [
	^ labelMorph
]

{ #category : #accessing }
ALabeledText >> labelMorph: anObject [
	labelMorph := anObject
]

{ #category : #accessing }
ALabeledText >> morph [
	^ morph
]

{ #category : #accessing }
ALabeledText >> morph: anObject [
	morph := anObject
]

{ #category : #accessing }
ALabeledText >> text [
	^ text
]

{ #category : #accessing }
ALabeledText >> text: anObject [
	text := anObject
]

{ #category : #accessing }
ALabeledText >> textField [
	^ textField
]

{ #category : #accessing }
ALabeledText >> textField: anObject [
	textField := anObject
]

{ #category : #accessing }
ALabeledText >> textModel [
	^ textModel
]

{ #category : #accessing }
ALabeledText >> textModel: anObject [
	textModel := anObject
]
