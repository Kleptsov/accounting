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
	self renderNumber.
	self renderDate.
	self renderOrganization.
	self renderOrganizationAccount.
	self renderOrganizationAccount2.
	self renderContractor.
	self renderContractorAccount.
	self renderContractorAccount2.
	self renderAdditional.
	self renderBarcode.
	self renderNextLine.
	self render: #accountEditor with: [ :m| m extent: 1@40; hResizing: #spaceFill ].
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
	m label: (self iconNamed: #smallOk) asMorph.
	m extent: 50@20.
	self commandPanel addMorphBack: m.
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
ASwapMorphRenderer >> renderAdditional [
	| m |
	m := FText
			on: model
			label: 'Additional' translated
			selector: #additional.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ASwapMorphRenderer >> renderBarcode [
	| m |
	m := FText
			on: model accountEditor
			label: 'Barcode' translated
			selector: #barcode.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ASwapMorphRenderer >> renderCommandButtons [
	self renderAccepted.
	self renderAddBarcodeButton.
	self renderCopyToClipboard.
]

{ #category : #rendering }
ASwapMorphRenderer >> renderContractor [
	| m |
	m := FText
			on: model
			label: 'Contractor' translated
			selector: #contractor.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ASwapMorphRenderer >> renderContractorAccount [
	| m |
	m := FText
			on: model
			label: 'Contractor Account' translated, ' 1'
			selector: #contractorAccount.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ASwapMorphRenderer >> renderContractorAccount2 [
	| m |
	m := FText
			on: model
			label: 'Contractor Account' translated, ' 2'
			selector: #contractorAccount2.
	m extent: 150@40.
	self owner addMorphBack: m.
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
ASwapMorphRenderer >> renderDate [
	| m |
	m := FText
			on: model
			label: 'Date' translated
			selector: #date.
	m extent: 150@40.
	self owner addMorphBack: m.
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

{ #category : #rendering }
ASwapMorphRenderer >> renderNumber [
	| m |
	m := FText
			on: model
			label: 'Number' translated
			selector: #number.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ASwapMorphRenderer >> renderOrganization [
	| m |
	m := FText
			on: model
			label: 'Organization' translated
			selector: #organization.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ASwapMorphRenderer >> renderOrganizationAccount [
	| m |
	m := FText
			on: model
			label: 'Organization Account' translated, ' 1'
			selector: #organizationAccount.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ASwapMorphRenderer >> renderOrganizationAccount2 [
	| m |
	m := FText
			on: model
			label: 'Organization Account' translated, ' 2'
			selector: #organizationAccount2.
	m extent: 150@40.
	self owner addMorphBack: m.
]
