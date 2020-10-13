Class {
	#name : #ADocumentJournalModel,
	#superclass : #Object,
	#instVars : [
		'documents',
		'document'
	],
	#category : #'Accounting-Model'
}

{ #category : #accessing }
ADocumentJournalModel >> document [
	^ document
]

{ #category : #accessing }
ADocumentJournalModel >> document: anObject [
	document := anObject
]

{ #category : #accessing }
ADocumentJournalModel >> documents [
	^ documents
]

{ #category : #accessing }
ADocumentJournalModel >> documents: anObject [
	documents := anObject
]

{ #category : #rendering }
ADocumentJournalModel >> morphController [
	^ FDirectController new
]

{ #category : #rendering }
ADocumentJournalModel >> morphRenderer [
	^ FExample1Renderer new.
]

{ #category : #rendering }
ADocumentJournalModel >> morphView [
	^ self morphController updateModel: self.
]

{ #category : #rendering }
ADocumentJournalModel >> morphViewInWindow [
	| m w |
	m := self morphView.
	w := StandardWindow new.
	w addMorph: m frame: LayoutFrame new.
	w open.
	^ m
]
