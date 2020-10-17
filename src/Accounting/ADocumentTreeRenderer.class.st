Class {
	#name : #ADocumentTreeRenderer,
	#superclass : #FMorphRenderer,
	#category : #'Accounting-GUI-Facing'
}

{ #category : #rendering }
ADocumentTreeRenderer >> render [
	^ model treeMorph.
]
