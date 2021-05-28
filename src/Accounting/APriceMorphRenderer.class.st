Class {
	#name : #APriceMorphRenderer,
	#superclass : #FMorphRenderer,
	#instVars : [
		'commandPanel'
	],
	#category : #'Accounting-GUI-Facing'
}

{ #category : #rendering }
APriceMorphRenderer >> commandPanel [
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
APriceMorphRenderer >> render [
	self commandPanel.
	self renderCommandButtons.
	self renderNumber.
	self renderAdditionalNumber.
	self renderDate.
	self renderNextLine.
	self renderOrganization.
	self renderContractor.
	self renderNextLine.
	self renderReceiptName.
	self renderCurrencyName.
	self renderAdditional.
	self renderBarcode.
	self renderNextLine.
	self render: #accountEditor with: [ :m| m extent: 1@40; hResizing: #spaceFill ].
	self renderNextLine.
	self renderItemsButtons.
	self renderNextLine.
	self render: #itemsList with: [ :m| m extent: 1@10; hResizing: #spaceFill; vResizing: #spaceFill ].
	^ self owner.
]

{ #category : #rendering }
APriceMorphRenderer >> renderAccepted [
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
APriceMorphRenderer >> renderAddBarcodeButton [
	self commandPanel addMorphBack:
			((FButton
				model: model accountEditor
				label: (self iconNamed: #add) asMorph 
				action: #addBarcode
				help: 'Add Barcode' translated) color: Color transparent; yourself).

]

{ #category : #rendering }
APriceMorphRenderer >> renderAdditional [
	| m |
	m := AText2 model: model event: #additional callbackEvent: #updateText label: 'Additional'.
	m extent: 150@40.
	self render: m.
]

{ #category : #rendering }
APriceMorphRenderer >> renderAdditionalNumber [
	| m |
	m := AText2 model: model event: #additionalNumber callbackEvent: #updateText label: 'Additional Number'.
	m extent: 150@40.
	self render: m.
]

{ #category : #rendering }
APriceMorphRenderer >> renderAllChangingButton [
	self commandPanel addMorphBack:
		(FButton
			model: model
			label: (self iconNamed: #objects) asMorph
			action: #morphViewAllChangingInWindow
			help: 'Open All Changing of Document' translated).
]

{ #category : #rendering }
APriceMorphRenderer >> renderBarcode [
	| m |
	m := AText2 model: model accountEditor event: #barcode callbackEvent: #updateText label: 'Barcode'.
	m extent: 150@40.
	self render: m.
]

{ #category : #rendering }
APriceMorphRenderer >> renderCommandButtons [
	self renderAccepted.
	self renderAddBarcodeButton.
	self renderCopyToClipboard.
	self renderNewInvoiceButton.
	self renderNewPaymentButton.
	self renderAllChangingButton.
]

{ #category : #rendering }
APriceMorphRenderer >> renderContractor [
	| m |
	m := AText2 model: model event: #contractor callbackEvent: #updateText label: 'Contractor'.
	m extent: 150@40.
	self render: m.
]

{ #category : #rendering }
APriceMorphRenderer >> renderCopyToClipboard [
	self commandPanel addMorphBack:
			(FButton
				model: model items
				label: (self iconNamed: #smallCopy) asMorph 
				action: #copyToClipboard
				help: 'Copy to Clipboard' translated).
]

{ #category : #rendering }
APriceMorphRenderer >> renderCurrencyName [
	| m |
	m := AText2 model: model event: #currencyName callbackEvent: #updateText label: 'Currency Name'.
	m extent: 150@40.
	self render: m.
]

{ #category : #rendering }
APriceMorphRenderer >> renderDate [
	| m |
	m := AText2 model: model event: #date callbackEvent: #updateText label: 'Date'.
	m extent: 150@40.
	self render: m.
]

{ #category : #rendering }
APriceMorphRenderer >> renderItemsButtons [
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
APriceMorphRenderer >> renderNewInvoiceButton [
	self commandPanel addMorphBack:
		(FButton
			model: model
			label: (self iconNamed: #komitterSmalltalkhubRemote) asMorph
			action: #createAndOpenInvoice
			help: 'New Invoice' translated).
]

{ #category : #rendering }
APriceMorphRenderer >> renderNewPaymentButton [
	self commandPanel addMorphBack:
		(FButton
			model: model
			label: '$'
			action: #createAndOpenPayment
			help: 'New Payment' translated).
]

{ #category : #rendering }
APriceMorphRenderer >> renderNextLine [
	| m |
	m := Morph new extent: 0@0; setProperty: #cr toValue: true.
	self owner addMorphBack: m
]

{ #category : #rendering }
APriceMorphRenderer >> renderNumber [
	| m |
	m := AText2 model: model event: #number callbackEvent: #updateText label: 'Number'.
	m extent: 150@40.
	self render: m.
]

{ #category : #rendering }
APriceMorphRenderer >> renderOrganization [
	| m |
	m := AText2 model: model event: #organization callbackEvent: #updateText label: 'Organization'.
	m extent: 150@40.
	self render: m.
]

{ #category : #rendering }
APriceMorphRenderer >> renderReceiptName [
	| m |
	m := AText2 model: model event: #receiptName callbackEvent: #updateText label: 'Receipt Name'.
	m extent: 150@40.
	self render: m.
]
