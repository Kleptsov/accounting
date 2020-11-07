Class {
	#name : #AText,
	#superclass : #FText,
	#category : #'Accounting-Morphic'
}

{ #category : #'as yet unclassified' }
AText class >> on: aModel label: aLabel selector: aSelector [
	| m |
	m := super on: aModel label: aLabel translated selector: aSelector.
	m extent: 150@52.
	^ m.
	
		
]
