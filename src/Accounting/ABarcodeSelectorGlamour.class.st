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
						label:(  'Barcode' translated)
						text: #accItem1
						accept: #accItem1:
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
		r column: #accItem1 span: 0.25.
		r column: #currencyItem span: 0.25.
		r column: #currencyItem2 span: 0.25.
		r column: #currencyItem3 span: 0.25 ] size: 43.
	browser row: #items.
	
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeBrowserActions [

	browser act: [ :p| p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousRefresh
		entitled: 'Update' translated.

	browser act: [ :p|
		model addAccount1:(AListDialogWindow selectItemFrom: AConfig accountsList).
						p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 1' translated.

	browser
		act: [ :p | 	model return. browser close ]
		icon: Smalltalk ui icons glamorousUp
		entitled: 'Return' translated.
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeBrowserTitle [
	browser title: [:m| 'Barcode Selector' translated].
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeCurrencyItem [
	(browser transmit) to: #currencyItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:(  'Value' translated)
						text: #currencyItem
						accept: #currencyItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeCurrencyItem2 [
	(browser transmit) to: #currencyItem2;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:(  'Value' translated, ' 2')
						text: #currencyItem2
						accept: #currencyItem2:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeCurrencyItem3 [
	(browser transmit) to: #currencyItem3;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:(  'Value' translated, ' 3')
						text: #currencyItem3
						accept: #currencyItem3:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
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
				
				onChangeOfPort: #selection act: [ :p| (p pane port: #selection) value ifNotNil: [ :el| model accountEditor updateEditor: el ] ];
				
				onChangeOfPort: #strongSelection act: [ :p| (p pane port: #selection) value ifNotNil: [ :el| model strongSelection: el. browser close ] ];
				
				display: [ :m| m items ];
				column: 'Barcode' translated evaluated: [:el| el printTags ] width: 250;
				column: 'Value' translated evaluated: [ :el| el amounts inject: '' into: [ :el1 :el2| el1, el2 printTags , ' ' ] ]
		]
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> initializeTransmit [
	self initializeAccItem1.
	self initializeCurrencyItem.
	self initializeCurrencyItem2.
	self initializeCurrencyItem3.
	self initializeItems.
]

{ #category : #initialization }
ABarcodeSelectorGlamour >> open [
	browser openOn: model.
]
