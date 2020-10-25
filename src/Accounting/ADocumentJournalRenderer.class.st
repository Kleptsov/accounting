Class {
	#name : #ADocumentJournalRenderer,
	#superclass : #FMorphRenderer,
	#instVars : [
		'panel'
	],
	#category : #'Accounting-GUI-Facing'
}

{ #category : #rendering }
ADocumentJournalRenderer >> render [
	self renderCommandPanel.
	self renderAddButton.
	self renderRemoveButton.
	self renderUpButton.
	self renderDownButton.
	self renderUpdateModelButton.
	self render: #documents
		with: [ :m| m setProperty: #relativeExtent toValue: 0.2@1.0. ]
		finalize: [ :m| m model ifNotNil: [m model announcer unsubscribe: m]. ].
	self owner addMorphBack: (Morph new extent: 4@1; color: Color transparent).
	self render: #document
		with: [ :m| m hResizing: #spaceFill; vResizing: #spaceFill ].
	^ self owner.
]

{ #category : #rendering }
ADocumentJournalRenderer >> renderAddButton [
	| m |
	m := FButton
				model: model
				label: (self iconNamed: #smallAdd) asMorph
				action: #addNewSelected
				help: 'Add Document' translated.
	panel addMorphBack: m.
]

{ #category : #rendering }
ADocumentJournalRenderer >> renderCommandPanel [
	panel := Morph new extent: 10@20;
					hResizing: #spaceFill;
					color: Color transparent;
					layoutPolicy: (FAbsoluteRelativeLayout new direction: #rightDown);
					yourself.
	self owner addMorphBack: panel.
]

{ #category : #rendering }
ADocumentJournalRenderer >> renderDownButton [
	| m |
	m := FButton
				model: model
				label: (self iconNamed: #down) asMorph
				action: #downItem
				help: 'Down Item' translated.
	panel addMorphBack: m.
]

{ #category : #rendering }
ADocumentJournalRenderer >> renderRemoveButton [
	| m |
	m := FButton
				model: model
				label: (self iconNamed: #delete) asMorph
				action: #removeSelected
				help: 'Remove Document' translated.
	panel addMorphBack: m.
	
]

{ #category : #rendering }
ADocumentJournalRenderer >> renderUpButton [
	| m |
	m := FButton
				model: model
				label: (self iconNamed: #up) asMorph
				action: #upItem
				help: 'Up Item' translated.
	panel addMorphBack: m.
]

{ #category : #rendering }
ADocumentJournalRenderer >> renderUpdateModelButton [
	| m |
	m := FButton
				model: model
				label: (self iconNamed: #smallUpdate) asMorph
				action: #updateModel
				help: 'Update' translated.
	panel addMorphBack: m.
]
