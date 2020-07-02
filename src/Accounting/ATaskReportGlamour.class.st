"
Графический интерфейс отчетов по заданиям

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ATaskReportGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
ATaskReportGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
ATaskReportGlamour >> initializeAccount [
	(browser transmit) to: #account;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Account' translated
						text: #account
						accept: #account:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATaskReportGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Task Report' translated.
	browser transformation: [ :m| model := m. m ].
	browser row: #menu size: 18.
	browser row: [ :r| r column: #organization.
							r column: #login.
							r column: #account ] size: 43.
	browser row: #a1 size: 5.
	browser row: [ :r|
		r column: #year.
		r column: #month.
		r column: #day ] size: 43.
	browser row: #a2 size: 5.
	browser row: #selectedTask size: 43.
	browser row: #report.
]

{ #category : #initialization }
ATaskReportGlamour >> initializeBrowserActions [
	browser act: [ :p|
		model createExecuteTask open]
		icon: GLMUIThemeExtraIcons glamorousBrowse
		entitled: 'Create Execute Task' translated.
	
	browser act: [ :p|
		Clipboard clipboardText: model report printCSV. self inform: 'copy to clipboard' ]
		icon: GLMUIThemeExtraIcons glamorousSave
		entitled: 'Copy to Clipboard' translated.
	
	browser	
		act: [ :p|
				model addAccount1: (AListDialogWindow selectItemFrom: AConfig accountsList).
				p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 1' translated;
		
		act: [ :p| model makeReport. p update; updateToolbar]
		icon: GLMUIThemeExtraIcons glamorousGo
		entitled: 'Make Report' translated.
]

{ #category : #initialization }
ATaskReportGlamour >> initializeBrowserActionsAt: aBrowser [
	aBrowser act: [ :p|
		model createExecuteTask open]
		icon: GLMUIThemeExtraIcons glamorousBrowse
		entitled: 'Create Execute Task' translated.
	
	aBrowser act: [ :p|
		Clipboard clipboardText: model report printCSV. self inform: 'copy to clipboard' ]
		icon: GLMUIThemeExtraIcons glamorousSave
		entitled: 'Copy to Clipboard' translated.
	
	aBrowser	
		act: [ :p|
				model addAccount1: (AListDialogWindow selectItemFrom: AConfig accountsList).
				p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 1' translated;
		
		act: [ :p| model makeReport. p update; updateToolbar]
		icon: GLMUIThemeExtraIcons glamorousGo
		entitled: 'Make Report' translated.
]

{ #category : #initialization }
ATaskReportGlamour >> initializeDay [
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
ATaskReportGlamour >> initializeLogin [
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
ATaskReportGlamour >> initializeMenu [
	(browser transmit) to: #menu;
		andShow: [ :composite|
			self initializeBrowserActionsAt: composite]
]

{ #category : #initialization }
ATaskReportGlamour >> initializeMonth [
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
ATaskReportGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Organization' translated
						text: #organization
						accept: #organization:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATaskReportGlamour >> initializeReport [

	browser transmit to: #report;
		andShow: [ :a|
			a table
				onChangeOfPort: #selection act: [ :p|
						(p pane port: #selection) value ifNotNil: [ :el|
								model selectedTask: el ] ];
				display: [ :m| m report sortByPostTime ];
				column: 'Count' translated evaluated: [ :each| each amount ] width: 50;
				column: 'Goodies' translated evaluated: [ :each| each printTags ] width: 600;
				column: 'Unix Time' translated evaluated: [ :each| each unixTime ] width: 50 ]
]

{ #category : #initialization }
ATaskReportGlamour >> initializeSelectedTask [
	(browser transmit) to: #selectedTask;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('Selected Task' translated)
						text: #selectedTaskString
						accept: #selectedTaskString:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATaskReportGlamour >> initializeTransmit [
	self initializeMenu.
	self initializeOrganization.
	self initializeLogin.
	self initializeAccount.
	self initializeYear.
	self initializeMonth.
	self initializeDay.
	self initializeReport.
	self initializeSelectedTask.
]

{ #category : #initialization }
ATaskReportGlamour >> initializeYear [
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
