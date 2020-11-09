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
				color: Color transparent;
				extent: 10@30;
				hResizing: #spaceFill.
			self owner addMorphBack: commandPanel.
			commandPanel ]
]

{ #category : #rendering }
AContractMorphRenderer >> render [
	self commandPanel.
	self renderCommandButtons.
	self render: (AText on: model label: 'Number' selector: #number).
	self render: (AText on: model label: 'Additional Number' selector: #additionalNumber).
	self render: (AText on: model label: 'Date' selector: #date).
	self renderNextLine.
	self render: (AText on: model label: 'Organization' selector: #organization).
	self render: (AText on: model label: 'Contractor' selector: #contractor).
	self renderNextLine.
	self render: (AText on: model label: 'ReceiptName' selector: #receiptName).
	self render: (AText on: model label: 'Currency Name' selector: #currencyName).
	self render: (AText on: model label: 'Additional' selector: #additional).
	self render: (AText on: model accountEditor label: 'Barcode' selector: #barcode).
	self renderNextLine.
	self render: #accountEditor with: [ :m| m extent: 1@40; hResizing: #spaceFill ].
	self renderNextLine.
	self renderItemsButtons. self renderNextLine.
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
	m extent: 20@20.
	self commandPanel addMorphBack: m.
	self commandPanel addMorphBack: (model class baseTitle translated asMorph).
]

{ #category : #rendering }
AContractMorphRenderer >> renderAddBarcodeButton [
	self commandPanel addMorphBack:
			((FButton
				model: model accountEditor
				label: (self iconNamed: #add) asMorph 
				action: #addBarcode
				help: 'Add Barcode' translated) color: Color transparent; yourself).

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
AContractMorphRenderer >> renderAllChangingButton [
	self commandPanel addMorphBack:
		(FButton
			model: model
			label: (self iconNamed: #objects) asMorph
			action: #morphViewAllChangingInWindow
			help: 'Open All Changing of Document' translated).
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
AContractMorphRenderer >> renderCommandButtons [
	self renderAccepted.
	self renderAddBarcodeButton.
	self renderCopyToClipboard.
	self renderNewInvoiceButton.
	self renderNewPaymentButton.
	self renderAllChangingButton.
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
AContractMorphRenderer >> renderCopyToClipboard [
	self commandPanel addMorphBack:
			(FButton
				model: model items
				label: (self iconNamed: #smallCopy) asMorph 
				action: #copyToClipboard
				help: 'Copy to Clipboard' translated).
]

{ #category : #rendering }
AContractMorphRenderer >> renderCurrencyName [
	| m |
	m := FText
			on: model
			label: 'Currency Name' translated
			selector: #currencyName.
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
AContractMorphRenderer >> renderItemsButtons [
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
AContractMorphRenderer >> renderNewInvoiceButton [
	self commandPanel addMorphBack:
		(FButton
			model: model
			label: (self iconNamed: #komitterSmalltalkhubRemote) asMorph
			action: #createAndOpenInvoice
			help: 'New Invoice' translated).
]

{ #category : #rendering }
AContractMorphRenderer >> renderNewPaymentButton [
	self commandPanel addMorphBack:
		(FButton
			model: model
			label: '$'
			action: #createAndOpenPayment
			help: 'New Payment' translated).
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

{ #category : #rendering }
AContractMorphRenderer >> renderReceiptName [
	| m |
	m := FText
			on: model
			label: 'Receipt Name' translated
			selector: #receiptName.
	m extent: 150@40.
	self owner addMorphBack: m.
]
