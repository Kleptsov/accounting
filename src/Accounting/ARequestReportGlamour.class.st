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
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
ARequestReportGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeBrowserActions.
	self initializeTransmit.
]

{ #category : #initialization }
ARequestReportGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Request Report' translated.
	browser transformation: [ :m| model := m. m ].
	browser row: [ :r| r column: #organization ] size: 68.
	browser row: [ :r| 
		r column: #number.
		r column: #contractNumber.
		r column: #login ] size: 68.
	browser row: [ :r|
		r column: #year.
		r column: #month.
		r column: #day ] size: 68.
	browser row: #selectionItem size: 68.
	browser row: #report.
]

{ #category : #initialization }
ARequestReportGlamour >> initializeBrowserActions [

	browser act: [ :p|
		Clipboard clipboardText: model report printCSV. self inform: 'Copy to Clipboard' ]
		icon: GLMUIThemeExtraIcons glamorousSave
		entitled: 'Copy to Clipboard' translated.

	browser	
		act: [ :p|
				model addAccount1: (AListDialogWindow selectItemFrom: AConfig accountsList).
				p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account' translated.
		
	browser
		act: [ :p|
				model makeReport.
				"model report inspect."
				p update ]
		icon: GLMUIThemeExtraIcons glamorousGo
		entitled: 'Make Report' translated.
		
	browser
		act: [ :b|
			model createContract open. ]
		icon: GLMUIThemeExtraIcons glamorousBrowse
		entitled: 'New Contract' translated.
]

{ #category : #initialization }
ARequestReportGlamour >> initializeContractNumber [
	(browser transmit) to: #contractNumber;
		andShow: [ :a|
			a text
				title: 'Contract Number' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model contractNumber: textPresentation text asString ];
				display: [ :m| m contractNumber ] ].
]

{ #category : #initialization }
ARequestReportGlamour >> initializeDay [
	(browser transmit) to: #day;
		andShow: [ :a|
			a text
				title: 'Day' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model day: textPresentation text asString ];
				display: [ :m| m day ] ].
]

{ #category : #initialization }
ARequestReportGlamour >> initializeLogin [
	(browser transmit) to: #login;
		andShow: [ :a|
			a text
				title: 'Login' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model login: textPresentation text asString ];
				display: [ :m| m login ] ].
]

{ #category : #initialization }
ARequestReportGlamour >> initializeMonth [
	(browser transmit) to: #month;
		andShow: [ :a|
			a text
				title: 'Month' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model month: textPresentation text asString ];
				display: [ :m| m month ] ].
]

{ #category : #initialization }
ARequestReportGlamour >> initializeNumber [
	(browser transmit) to: #number;
		andShow: [ :a|
			a text
				title: 'Number' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model number: textPresentation text asString ];
				display: [ :m| m number ] ].
]

{ #category : #initialization }
ARequestReportGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: [ :a|
			a text
				title: '* ', 'Organization' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model organization: textPresentation text asString ];
				display: [ :m| m organization ] ].
]

{ #category : #initialization }
ARequestReportGlamour >> initializeReport [

	browser transmit to: #report;
		andShow: [ :a|
			a table
				title: 'Report' translated;
				
				act: [ :p| (p pane port: #entity) value removeItem. "model removeItem"
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
	(browser transmit) to: #selectionItem; from: #report port: #selection;
		andShow: [ :a|
			a text
				title: 'Selected Item' translated;
				display: [ :m| model selectionItem: m. m] ].
			
	(browser transmit) to: #selectionItem;
		andShow: [ :a|
			a text
				title: 'Selected Item' translated;
				display: [ :m| m selectionItem ] ].
]

{ #category : #initialization }
ARequestReportGlamour >> initializeTransmit [
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
		andShow: [ :a|
			a text
				title: 'Year' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model year: textPresentation text asString ];
				display: [ :m| m year ] ].
]
