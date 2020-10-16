Class {
	#name : #ADocumentJournalRenderer,
	#superclass : #FMorphRenderer,
	#category : #'Accounting-GUI'
}

{ #category : #rendering }
ADocumentJournalRenderer >> render [
	| docListMorph docMorph |
	docListMorph := model documents morphController
								listen: #documents from: model.
	docListMorph setProperty: #relativeExtent toValue: 0.2@01.0.
	docMorph := model document morphController
								listen: #document from: model.
	docMorph setProperty: #relativeExtent toValue: 0.8@1.0. 
	^ self owner
			addMorphBack: docListMorph;
			addMorphBack: docMorph.
]
