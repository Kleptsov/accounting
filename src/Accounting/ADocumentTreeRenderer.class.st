Class {
	#name : #ADocumentTreeRenderer,
	#superclass : #FMorphRenderer,
	#category : #'Accounting-GUI'
}

{ #category : #rendering }
ADocumentTreeRenderer >> render [
	^ model treeMorph.
]
