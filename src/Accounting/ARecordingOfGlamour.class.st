"
Графический интерфейс документа оприходывания

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ARecordingOfGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #actions }
ARecordingOfGlamour >> downSelectionFrom: aPresentation [
	| aSwap |
	aSwap := (aPresentation pane port: #selection) value.
	model downItem: aSwap.
]

{ #category : #initialization }
ARecordingOfGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeAccItem1 [
	(browser transmit) to: #accItem1;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('Account' translated, ' 1')
						text: #accountItem1
						accept: #accountItem1:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeAccItem2 [
	(browser transmit) to: #accItem2;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('Account' translated, ' 2')
						text: #accountItem2
						accept: #accountItem2:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ].
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeAccItem3 [
	(browser transmit) to: #accItem3;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('Account' translated, ' 3')
						text: #accountItem3
						accept: #accountItem3:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ].
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeAccount2 [
	(browser transmit) to: #account2;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('Account' translated, ' 2')
						text: #account2
						accept: #account2:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeAccount3 [
	(browser transmit) to: #account3;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('Account' translated, ' 3')
						text: #account3
						accept: #account3:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeAdditional [
	(browser transmit) to: #additional;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Additional' translated
						text: #additional
						accept: #additional:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeAmountItem [
	(browser transmit) to: #amountItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Amount' translated
						text: #amountItem
						accept: #amountItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: [ :m| m number, ' ', 'Recording of' translated ] .
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserActions.
	browser row: [ :r|
		r column: #number.
		r column: #date.
	] size: 43.
	browser row: [ :r|
		r column: #organization.
		r column: #account2.
		r column: #account3.
	] size: 43.
	browser row: #additional size: 43.
	browser row: #editor size: 0.
	browser row: [ :r|
		r column: #amountItem span: 0.1.
		r column: #accItem1 span: 0.3.
		r column: #accItem2 span: 0.3.
		r column: #accItem3 span: 0.3.
	 ] size: 43.
	browser row: #items.
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeBrowserActions [
	
	browser act: [ :p|
		Clipboard clipboardText: model items printCSV. self inform: 'copy to clipboard' ]
		icon: GLMUIThemeExtraIcons glamorousSave
		entitled: 'Copy to Clipboard' translated.
		
	browser act: [ :p|
		model addAccount1:(AListDialogWindow selectItemFrom: AConfig accountsList).
						p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 1' translated.
		
	browser act: [ :p|
			model removeAccounts.
			p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousUndo
		entitled: 'Unwire' translated.
		
	browser act: [ :p|
		model accept.
		p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousAccept
		entitled: 'Accept' translated
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeDate [
	(browser transmit) to: #date;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('* ', 'Date' translated, 'dd:mm:yyyy' translated)
						text: #date
						accept: #date:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeItems [
	(browser transmit) to: #items;
		andShow: [ :a|
			a table
				title: '* ', 'Items' translated;
				
				act: [ :p| self upSelectionFrom: p. p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousUp
				entitled: 'Up' translated;
				
				act: [ :p| self downSelectionFrom: p. p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousDown
				entitled: 'Down' translated;
				
				act: [ :p| (p pane port: #entity) value addItem. "model addItem"
								p update ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :p| (p pane port: #entity) value removeItem. "model removeItem"
								p update ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				onChangeOfPort: #selection act: [ :p|
					((p pane port: #selection) value) ifNotNil: [ :m| model selectionItem: m ] ];

				display: [ :m| m items sortByPostTime ];
				
				column: 'Count' translated evaluated: [ :each| each amount asString ] width: 100;
				column: 'Goodies' translated evaluated: [ :each| each printTags ] width: 600;
				column: 'Unix Time' translated evaluated: [ :each| each unixTime printString ] width: 50 ]
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeNumber [
	(browser transmit) to: #number;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('* ', 'Number' translated)
						text: #number
						accept: #number:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('* ', 'Organization' translated)
						text: #organization
						accept: #organization:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ARecordingOfGlamour >> initializeTransmit [
	self initializeAccItem1.
	self initializeNumber.
	self initializeDate.
	self initializeOrganization.
	self initializeAccount2.
	self initializeAccount3.
	self initializeAdditional.
	self initializeAmountItem.
	self initializeAccItem2.
	self initializeAccItem3.
	self initializeItems.
	
]

{ #category : #initialization }
ARecordingOfGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
ARecordingOfGlamour >> upSelectionFrom: aPresentation [
	| aSwap |
	aSwap := (aPresentation pane port: #selection) value.
	model upItem: aSwap.
]
