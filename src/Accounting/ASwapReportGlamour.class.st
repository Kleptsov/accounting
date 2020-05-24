"
Графический интерфейс отчета по обменным операциям

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ASwapReportGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
ASwapReportGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeBrowserActions.
	self initializeTransmit.
]

{ #category : #initialization }
ASwapReportGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Swap Report' translated.
	browser transformation: [ :m| model := m. m ].
	browser row: [ :r| r column: #organization.
							r column: #swapNumber ] size: 68.
	browser row: [ :r|
		r column: #year.
		r column: #month.
		r column: #day ] size: 68.
	browser row: #report.
	browser row: #selectedItem size: 68.
]

{ #category : #initialization }
ASwapReportGlamour >> initializeBrowserActions [

	browser act: [ :p|
		Clipboard clipboardText: model report printCSV. self inform: 'copy to clipboard' ]
		icon: GLMUIThemeExtraIcons glamorousSave
		entitled: 'Copy to Clipboard' translated.
		
	browser act: [ :p|
						model addAccount1: (AListDialogWindow selectItemFrom:
										AConfig accountsList).
						p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousInto
				entitled: 'Add Account 1' translated.
				
	browser
		act: [ :p| model makeReport. p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousGo
		entitled: 'Make Report' translated.
]

{ #category : #initialization }
ASwapReportGlamour >> initializeDay [
	(browser transmit) to: #day;
		andShow: [ :a|
			a text
				title: 'Day' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model day: textPresentation text asString ];
				display: [ :m| m day ] ].
]

{ #category : #initialization }
ASwapReportGlamour >> initializeMonth [
	(browser transmit) to: #month;
		andShow: [ :a|
			a text
				title: 'Month' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model month: textPresentation text asString ];
				display: [ :m| m month ] ].
]

{ #category : #initialization }
ASwapReportGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: [ :a|
			a text
				title: '* ', 'Organization' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model organization: textPresentation text asString ];
				display: [ :m| m organization ] ].
]

{ #category : #initialization }
ASwapReportGlamour >> initializeReport [

	browser transmit to: #report;
		andShow: [ :a|
			a table
				title: 'Report' translated;
				display: [ :m| m report amounts];
				column: 'Count' translated evaluated: [ :each| each amount ] width: 100;
				column: 'Goodies' translated evaluated: [ :each| each printTags ] width: 600;
				column: 'Unix Time' translated evaluated: [ :each| each unixTime ] width: 50 ]
]

{ #category : #initialization }
ASwapReportGlamour >> initializeSelectedItem [
	(browser transmit) to: #selectedItem;
		andShow: [ :a|
			a text
				title: 'Selected Item' translated;
				display: [ :m| m selectedItem ] ].
			
	(browser transmit) to: #selectedItem; from: #report port: #selection;
		andShow: [ :a|
			a text
				title: 'Selected Item' translated;
				display: [ :m| model selectedItem: m. m ] ]
]

{ #category : #initialization }
ASwapReportGlamour >> initializeSwapNumber [
	(browser transmit) to: #swapNumber;
		andShow: [ :a|
			a text
				title: 'Swap Number' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model swapNumber: textPresentation text asString ];
				display: [ :m| m swapNumber ] ].
]

{ #category : #initialization }
ASwapReportGlamour >> initializeTransmit [
	self initializeSwapNumber.
	self initializeOrganization.
	self initializeYear.
	self initializeMonth.
	self initializeDay.
	self initializeReport.
	self initializeSelectedItem.
]

{ #category : #initialization }
ASwapReportGlamour >> initializeYear [
	(browser transmit) to: #year;
		andShow: [ :a|
			a text
				title: 'Year' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model year: textPresentation text asString ];
				display: [ :m| m year ] ].
]
