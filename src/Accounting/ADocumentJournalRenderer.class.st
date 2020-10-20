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
	m := PluggableButtonMorph
				on: model
				getState: nil 
				action: #addNewSelected
				label: #addNewButtonName.
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
ADocumentJournalRenderer >> renderRemoveButton [
	| m |
	m := PluggableButtonMorph
				on: model
				getState: nil 
				action: #removeSelected
				label: #removeButtonName.
	panel addMorphBack: m.
	
]
