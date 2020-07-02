"
Отчет по контракту (ам) включает в себя выборку по контрактам, накладным и платежкам.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AContractReportGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
AContractReportGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
AContractReportGlamour >> initializeAdditionalContractNumber [
	(browser transmit) to: #additionalContractNumber;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ( 'Additional Contract Number' translated)
						text: #additionalContractNumber
						accept: #additionalContractNumber:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AContractReportGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Contract Report' translated.
	browser transformation: [ :m| model := m. m ].
	browser row: #menu size: 20.
	browser row: [ :r| r column: #organization.
							r column: #contractNumber.
							r column: #additionalContractNumber ] size: 43.
	browser row: [ :r|
		r column: #year.
		r column: #month.
		r column: #day ] size: 43.
	browser row: #selectedItem size: 43.
	browser row: #report.
]

{ #category : #initialization }
AContractReportGlamour >> initializeBrowserActions [
	browser act: [ :p|
						model addAccount1: (AListDialogWindow selectItemFrom:
										AConfig accountsList).
						p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousInto
				entitled: 'Add Account 1' translated.
				
	browser
		act: [ :p|
				model makeReport.
				"model report inspect."
				p update ]
		icon: GLMUIThemeExtraIcons glamorousGo
		entitled: 'Make Report' translated.
		
	browser
		act: [ :b|
			model createInvoice open. ]
		icon: GLMUIThemeExtraIcons glamorousBrowse
		entitled: 'New Invoice' translated.
		
	browser
		act: [ :b|
			model createPayment open. ]
		icon: GLMUIThemeExtraIcons glamorousBrowse
		entitled: 'New Payment' translated.
]

{ #category : #initialization }
AContractReportGlamour >> initializeBrowserActionsAt: aBrowser [
	aBrowser act: [ :p|
						model addAccount1: (AListDialogWindow selectItemFrom:
										AConfig accountsList).
						p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousInto
				entitled: 'Add Account 1' translated.
				
	aBrowser
		act: [ :p|
				model makeReport.
				"model report inspect."
				p update ]
		icon: GLMUIThemeExtraIcons glamorousGo
		entitled: 'Make Report' translated.
		
	aBrowser
		act: [ :b|
			model createInvoice open. ]
		icon: GLMUIThemeExtraIcons glamorousBrowse
		entitled: 'New Invoice' translated.
		
	aBrowser
		act: [ :b|
			model createPayment open. ]
		icon: GLMUIThemeExtraIcons glamorousBrowse
		entitled: 'New Payment' translated.
]

{ #category : #initialization }
AContractReportGlamour >> initializeContractNumber [
	(browser transmit) to: #contractNumber;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ( 'Contract Number' translated)
						text: #contractNumber
						accept: #contractNumber:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AContractReportGlamour >> initializeDay [
	(browser transmit) to: #day;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ( 'Day' translated)
						text: #day
						accept: #day:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AContractReportGlamour >> initializeMenu [
	(browser transmit) to: #menu;
		andShow: [ :composite|
			self initializeBrowserActionsAt: composite ].
]

{ #category : #initialization }
AContractReportGlamour >> initializeMonth [
	(browser transmit) to: #month;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ( 'Month' translated)
						text: #month
						accept: #month:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AContractReportGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ( 'Organization' translated)
						text: #organization
						accept: #organization:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AContractReportGlamour >> initializeReport [

	browser transmit to: #report;
		andShow: [ :a|
			a table
				onChangeOfPort: #selection act: [ :p| (p pane port: #selection) value ifNotNil: [ :el| model selectedItem: el asString ] ];
				display: [ :m| m report amounts ];
				column: 'Count' translated evaluated: [ :each| each amount ] width: 100;
				column: 'Goodies' translated evaluated: [ :each| each printTags ] width: 600;
				column: 'Unix Time' translated evaluated: [ :each| each unixTime ] width: 50 ]
]

{ #category : #initialization }
AContractReportGlamour >> initializeSelectedItem [
	(browser transmit) to: #selectedItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ( 'Selected Item' translated)
						text: #selectedItem
						accept: #selectedItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AContractReportGlamour >> initializeTransmit [
	self initializeMenu.
	self initializeContractNumber.
	self initializeAdditionalContractNumber.
	self initializeOrganization.
	self initializeYear.
	self initializeMonth.
	self initializeDay.
	self initializeReport.
	self initializeSelectedItem.
]

{ #category : #initialization }
AContractReportGlamour >> initializeYear [
	(browser transmit) to: #year;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ( 'Year' translated)
						text: #year
						accept: #year:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]
