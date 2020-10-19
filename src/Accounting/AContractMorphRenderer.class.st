Class {
	#name : #AContractMorphRenderer,
	#superclass : #FMorphRenderer,
	#instVars : [
		'commandPanel'
	],
	#category : #'Accounting-GUI-Facing'
}

{ #category : #rendering }
AContractMorphRenderer >> commandPanel [
	^ commandPanel 	ifNil: [
			commandPanel := Morph new
				layoutPolicy: (FAbsoluteRelativeLayout new direction: #rightDown) ;
				color: Smalltalk ui theme baseColor;
				extent: 10@20;
				hResizing: #spaceFill.
			self owner addMorphBack: commandPanel.
			commandPanel ]
]

{ #category : #rendering }
AContractMorphRenderer >> render [
	self commandPanel.
	self renderAccepted.
	self renderNumber.
	self renderAdditionalNumber.
	self renderDate.
	self renderOrganization.
	self renderContractor.
	self renderAdditional.
	self renderBarcode.
	self renderNextLine.
	self render: #accountEditor with: [ :m| m extent: 1@40; hResizing: #spaceFill ].
	self renderNextLine.
	self render: #itemsList with: [ :m| m extent: 1@10; hResizing: #spaceFill; vResizing: #spaceFill ].
	^ self owner.
]

{ #category : #rendering }
AContractMorphRenderer >> renderAccepted [
	| m |
	m := CheckboxMorph
				on: model
				selected: #accepted
				changeSelected: #accepted:.
	m label: 'Accept' translated.
	m extent: 100@20.
	self commandPanel addMorphBack: m.
]

{ #category : #rendering }
AContractMorphRenderer >> renderAdditional [
	| m |
	m := FText
			on: model
			label: 'Additional' translated
			selector: #additional.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AContractMorphRenderer >> renderAdditionalNumber [
	| m |
	m := FText
			on: model
			label: 'Additional Number' translated
			selector: #additionalNumber.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AContractMorphRenderer >> renderBarcode [
	| m |
	m := FText
			on: model accountEditor
			label: 'Barcode' translated
			selector: #barcode.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AContractMorphRenderer >> renderContractor [
	| m |
	m := FText
			on: model
			label: 'Contractor' translated
			selector: #contractor.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AContractMorphRenderer >> renderDate [
	| m |
	m := FText
			on: model
			label: 'Date' translated
			selector: #date.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AContractMorphRenderer >> renderNextLine [
	| m |
	m := Morph new extent: 0@0; setProperty: #cr toValue: true.
	self owner addMorphBack: m
]

{ #category : #rendering }
AContractMorphRenderer >> renderNumber [
	| m |
	m := FText
			on: model
			label: 'Number' translated
			selector: #number.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AContractMorphRenderer >> renderOrganization [
	| m |
	m := FText
			on: model
			label: 'Organization' translated
			selector: #organization.
	m extent: 150@40.
	self owner addMorphBack: m.
]
