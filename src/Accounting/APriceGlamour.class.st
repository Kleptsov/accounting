"
Графический интерфейс цен

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #APriceGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
APriceGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
APriceGlamour >> initializeAccItem1 [
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
APriceGlamour >> initializeAccItem2 [
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
APriceGlamour >> initializeAdditional [
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
APriceGlamour >> initializeAmountItem [
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
APriceGlamour >> initializeBarcode [
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
APriceGlamour >> initializeBaseAmount [
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
APriceGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserTitle.
	self initializeBrowserActions.
	browser row: [ :r|
		r column: #number.
		r column: #date.
	] size: 43.
	browser row: [ :r|
		r column: #organization.
		r column: #baseAmount ] size: 43.
	browser row: [:r|
		r column: #barcode span: 0.3.
		r column: #additional span: 0.7 ] size: 43.
	browser row: [ :r|
		r column: #amountItem span: 0.1.
		r column: #accItem1 span: 0.35.
		r column: #accItem2 span: 0.35.
		r column: #sumItem span: 0.1.
		r column: #currencyItem span: 0.1. ] size: 43.
	browser row: #items.
	
]

{ #category : #initialization }
APriceGlamour >> initializeBrowserActions [

	browser act: [ :p|
		model addBarcode.
		self inform: ('Barcode' translated, ' ', model barcode, ' ', 'Added as' translated, ' ', model accItem1, ' ', model accItem2) ]
		icon: GLMUIThemeExtraIcons glamorousAdd
		entitled: 'Add Barcode' translated.

	browser act: [ :p| p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousRefresh
		entitled: 'Update' translated.

	browser act: [ :p|
		model addAccount1:(AListDialogWindow selectItemFrom: AConfig accountsList).
						p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 1' translated.
	
	browser
		act: [ :p | (p pane port: #entity) value makeKassa open ]
		icon: GLMUIThemeExtraIcons glamorousBrowse
		entitled: 'Open Kassa' translated.
	
	browser
		act: [ :p | browser close. (p pane port: #entity) value clone open ]
		icon: (Smalltalk ui icons iconNamed: #smallCopy)
		entitled: 'Copy Prices Document' translated.

	browser
		act: [ :p | 	model accept. p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousAccept
		entitled: 'Accept' translated.
]

{ #category : #initialization }
APriceGlamour >> initializeBrowserTitle [
	browser title: [:m| m number, ' ', 'Price Document' translated].
]

{ #category : #initialization }
APriceGlamour >> initializeCurrencyItem [
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
APriceGlamour >> initializeDate [
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
APriceGlamour >> initializeItems [
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
				
				display: [ :m| m items sortByPostTime ];
				column: 'Count' translated evaluated: [:el| 1 ] width: 100;
				column: 'Goodies' translated evaluated: [:el| el printTags ] width: 250;
				column: 'Price' translated evaluated: [ :el| (model priceFor: el) swapAmount amount ] width: 100;
				column: 'Currency' translated evaluated: [ :el| model baseAmount ] width: 100.
		]
]

{ #category : #initialization }
APriceGlamour >> initializeNumber [
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
APriceGlamour >> initializeOrganization [
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
APriceGlamour >> initializeSumItem [
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
APriceGlamour >> initializeTransmit [
	self initializeNumber.
	self initializeOrganization.
	self initializeDate.
	self initializeBarcode.
	self initializeAdditional.
	self initializeAmountItem.
	self initializeAccItem1.
	self initializeAccItem2.
	self initializeSumItem.
	self initializeCurrencyItem.
	self initializeItems.
	self initializeBaseAmount.
]

{ #category : #initialization }
APriceGlamour >> open [
	browser openOn: model.
]

{ #category : #initialization }
APriceGlamour >> priceFor: anAmount [
	|sw|
	sw := anAmount asSwap.
	sw amount: 1.
	sw swapAmount:
		(AAmount new add: model baseAmount;
		amount: (model basePrice / anAmount amount) asFloat).
	^ sw
]
