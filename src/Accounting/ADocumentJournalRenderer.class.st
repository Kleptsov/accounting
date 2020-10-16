Class {
	#name : #ADocumentJournalRenderer,
	#superclass : #FMorphRenderer,
	#category : #'Accounting-GUI'
}

{ #category : #rendering }
ADocumentJournalRenderer >> render [
	self render: #documents
		with: [ :m| m setProperty: #relativeExtent toValue: 0.2@1.0 ].
	self render: #document
		with: [ :m| m setProperty: #relativeExtent toValue: 0.8@1.0 ].
	^ self owner.
]
