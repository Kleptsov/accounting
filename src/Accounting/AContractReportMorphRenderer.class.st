Class {
	#name : #AContractReportMorphRenderer,
	#superclass : #FMorphRenderer,
	#instVars : [
		'commandPanel'
	],
	#category : #'Accounting-GUI-Facing'
}

{ #category : #rendering }
AContractReportMorphRenderer >> commandPanel [
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
AContractReportMorphRenderer >> render [
	self commandPanel.
	self renderCommandButtons.
	self renderOrganization.
	self renderContractNumber.
	self renderAdditionalContractNumber.
	self renderNextLine.
	self render: #accountEditor with: [ :m| m extent: 1@40; hResizing: #spaceFill ].
	self renderNextLine.
	self renderItemsButtons. self renderNextLine.
	self render: #itemsList with: [ :m| m extent: 1@10; hResizing: #spaceFill; vResizing: #spaceFill ].
	^ self owner.
]

{ #category : #rendering }
AContractReportMorphRenderer >> renderAdditionalContractNumber [
	| m |
	m := FText
			on: model
			label: 'Additional Number' translated
			selector: #additionalContractNumber.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AContractReportMorphRenderer >> renderCommandButtons [
	self renderCopyToClipboard.
	self renderMakeReport.
	"self renderNewInvoiceButton.
	self renderNewPaymentButton."
]

{ #category : #rendering }
AContractReportMorphRenderer >> renderContractNumber [
	| m |
	m := FText
			on: model
			label: 'Number' translated
			selector: #contractNumber.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AContractReportMorphRenderer >> renderCopyToClipboard [
	self commandPanel addMorphBack:
			(FButton
				model: model report
				label: (self iconNamed: #smallCopy) asMorph 
				action: #copyToClipboard
				help: 'Copy to Clipboard' translated).
]

{ #category : #rendering }
AContractReportMorphRenderer >> renderDay [
	| m |
	m := FText
			on: model
			label: 'Day' translated
			selector: #day.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AContractReportMorphRenderer >> renderItemsButtons [
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
AContractReportMorphRenderer >> renderMakeReport [
	self commandPanel addMorphBack:
			(FButton
				model: model
				label: (self iconNamed: #smallDoIt) asMorph 
				action: #makeReport
				help: 'Make Report' translated).
]

{ #category : #rendering }
AContractReportMorphRenderer >> renderMonth [
	| m |
	m := FText
			on: model
			label: 'Month' translated
			selector: #month.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AContractReportMorphRenderer >> renderNextLine [
	| m |
	m := Morph new extent: 0@0; setProperty: #cr toValue: true.
	self owner addMorphBack: m
]

{ #category : #rendering }
AContractReportMorphRenderer >> renderOrganization [
	| m |
	m := FText
			on: model
			label: 'Organization' translated
			selector: #organization.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AContractReportMorphRenderer >> renderYear [
	| m |
	m := FText
			on: model
			label: 'Year' translated
			selector: #year.
	m extent: 150@40.
	self owner addMorphBack: m.
]
