Class {
	#name : #AAccountExplorerGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
AAccountExplorerGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
AAccountExplorerGlamour >> initializeAccItem1 [
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
AAccountExplorerGlamour >> initializeAccItem2 [
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
AAccountExplorerGlamour >> initializeAccItem3 [
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
AAccountExplorerGlamour >> initializeAccItem4 [
	(browser transmit) to: #accItem4;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:(  'Account' translated, ' 4')
						text: #accItem4
						accept: #accItem4:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AAccountExplorerGlamour >> initializeBarcode [
	(browser transmit) to: #barcode;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:(  'Barcode' translated)
						text: #barcode
						accept: #barcode:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AAccountExplorerGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserTitle.
	self initializeBrowserActions.
	browser row: [ :r|
		r column: #accItem1.
		r column: #accItem2.
		r column: #accItem3.
		r column: #accItem4. ] size: 43.
	browser row: [ :r|
		r column: #currencyItem.
		r column: #currencyItem2.
		r column: #currencyItem3.
		r column: #currencyItem4 ] size: 43.
	browser row: #items.
	
]

{ #category : #initialization }
AAccountExplorerGlamour >> initializeBrowserActions [

	browser act: [ :p| p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousRefresh
		entitled: 'Update' translated.

	browser act: [ :p|
		model addAccount1:(AListDialogWindow selectItemFrom: AConfig accountsList).
						p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 1' translated.

	browser
		act: [ :p | 	model answer: model selection. browser close ]
		icon: Smalltalk ui icons glamorousUp
		entitled: 'Return' translated.
]

{ #category : #initialization }
AAccountExplorerGlamour >> initializeBrowserTitle [
	browser title: [:m| 'Barcode Selector' translated].
]

{ #category : #initialization }
AAccountExplorerGlamour >> initializeCurrencyItem [
	(browser transmit) to: #currencyItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:('Account' translated, ' 5')
						text: #currencyItem
						accept: #currencyItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AAccountExplorerGlamour >> initializeCurrencyItem2 [
	(browser transmit) to: #currencyItem2;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:('Account' translated, ' 6')
						text: #currencyItem2
						accept: #currencyItem2:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AAccountExplorerGlamour >> initializeCurrencyItem3 [
	(browser transmit) to: #currencyItem3;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:('Account' translated, ' 7')
						text: #currencyItem3
						accept: #currencyItem3:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AAccountExplorerGlamour >> initializeCurrencyItem4 [
	(browser transmit) to: #currencyItem4;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:('Account' translated, ' 8')
						text: #currencyItem4
						accept: #currencyItem4:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AAccountExplorerGlamour >> initializeItems [
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
				
				onChangeOfPort: #selection act: [ :p| (p pane port: #selection) value ifNotNil: [ :el| model ] ];
				
				onChangeOfPort: #strongSelection act: [ :p| (p pane port: #selection) value ifNotNil: [ :el| model ] ];
				
				display: [ :m| m items sortByPostTime ];
				column: 'Count' translated evaluated: [:el| el amount ] width: 100;
				column: 'Goodies' translated evaluated: [:el| el printTags ] width: 250.
		]
]

{ #category : #initialization }
AAccountExplorerGlamour >> initializeTransmit [
	self initializeAccItem1.
	self initializeAccItem2.
	self initializeAccItem3.
	self initializeAccItem4.
	self initializeCurrencyItem.
	self initializeCurrencyItem2.
	self initializeCurrencyItem3.
	self initializeCurrencyItem4.
	self initializeItems.
]

{ #category : #initialization }
AAccountExplorerGlamour >> open [
	browser openOn: model.
]
