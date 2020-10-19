Class {
	#name : #ADocumentJournalModel,
	#superclass : #Object,
	#instVars : [
		'documents',
		'document'
	],
	#category : #'Accounting-Model'
}

{ #category : #'instance creation' }
ADocumentJournalModel class >> on: aDocumentList [
	| journal |
	journal := self new.
	journal documents rootItems: aDocumentList.
	^ journal.
]

{ #category : #accessing }
ADocumentJournalModel >> addNewButtonName [
	^ 'Add' translated
]

{ #category : #actions }
ADocumentJournalModel >> addNewSelected [
	(self document class respondsTo: #addNew)
			ifFalse: [ ^ self ].
	self document: self document class addNew.
	self changed: #documents with: self.
]

{ #category : #accessing }
ADocumentJournalModel >> document [
	^ document ifNil: [FTextModel new val: 'Select a Document from the List' translated]
]

{ #category : #accessing }
ADocumentJournalModel >> document: anObject [
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
	self changed: #documents with: self.
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
	w title: 'Document Journal' translated.
	w addMorph: m frame: LayoutFrame new.
	w open.
	^ m
]

{ #category : #accessing }
ADocumentJournalModel >> removeButtonName [
	^ 'Remove' translated
]

{ #category : #actions }
ADocumentJournalModel >> removeSelected [
	(self document respondsTo: #delete)
		ifFalse: [ ^ self ].
	self document delete.
	self changed: #documents with: self.
	self document: nil.
]