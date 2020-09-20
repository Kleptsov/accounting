"
Графический интерфейс документа перемещения 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ATransferGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #actions }
ATransferGlamour >> downSelectionFrom: aPresentation [
	| aSwap |
	aSwap := (aPresentation pane port: #selection) value.
	model downItem: aSwap.
]

{ #category : #initialization }
ATransferGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
ATransferGlamour >> initializeAccItem1 [
	(browser transmit) to: #accItem1;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label: ('Account' translated, ' 1')
						text: #accItem1
						accept: #accItem1:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeAccItem2 [
	(browser transmit) to: #accItem2;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label: ('Account' translated, ' 2')
						text: #accItem2
						accept: #accItem2:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeAdditional [			
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
ATransferGlamour >> initializeAmountItem [
	(browser transmit) to: #amountItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label: 'Count' translated
						text: #amountItem
						accept: #amountItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeBarcode [
	(browser transmit) to: #barcode2;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('Barcode' translated)
						text: #barcode
						accept: #barcode:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: [ :m| m number, ' ', 'Transfer' translated ] .
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserActions.
	browser row: [ :r|
		r column: #accepted.
		r column: #number.
		r column: #date. ] size: 43.
	browser row: [ :r1|
		r1 column: #organization.
		r1 column: #sourceAccount.
		r1 column: #destAccount.
	] size: 43.
	browser row: [:r2|
		r2 column: #barcode2 span: 0.3.
		r2 column: #additional span: 0.7. ] size: 43.
	browser row: [:r3|
		r3 column: #amountItem span: 0.1.
		r3 column: #accItem1 span: 0.35.
		r3 column: #accItem2 span: 0.35.
		r3 column: #sumItem span: 0.1.
		r3 column: #currencyItem span: 0.1 ] size: 43.
	browser row: #items.
]

{ #category : #initialization }
ATransferGlamour >> initializeBrowserActions [

	browser act: [ :p|
		model addBarcode.
		self inform: ('Barcode' translated, ' ', model barcode, ' ', 'Added as' translated, ' ', model accItem1, ' ', model accItem2) ]
		icon: GLMUIThemeExtraIcons glamorousAdd
		entitled: 'Add Barcode' translated.
	
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
ATransferGlamour >> initializeCurrencyItem [
	(browser transmit) to: #currencyItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label: 'Currency' translated
						text: #currencyItem
						accept: #currencyItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeDate [
	(browser transmit) to: #date;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Date' translated
						text: #date
						accept: #date:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeDestAccount [			
	(browser transmit) to: #destAccount;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Destination Account' translated
						text: #destAccount
						accept: #destAccount:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeItems [
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
				
				act: [:p| model updateOrAddSwapItem.
						p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :p| (p pane port: #entity) value removeItem. "model removeItem"
								p update ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				onChangeOfPort: #selection act: [ :p|
					(p pane port: #selection) value ifNotNil: [ :v| model updateEditor: v ] ];

				display: [ :m| m items sortByPostTime ];
				
				column: 'Count' translated evaluated: [ :each| each amount asString ] width: 100;
				column: 'Goodies' translated evaluated: [ :each| each printTags ] width: 600;
				column: 'Unix Time' translated evaluated: [ :each| each unixTime printString ] width: 50 ]
]

{ #category : #initialization }
ATransferGlamour >> initializeNumber [
	(browser transmit) to: #number;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Number' translated
						text: #number
						accept: #number:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeOrganization [			
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
ATransferGlamour >> initializeSourceAccount [			
	(browser transmit) to: #sourceAccount;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Source Account' translated
						text: #sourceAccount
						accept: #sourceAccount:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeSumItem [
	(browser transmit) to: #sumItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label: 'Sum' translated
						text: #sumItem
						accept: #sumItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeTransmit [
	self initializeAccepted.
	self initializeNumber.
	self initializeDate.
	self initializeOrganization.
	self initializeSourceAccount.
	self initializeDestAccount.
	self initializeAdditional.
	self initializeBarcode.
	self initializeAmountItem.
	self initializeAccItem1.
	self initializeAccItem2.
	self initializeSumItem.
	self initializeCurrencyItem.
	self initializeItems.
	
]

{ #category : #initialization }
ATransferGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
ATransferGlamour >> upSelectionFrom: aPresentation [
	| aSwap |
	aSwap := (aPresentation pane port: #selection) value.
	model upItem: aSwap.
]
