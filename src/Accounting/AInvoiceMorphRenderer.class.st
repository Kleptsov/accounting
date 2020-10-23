Class {
	#name : #AInvoiceMorphRenderer,
	#superclass : #FMorphRenderer,
	#instVars : [
		'commandPanel'
	],
	#category : #'Accounting-GUI-Facing'
}

{ #category : #rendering }
AInvoiceMorphRenderer >> commandPanel [
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
AInvoiceMorphRenderer >> render [
	self commandPanel.
	self renderAccepted.
	self renderNumber.
	self renderContractNumber.
	self renderDate.
	self renderNextLine.
	self renderOrganization.
	self renderContractor.
	self renderNextLine.
	self renderStore.
	self renderReceiptName.
	self renderCurrencyName.
	self renderNextLine.
	self render: #accountEditor with: [ :m| m extent: 1@40; hResizing: #spaceFill ].
	self renderNextLine.
	self renderItemsButtons. self renderNextLine.
	self render: #itemsList with: [ :m| m extent: 1@10; hResizing: #spaceFill; vResizing: #spaceFill ].
	^ self owner
]

{ #category : #rendering }
AInvoiceMorphRenderer >> renderAccepted [
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
AInvoiceMorphRenderer >> renderContractNumber [
	| m |
	m := FText
			on: model
			label: 'Contract Number' translated
			selector: #contractNumber.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AInvoiceMorphRenderer >> renderContractor [
	| m |
	m := FText
			on: model
			label: 'Contractor' translated
			selector: #contractor.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AInvoiceMorphRenderer >> renderCurrencyName [
	| m |
	m := FText
			on: model
			label: 'Currency Name' translated
			selector: #currencyName.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AInvoiceMorphRenderer >> renderDate [
	| m |
	m := FText
			on: model
			label: 'Date' translated
			selector: #date.
	m extent: 150@40.
	self owner addMorphBack: m
]

{ #category : #rendering }
AInvoiceMorphRenderer >> renderItemsButtons [
	self owner addMorphBack:
			(FButton model: model label: (self iconNamed: #down) asMorph action: #downItem help: 'Down' translated).
	self owner addMorphBack:
			(FButton model: model label: (self iconNamed: #up) asMorph action: #upItem help: 'Up' translated).
	self owner addMorphBack:
			(FButton model: model label: (self iconNamed: #smallAdd) asMorph action: #updateOrAddSwapItem help: 'Add' translated).
	self owner addMorphBack:
			(FButton model: model label: (self iconNamed: #delete) asMorph action: #removeSwapItem help: 'Remove' translated)
]

{ #category : #rendering }
AInvoiceMorphRenderer >> renderNextLine [
	| m |
	m := Morph new extent: 0@0; setProperty: #cr toValue: true.
	self owner addMorphBack: m
]

{ #category : #rendering }
AInvoiceMorphRenderer >> renderNumber [
	| m |
	m := FText
			on: model
			label: 'Number' translated
			selector: #number.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AInvoiceMorphRenderer >> renderOrganization [
	| m |
	m := FText
			on: model
			label: 'Organization' translated
			selector: #organization.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AInvoiceMorphRenderer >> renderReceiptName [
	| m |
	m := FText
			on: model
			label: 'Receipt Name' translated
			selector: #receiptName.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AInvoiceMorphRenderer >> renderStore [
	| m |
	m := FText
			on: model
			label: 'Store' translated
			selector: #store.
	m extent: 150@40.
	self owner addMorphBack: m.
]
