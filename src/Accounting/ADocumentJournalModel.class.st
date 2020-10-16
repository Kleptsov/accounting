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
	^ document ifNil: [FTextModel new val: 'Select a Document' translated]
]

{ #category : #accessing }
ADocumentJournalModel >> document: anObject [
	anObject ifNil: [ ^ self ].
	document := anObject.
	self changed: #document with: self.
]

{ #category : #accessing }
ADocumentJournalModel >> documents [
	^ documents ifNil: [ documents := ADocumentTreeModel new ]
]

{ #category : #accessing }
ADocumentJournalModel >> documents: anObject [
	documents := anObject.
	self changed: #documents with: anObject.
]

{ #category : #initialization }
ADocumentJournalModel >> initialize [
	super initialize.
	self documents announcer
		when: MorphTreeSelectionChanged
		do: [ :a | (a selection lastSelectedNode) ifNotNil: [ :n| self document: n item ] ]
]

{ #category : #rendering }
ADocumentJournalModel >> morphController [
	^ FDirectController new
]

{ #category : #rendering }
ADocumentJournalModel >> morphRenderer [
	^ ADocumentJournalRenderer new.
]

{ #category : #rendering }
ADocumentJournalModel >> morphView [
	^ self morphController listen: #yourself from: self.
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
