Class {
	#name : #ABarcodeSelectorGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
ABarcodeSelectorGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeAccItem1 [
	(browser transmit) to: #accItem1;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:(  'Account' translated, ' 1')
						text: #accItem1
						accept: #accItem1:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeAccItem2 [
	(browser transmit) to: #accItem2;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:(  'Account' translated, ' 2')
						text: #accItem2
						accept: #accItem2:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeAccItem3 [
	(browser transmit) to: #accItem3;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:(  'Account' translated, ' 3')
						text: #accItem3
						accept: #accItem3:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeAccItem4 [
	(browser transmit) to: #accItem4;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:(  'Account' translated, ' 3')
						text: #accItem4
						accept: #accItem4:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeBarcode [
	(browser transmit) to: #barcode;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  'Barcode' translated)
						text: #barcode
						accept: #barcode:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserTitle.
	self initializeBrowserActions.
	browser row: [ :r|
		r column: #accItem1.
		r column: #accItem2.
		r column: #accItem3.
		r column: #accItem4 ] size: 43.
	browser row: #items.
	
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeBrowserActions [

	"browser act: [ :p|
		model addBarcode.
		self inform: ('Barcode' translated, ' ', model barcode, ' ', 'Added as' translated, ' ', model accItem1, ' ', model accItem2) ]
		icon: GLMUIThemeExtraIcons glamorousAdd
		entitled: 'Add Barcode' translated."

	browser act: [ :p| p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousRefresh
		entitled: 'Update' translated.

	browser act: [ :p|
		model addAccount1:(AListDialogWindow selectItemFrom: AConfig accountsList).
						p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 1' translated.
	
"	browser
		act: [ :p | (p pane port: #entity) value makeKassa open ]
		icon: GLMUIThemeExtraIcons glamorousBrowse
		entitled: 'Open Kassa' translated."
	
"	browser
		act: [ :p | browser close. (p pane port: #entity) value clone open ]
		icon: (Smalltalk ui icons iconNamed: #smallCopy)
		entitled: 'Copy Prices Document' translated."

	browser
		act: [ :p | 	model answer: model selection. browser close ]
		icon: Smalltalk ui icons glamorousUp
		entitled: 'Return' translated.
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeBrowserTitle [
	browser title: [:m| 'Barcode Selector' translated].
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeItems [
	(browser transmit) to: #items;
		andShow: [ :a|
			a table
				title: 'Prices' translated;
				act: [:p| model addItem. p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :p| model removeItem. p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				onChangeOfPort: #selection act: [ :p| (p pane port: #selection) value ifNotNil: [ :el| model selection: el ] ];
				
				onChangeOfPort: #strongSelection act: [ :p| (p pane port: #selection) value ifNotNil: [ :el| model strongSelection: el. browser close ] ];
				
				display: [ :m| m items sortByPostTime ];
				column: 'Barcode' translated evaluated: [:el| el printTags ] width: 250;
				column: 'Value' translated evaluated: [ :el| el amounts printString ]
		]
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeTransmit [
	self initializeAccItem1.
	self initializeAccItem2.
	self initializeAccItem3.
	self initializeAccItem4.
	self initializeItems.
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> open [
	browser openOn: model.
]
