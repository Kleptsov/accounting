Class {
	#name : #APaymentMorphRenderer,
	#superclass : #FMorphRenderer,
	#instVars : [
		'commandPanel'
	],
	#category : #'Accounting-GUI-Facing'
}

{ #category : #rendering }
APaymentMorphRenderer >> commandPanel [
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
APaymentMorphRenderer >> render [
	self renderAccepted.
	self renderNumber.
	self renderContractNumber.
	self renderDate.
	self renderNextLine.
	self renderOrganization.
	self renderContractor.
	self renderNextLine.
	self renderReceiptName.
	self renderCurrencyName.
	self renderSum.
	^ self owner
]

{ #category : #rendering }
APaymentMorphRenderer >> renderAccepted [
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
APaymentMorphRenderer >> renderContractNumber [
	| m |
	m := FText
			on: model
			label: 'Contract Number' translated
			selector: #contractNumber.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
APaymentMorphRenderer >> renderContractor [
	| m |
	m := FText
			on: model
			label: 'Contractor' translated
			selector: #contractor.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
APaymentMorphRenderer >> renderCurrencyName [
	| m |
	m := FText
			on: model
			label: 'Currency Name' translated
			selector: #currencyName.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
APaymentMorphRenderer >> renderDate [
	| m |
	m := FText
			on: model
			label: 'Date' translated
			selector: #date.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
APaymentMorphRenderer >> renderNextLine [
	| m |
	m := Morph new extent: 0@0; setProperty: #cr toValue: true.
	self owner addMorphBack: m
]

{ #category : #rendering }
APaymentMorphRenderer >> renderNumber [
	| m |
	m := FText
			on: model
			label: 'Number' translated
			selector: #number.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
APaymentMorphRenderer >> renderOrganization [
	| m |
	m := FText
			on: model
			label: 'Organization' translated
			selector: #organization.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
APaymentMorphRenderer >> renderReceiptName [
	| m |
	m := FText
			on: model
			label: 'Receipt Name' translated
			selector: #receiptName.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
APaymentMorphRenderer >> renderSum [
	| m |
	m := FText
			on: model
			label: 'Sum' translated
			selector: #sum.
	m extent: 150@40.
	self owner addMorphBack: m.
]
