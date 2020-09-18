"
Графический интерфейс отчета по заявкам

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ARequestReportGlamour,
	#superclass : #AGlamour,
	#instVars : [
		'tableReport'
	],
	#category : #'Accounting-GUIReport'
}

{ #category : #initialization }
ARequestReportGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
ARequestReportGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Request Report' translated.
	browser transformation: [ :m| model := m. m ].
	browser row: #menu size: 18.
	browser row: [ :r| r column: #organization ] size: 43.
	browser row: [ :r| 
		r column: #number.
		r column: #contractNumber.
		r column: #login ] size: 43.
	browser row: [ :r|
		r column: #year.
		r column: #month.
		r column: #day ] size: 43.
	browser row: #selectionItem size: 43.
	browser row: #report.
]

{ #category : #initialization }
ARequestReportGlamour >> initializeBrowserActionsAt: aBrowser [

	aBrowser act: [ :p|
		Clipboard clipboardText: model report printCSV. self inform: 'Copy to Clipboard' ]
		icon: GLMUIThemeExtraIcons glamorousSave
		entitled: 'Copy to Clipboard' translated.

	aBrowser	
		act: [ :p|
				model addAccount1: (AListDialogWindow selectItemFrom: AConfig accountsList).
				p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account' translated.
		
	aBrowser
		act: [ :b|
			model createContract open. ]
		icon: GLMUIThemeExtraIcons glamorousBrowse
		entitled: 'New Contract' translated.
]

{ #category : #initialization }
ARequestReportGlamour >> initializeContractNumber [
	(browser transmit) to: #contractNumber;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Contract Number' translated
						text: #contractNumber
						accept: #contractNumber:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARequestReportGlamour >> initializeDay [			
	(browser transmit) to: #day;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Day' translated
						text: #day
						accept: #day:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARequestReportGlamour >> initializeLogin [
	(browser transmit) to: #login;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Login' translated
						text: #login
						accept: #login:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARequestReportGlamour >> initializeMenu [
	(browser transmit) to: #menu;
		andShow: [ :composite|
			self initializeBrowserActionsAt: composite ]
]

{ #category : #initialization }
ARequestReportGlamour >> initializeMonth [
	(browser transmit) to: #month;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Month' translated
						text: #month
						accept: #month:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARequestReportGlamour >> initializeNumber [
	(browser transmit) to: #number;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Number' translated
						text: #number
						accept: #number:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARequestReportGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '* ', 'Organization' translated
						text: #organization
						accept: #organization:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARequestReportGlamour >> initializeReport [

	browser transmit to: #report;
		andShow: [ :a|
			a table
			
				act: [ :p|
					model makeReport.
					tableReport ifNotNil: [ tableReport update ] ]
				icon: GLMUIThemeExtraIcons glamorousGo
				entitled: 'Make Report' translated;
			
				onChangeOfPort: #selection act: [ :p|
						(p pane port: #selection) value ifNotNil: [:el|
								model selectionItem: el asString  ] ];
				
				act: [ :p|
						(p pane port: #entity) value removeItem. "model removeItem"
						p update; updateToolbar. ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
					
				display: [ :m| m report amounts ];
				column: 'Count' translated evaluated: [ :each| each amount ] width: 100;
				column: 'Goodies' translated evaluated: [ :each| each printTags ] width: 600;
				column: 'Unix Time' translated evaluated: [ :each| each unixTime ] width: 50 ]
]

{ #category : #initialization }
ARequestReportGlamour >> initializeSelectionItem [
	"(browser transmit) to: #selectionItem; from: #report port: #selection;
		andShow: [ :a|
			a text
				display: [ :m| model selectionItem: m. m] ]."
			
	(browser transmit) to: #selectionItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Selected Item' translated
						text: #selectionItem
						accept: #selectionItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARequestReportGlamour >> initializeTransmit [
	self initializeMenu.
	self initializeNumber.
	self initializeContractNumber.
	self initializeOrganization.
	self initializeLogin.
	self initializeYear.
	self initializeMonth.
	self initializeDay.
	self initializeReport.
	self initializeSelectionItem
]

{ #category : #initialization }
ARequestReportGlamour >> initializeYear [
	(browser transmit) to: #year;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'year' translated
						text: #year
						accept: #year:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]
