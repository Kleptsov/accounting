Class {
	#name : #ASwapMorphRenderer,
	#superclass : #FMorphRenderer,
	#instVars : [
		'commandPanel'
	],
	#category : #'Accounting-GUI-Facing'
}

{ #category : #rendering }
ASwapMorphRenderer >> commandPanel [
	^ commandPanel 	ifNil: [
			commandPanel := Morph new
				layoutPolicy: (FAbsoluteRelativeLayout new direction: #rightDown) ;
				color: Color transparent;
				extent: 10@30;
				hResizing: #spaceFill.
			self owner addMorphBack: commandPanel.
			commandPanel ]
]

{ #category : #rendering }
ASwapMorphRenderer >> render [
	self commandPanel.
	self renderCommandButtons.
	self render: (AText on: model label: 'Number' selector: #number).
	self render: (AText on: model label: 'Date' selector: #date).
	self renderNextLine.
	self render: (AText on: model label: 'Organization' selector: #organization).
	self render: (AText on: model label: 'Organization Account' selector: #organizationAccount).
	self render: (AText on: model label: 'Organization Account' selector: #organizationAccount2).
	self renderNextLine.
	self render: (AText on: model label: 'Contractor' selector: #contractor).
	self render: (AText on: model label: 'Contractor Account' selector: #contractorAccount).
	self render: (AText on: model label: 'Contractor Account' selector: #contractorAccount2).
	self renderNextLine.
	self render: (AText on: model label: 'Additional' selector: #additional).
	self render: (AText on: model accountEditor label: 'Barcode' selector: #barcode).
	self renderNextLine.
	self render: #accountEditor with: [ :m| m extent: 1@52; hResizing: #spaceFill ].
	self renderNextLine.
	self renderItemsButtons. self renderNextLine.
	self render: #itemsList with: [ :m| m extent: 1@10; hResizing: #spaceFill; vResizing: #spaceFill ].
	^ self owner.
]

{ #category : #rendering }
ASwapMorphRenderer >> renderAccepted [
	| m |
	m := CheckboxMorph
				on: model
				selected: #accepted
				changeSelected: #accepted:.
	m extent: 20@20.
	self commandPanel addMorphBack: m.
	self commandPanel addMorphBack: (model class baseTitle translated asMorph).
]

{ #category : #rendering }
ASwapMorphRenderer >> renderAddBarcodeButton [
	self commandPanel addMorphBack:
			(FButton
				model: model accountEditor
				label: (Smalltalk ui icons add asMorph) 
				action: #addBarcode
				help: 'Add Barcode' translated).

]

{ #category : #rendering }
ASwapMorphRenderer >> renderCommandButtons [
	self renderAccepted.
	self renderAddBarcodeButton.
	self renderCopyToClipboard.
]

{ #category : #rendering }
ASwapMorphRenderer >> renderCopyToClipboard [
	self commandPanel addMorphBack:
			(FButton
				model: model items
				label: (self iconNamed: #smallCopy) asMorph 
				action: #copyToClipboard
				help: 'Copy to Clipboard' translated).
]

{ #category : #rendering }
ASwapMorphRenderer >> renderItemsButtons [
	self owner addMorphBack:
			(FButton model: model label: (self iconNamed: #down) asMorph action: #downItem help: 'Down' translated).
	self owner addMorphBack:
			(FButton model: model label: (self iconNamed: #up) asMorph action: #upItem help: 'Up' translated).
	self owner addMorphBack:
			(FButton model: model label: (self iconNamed: #smallAdd) asMorph action: #addItem help: 'Add' translated).
	self owner addMorphBack:
			(FButton model: model label: (self iconNamed: #delete) asMorph action: #removeItem help: 'Remove' translated)
]

{ #category : #rendering }
ASwapMorphRenderer >> renderNextLine [
	| m |
	m := Morph new extent: 0@0; setProperty: #cr toValue: true.
	self owner addMorphBack: m
]
