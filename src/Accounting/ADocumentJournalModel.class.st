Class {
	#name : #ADocumentJournalModel,
	#superclass : #Object,
	#instVars : [
		'documents',
		'document',
		'source'
	],
	#category : #'Accounting-Model'
}

{ #category : #'instance creation' }
ADocumentJournalModel class >> on: aDocumentList [
	| journal |
	journal := self new.
	journal on: aDocumentList.
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
	self documents: nil.
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
	self initializeDocuments.
	^ documents
]

{ #category : #accessing }
ADocumentJournalModel >> documents: anObject [
	documents := anObject.
	self changed: #documents with: self.
]

{ #category : #actions }
ADocumentJournalModel >> downItem [
	| index items |
	items := self documents rootItems.
	index := items indexOf: self document.
	(index = items size or: [ index = 0 ])
		ifTrue: [ ^ self ].
	items at: index put: (items at: index + 1).
	items at: index + 1 put: self document.
	self changed: #documents with: self.
]

{ #category : #initialization }
ADocumentJournalModel >> initializeDocuments [
	documents := FMorphTreeModel new.
	(documents columnLabel: '#' selector: #firstName) startWidth: 50.
	documents columnLabel: '' selector: #secondName.
	documents rootItems: ( source isBlock ifTrue: [ source value ] ifFalse: [ source ] ).
	documents announcer
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

{ #category : #initialization }
ADocumentJournalModel >> on: aCollectionOrBlock [
	source := aCollectionOrBlock.
	self initializeDocuments.
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
	self documents: nil.
	self document: nil.
]

{ #category : #accessing }
ADocumentJournalModel >> source [
	^ source ifNil: [ source := [ #() ] ]
]

{ #category : #accessing }
ADocumentJournalModel >> source: anObject [
	source := anObject
]

{ #category : #actions }
ADocumentJournalModel >> upItem [
	| index items |
	items := self documents rootItems.
	index := items indexOf: self document.
	(index < 2)
		ifTrue: [ ^ self ].
	items at: index put: (items at: index - 1).
	items at: index - 1 put: self document.
	self changed: #documents with: self.
]

{ #category : #actions }
ADocumentJournalModel >> updateModel [
	self documents: nil.
]
