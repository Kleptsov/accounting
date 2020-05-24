"
Графический интерфейс общего отчета по счетам

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ACommonReportGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
ACommonReportGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
ACommonReportGlamour >> initializeAcc1 [
	(browser transmit) to: #acc1;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('1 ', 'Account' translated)
						text: #acc1
						accept: #acc1:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ACommonReportGlamour >> initializeAcc2 [
	(browser transmit) to: #acc2;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('2 ', 'Account' translated)
						text: #acc2
						accept: #acc2:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ACommonReportGlamour >> initializeAcc3 [
	(browser transmit) to: #acc3;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('3 ', 'Account' translated)
						text: #acc3
						accept: #acc3:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ACommonReportGlamour >> initializeAcc4 [
	(browser transmit) to: #acc4;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('4 ', 'Account' translated)
						text: #acc4
						accept: #acc4:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ACommonReportGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser transformation: [ :m| model := m ].
	browser title: 'Common Report' translated.
	browser row: [ :r|
			r column: #acc1.
			r column: #acc2. ] size: 43.
	browser row: [ :r|
			r column: #acc3.
			r column: #acc4. ] size: 43.
	browser row: [ :r|
			r column: #year.
			r column: #month.
			r column: #day ] size: 43.
	browser row: #selected size: 43.
	browser row: #report.
]

{ #category : #initialization }
ACommonReportGlamour >> initializeBrowserActions: aDestination [

	aDestination act: [ :p|
		Clipboard clipboardText: model report printCSV. self inform: 'copy to clipboard' ]
		icon: GLMUIThemeExtraIcons glamorousSave
		entitled: 'Copy to Clipboard' translated.
		
	aDestination
		act: [ :p|
						model addAccount1: (AListDialogWindow selectItemFrom:
										AConfig accountsList).
						p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 1' translated.
		
	aDestination
		act: [ :p| model createWriteOff open ]
		icon: 'Write-off' translated asMorph imageForm
		entitled: 'Create Write-off Document' translated.
		
	aDestination
		act: [ :p| model createRecordingOf open ]
		icon: 'Recording of' translated asMorph imageForm
		entitled: 'Create Recoring of Document' translated.
		
	aDestination
		act: [ :p| model createTransfer open ]
		icon: 'Transfer' translated asMorph imageForm
		entitled: 'Create Transfer Document' translated.
		
	aDestination
		act: [ :p| model makeReport. p update; updateToolbar]
		icon: GLMUIThemeExtraIcons glamorousGo
		entitled: 'Make Report' translated.
]

{ #category : #initialization }
ACommonReportGlamour >> initializeDay [
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
ACommonReportGlamour >> initializeMonth [
	(browser transmit) to: #month;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('Month' translated)
						text: #month
						accept: #month:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ACommonReportGlamour >> initializeReport [
	(browser transmit) to: #report;
		andShow: [ :a| | t |
			t := a table.
			self initializeBrowserActions: t.
			t
				title: 'Common Report' translated;
				onChangeOfPort: #selection act: [ :p| (p pane port: #selection) value ifNotNil: [:el| model selected: el asString  ] ];
				display: [ :m| m report amounts ];
				column: 'Count' translated
					evaluated: [ :each| each amount ] width: 100;
				column: 'Goodies or Currency' translated
					evaluated: [ :each| each printTags ] width: 600;
				column: 'Unix Time' translated
					evaluated: [ :each| each unixTime ] width: 50 ]
]

{ #category : #initialization }
ACommonReportGlamour >> initializeSelected [
	(browser transmit) to: #selected;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('Selected Item' translated)
						text: #selected
						accept: #selected:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ACommonReportGlamour >> initializeTransmit [
	self initializeAcc1.
	self initializeAcc2.
	self initializeAcc3.
	self initializeAcc4.
	self initializeYear.
	self initializeMonth.
	self initializeDay.
	self initializeReport.
	self initializeSelected.
]

{ #category : #initialization }
ACommonReportGlamour >> initializeYear [
	(browser transmit) to: #year;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('Year' translated)
						text: #year
						accept: #year:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]
