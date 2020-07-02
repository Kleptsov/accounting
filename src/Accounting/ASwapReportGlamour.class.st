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
	self initializeTransmit.
]

{ #category : #initialization }
ASwapReportGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser transformation: [ :m| model := m. m ].
	browser row: #menu size: 18.
	browser row: [ :r| r column: #organization.
							r column: #swapNumber ] size: 43.
	browser row: [ :r|
		r column: #year.
		r column: #month.
		r column: #day ] size: 43.
	browser row: #selectedItem size: 43.
	browser row: #report.
]

{ #category : #initialization }
ASwapReportGlamour >> initializeBrowserActionsAt: aBrowser [

	aBrowser act: [ :p|
		Clipboard clipboardText: model report printCSV. self inform: 'copy to clipboard' ]
		icon: GLMUIThemeExtraIcons glamorousSave
		entitled: 'Copy to Clipboard' translated.
		
	aBrowser act: [ :p|
						model addAccount1: (AListDialogWindow selectItemFrom:
										AConfig accountsList).
						p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousInto
				entitled: 'Add Account 1' translated.
				
	aBrowser
		act: [ :p| model makeReport. p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousGo
		entitled: 'Make Report' translated.
]

{ #category : #initialization }
ASwapReportGlamour >> initializeDay [
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
ASwapReportGlamour >> initializeMenu [
	(browser transmit) to: #menu;
		andShow: [ :composite|
			self initializeBrowserActionsAt: composite ]
]

{ #category : #initialization }
ASwapReportGlamour >> initializeMonth [
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
ASwapReportGlamour >> initializeOrganization [
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
ASwapReportGlamour >> initializeReport [

	browser transmit to: #report;
		andShow: [ :a|
			a table
				onChangeOfPort: #selection act: [ :p|
						(p pane port: #selection) value ifNotNil: [:el|
								model selectedItem: el asString  ] ];
				display: [ :m| m report amounts];
				column: 'Count' translated evaluated: [ :each| each amount ] width: 100;
				column: 'Goodies' translated evaluated: [ :each| each printTags ] width: 600;
				column: 'Unix Time' translated evaluated: [ :each| each unixTime ] width: 50 ]
]

{ #category : #initialization }
ASwapReportGlamour >> initializeSelectedItem [
	(browser transmit) to: #selectedItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Selected Item' translated
						text: #selectedItem
						accept: #selectedItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ASwapReportGlamour >> initializeSwapNumber [
	(browser transmit) to: #swapNumber;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Swap Number' translated
						text: #swapNumber
						accept: #swapNumber:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ASwapReportGlamour >> initializeTransmit [
	self initializeMenu.
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
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Year' translated
						text: #year
						accept: #year:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]
