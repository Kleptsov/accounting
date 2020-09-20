Class {
	#name : #APriceSelectorGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
APriceSelectorGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
APriceSelectorGlamour >> initializeAccItem1 [
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
APriceSelectorGlamour >> initializeAccItem2 [
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
APriceSelectorGlamour >> initializeAdditional [
	(browser transmit) to: #additional;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  'Additional' translated)
						text: #additional
						accept: #additional:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APriceSelectorGlamour >> initializeAmountItem [
	(browser transmit) to: #amountItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:(  'Count' translated)
						text: #amountItem
						accept: #amountItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APriceSelectorGlamour >> initializeBarcode [
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
APriceSelectorGlamour >> initializeBaseAmount [
	(browser transmit) to: #baseAmount;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Base Currency' translated)
						text: #baseAmount
						accept: #baseAmount:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APriceSelectorGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserTitle.
	self initializeBrowserActions.
	browser row: [ :r|
		r column: #number.
		r column: #organization.
		r column: #baseAmount ] size: 43.
"	browser row: [ :r|
		r column: #amountItem span: 0.1.
		r column: #accItem1 span: 0.35.
		r column: #accItem2 span: 0.35.
		r column: #sumItem span: 0.1.
		r column: #currencyItem span: 0.1. ] size: 43."
	browser row: #items.
	
]

{ #category : #initialization }
APriceSelectorGlamour >> initializeBrowserActions [

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
APriceSelectorGlamour >> initializeBrowserTitle [
	browser title: [:m| m number, ' ', 'Price Document Viewer' translated].
]

{ #category : #initialization }
APriceSelectorGlamour >> initializeCurrencyItem [
	(browser transmit) to: #currencyItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:('Currency' translated)
						text: #currencyItem
						accept: #currencyItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APriceSelectorGlamour >> initializeDate [
	(browser transmit) to: #date;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Date' translated)
						text: #date
						accept: #date:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APriceSelectorGlamour >> initializeItems [
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
				column: 'Count' translated evaluated: [:el| 1 ] width: 100;
				column: 'Goodies' translated evaluated: [:el| el printTags ] width: 250;
				column: 'Price' translated evaluated: [ :el| (model priceFor: el) swapAmount amount ] width: 100;
				column: 'Currency' translated evaluated: [ :el| model baseAmount ] width: 100.
		]
]

{ #category : #initialization }
APriceSelectorGlamour >> initializeNumber [
	(browser transmit) to: #number;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Number' translated)
						text: #number
						accept: #number:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APriceSelectorGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Organization' translated)
						text: #organization
						accept: #organization:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APriceSelectorGlamour >> initializeSumItem [
	(browser transmit) to: #sumItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label:('Sum' translated)
						text: #sumItem
						accept: #sumItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
APriceSelectorGlamour >> initializeTransmit [
	self initializeNumber.
	self initializeOrganization.
	self initializeItems.
	self initializeBaseAmount.
]

{ #category : #initialization }
APriceSelectorGlamour >> open [
	browser openOn: model.
]

{ #category : #initialization }
APriceSelectorGlamour >> priceFor: anAmount [
	|sw|
	sw := anAmount asSwap.
	sw amount: 1.
	sw swapAmount:
		(AAmount new add: model baseAmount;
		amount: (model basePrice / anAmount amount) asFloat).
	^ sw
]
