"
Настройки кассы

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AKassaSettingGlamour,
	#superclass : #AGlamour,
	#instVars : [
		'rootBrowser'
	],
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
AKassaSettingGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
AKassaSettingGlamour >> initializeAdditianal [
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
AKassaSettingGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser transformation: [ :m| self model: m. m ].
	browser title: [:m| 'Kassa Settings' translated].
	browser row: [ :r|
		r column: #number.
		r column: #date ] size: 43.
	browser row: [ :r|
		r column: #organization..
		r column: #store.
	] size: 43.
	browser row: [ :r|
		r column: #contractor.
		r column: #contractorAccount ] size: 43.
	browser row: [ :r|
		r column: #priceAccount.
		r column: #currency ] size: 43.
	browser row: [ :r|
		r column: #additional.] size: 43.
	browser row: #tmp.
]

{ #category : #initialization }
AKassaSettingGlamour >> initializeContractor [
	(browser transmit) to: #contractor;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Acquirer' translated)
						text: #contractor
						accept: #contractor:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AKassaSettingGlamour >> initializeContractorAccount [
	(browser transmit) to: #contractorAccount;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Acquirer Account' translated)
						text: #contractorAccount
						accept: #contractorAccount:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AKassaSettingGlamour >> initializeCurrency [
	(browser transmit) to: #currency;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Currency' translated)
						text: #currency
						accept: #currency:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AKassaSettingGlamour >> initializeDate [
	(browser transmit) to: #date;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'dd:mm:yyyy' translated, 'Date' translated)
						text: #date
						accept: #date:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AKassaSettingGlamour >> initializeNumber [
	(browser transmit) to: #number;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Number' translated)
						text: #number
						accept: #number:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AKassaSettingGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Organization' translated)
						text: #organization
						accept: #organization:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AKassaSettingGlamour >> initializePriceAccount [
	(browser transmit) to: #priceAccount;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Price Account' translated)
						text: #priceAccount
						accept: #priceAccount:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AKassaSettingGlamour >> initializeStore [
	(browser transmit) to: #store;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Store' translated)
						text: #store
						accept: #store:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AKassaSettingGlamour >> initializeTransmit [
	self initializeNumber.
	self initializeDate.
	self initializeOrganization.
	self initializeStore.
	self initializeContractor.
	self initializeContractorAccount.
	self initializePriceAccount.
	self initializeCurrency.
	self initializeAdditianal.
]

{ #category : #initialization }
AKassaSettingGlamour >> open [
	browser openOn: model.
]

{ #category : #accessing }
AKassaSettingGlamour >> rootBrowser [
	^ rootBrowser
]

{ #category : #accessing }
AKassaSettingGlamour >> rootBrowser: anObject [
	rootBrowser := anObject
]
