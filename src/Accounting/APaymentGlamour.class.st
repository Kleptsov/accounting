"
Графический интерфейс платежки

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #APaymentGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
APaymentGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
APaymentGlamour >> initializeAdditional [
	(browser transmit) to: #additional;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  'Additional' translated)
						text: #additional
						accept: #additional:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APaymentGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	self initializeBrowserActions.
	browser title: 'Payment' translated.
	browser transformation: [ :m| self model: m. m ].
	browser row: [ :r|
		r column: #accepted.
		r column: #organization ] size: 43.
	browser row: [ :r|
		r column: #contractor ] size: 43.
	browser row: [ :r|
		r column: #number.
		r column: #contractNumber.
		r column: #date ] size: 43.
	browser row: [ :r|
		r column: #currencyName.
		r column: #receiptName.
		r column: #sum ] size: 43.
	browser row: #additional size: 43.
	browser row: #extent.
]

{ #category : #initialization }
APaymentGlamour >> initializeBrowserActions [
		
	browser act: [ :p|
		model addAccount1:(AListDialogWindow selectItemFrom: AConfig accountsList).
						p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 1' translated.
		
	browser act: [ :p|
		model addAccount2:(AListDialogWindow selectItemFrom: AConfig accountsList).
						p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 2' translated.
		
	browser act: [ :p|
			model removeAccounts.
			p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousUndo
		entitled: 'Unwire' translated.
		
	browser
		addAction: (AAction accept: [ model accept]).
]

{ #category : #initialization }
APaymentGlamour >> initializeContractNumber [
	(browser transmit) to: #contractNumber;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '*', 'Contract Number' translated)
						text: #contractNumber
						accept: #contractNumber:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APaymentGlamour >> initializeContractor [
	(browser transmit) to: #contractor;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '*', 'Contractor' translated)
						text: #contractor
						accept: #contractor:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APaymentGlamour >> initializeCurrencyName [
	(browser transmit) to: #currencyName;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '*', 'Currency Name' translated)
						text: #currencyName
						accept: #currencyName:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APaymentGlamour >> initializeDate [
	(browser transmit) to: #date;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '*', 'Date' translated)
						text: #date
						accept: #date:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APaymentGlamour >> initializeNumber [
	(browser transmit) to: #number;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '*', 'Number' translated)
						text: #number
						accept: #number:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APaymentGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '*', 'Organization' translated)
						text: #organization
						accept: #organization:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APaymentGlamour >> initializeReceiptName [
	(browser transmit) to: #receiptName;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '*', 'Receipt Name' translated)
						text: #receiptName
						accept: #receiptName:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APaymentGlamour >> initializeSum [
	(browser transmit) to: #sum;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '*', 'Sum' translated)
						text: #sum
						accept: #sum:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APaymentGlamour >> initializeTransmit [
	self initializeAccepted.
	self initializeNumber.
	self initializeContractNumber.
	self initializeDate.
	self initializeCurrencyName.
	self initializeReceiptName.
	self initializeSum.
	self initializeOrganization.
	self initializeContractor.
	self initializeAdditional.
]

{ #category : #opening }
APaymentGlamour >> open [
	browser openOn: model
]
