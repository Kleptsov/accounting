"
Графический интерфейс накладной

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AInvoiceGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #actions }
AInvoiceGlamour >> downSelectionFrom: aPresentation [
	| aSwap |
	aSwap := (aPresentation pane port: #selection) value.
	Smalltalk at: #debug put: aSwap.
	model downItem: aSwap.
]

{ #category : #initialization }
AInvoiceGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
AInvoiceGlamour >> initializeAccItem1 [
	(browser transmit) to: #accItem1;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label: 'Account' translated, ' 1'
						text: #accItem1
						accept: #accItem1:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AInvoiceGlamour >> initializeAccItem2 [
	(browser transmit) to: #accItem2;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label: 'Account' translated, ' 2'
						text: #accItem2
						accept: #accItem2:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AInvoiceGlamour >> initializeAdditional [
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
AInvoiceGlamour >> initializeAmountItem [
	(browser transmit) to: #amountItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model accountEditor
						label: 'Count ' translated
						text: #amountItem
						accept: #amountItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AInvoiceGlamour >> initializeBarcode [
	(browser transmit) to: #barcode;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Barcode' translated
						text: #barcode
						accept: #barcode:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AInvoiceGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: [ :m| m number, ' ', 'Invoice' translated ] .
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserActions.
	browser row: [ :r|
		r column: #accepted.
		r column: #number.
		r column: #contractNumber.
		r column: #date.
	] size: 43.
	browser row: [ :r|
		r column: #organization.
		r column: #contractor.
		r column: #store.
	] size: 43.
	browser row: [ :r|
		r column: #barcode span: 0.3.
		r column: #additional span: 0.7 ] size: 43.
	browser row: [ :r|
		r column: #amountItem span: 0.1.
		r column: #accItem1 span: 0.35.
		r column: #accItem2 span: 0.35.
		r column: #sumItem span: 0.1.
		r column: #currencyItem span: 0.1 ] size: 43.
	browser row: #items.
]

{ #category : #initialization }
AInvoiceGlamour >> initializeBrowserActions [

	browser act: [ :p|
		model addBarcode.
		self inform: ('Barcode' translated, ' ', model barcode, ' ', 'Added as' translated, ' ', model accItem1, ' ', model accItem2) ]
		icon: GLMUIThemeExtraIcons glamorousAdd
		entitled: 'Add Barcode' translated.
	
	browser act: [ :p|
		Clipboard clipboardText: model items printCSV. self inform: 'Copy to Clipboard' translated ]
		icon: GLMUIThemeExtraIcons glamorousSave
		entitled: 'Copy to Clipboard' translated.

	browser act: [ :p|
		model addAccount1:(AListDialogWindow selectItemFrom: AConfig accountsList).
						p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 1' translated.
		
	browser act: [ :p|
		model addAccount2:(AListDialogWindow selectItemFrom: AConfig accountsList).
						p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 2' translated.
		
	browser act: [ :p|
			model removeAccounts.
			p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousUndo
		entitled: 'Unwire' translated.
		
	browser
		act: [ :p| model createTransfer open ]
		icon: (' ', 'Transfer' translated,' ') asMorph imageForm
		entitled: 'New Transfer' translated.
		
	browser
		act: [ :p| "(p pane port: #entity) value accept "model accept ]
		icon: GLMUIThemeExtraIcons glamorousAccept
		entitled: 'Accept' translated.
]

{ #category : #initialization }
AInvoiceGlamour >> initializeContractNumber [
	(browser transmit) to: #contractNumber;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '* ', 'Contract Number' translated
						text: #contractNumber
						accept: #contractNumber:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AInvoiceGlamour >> initializeContractor [
	(browser transmit) to: #contractor;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '* ', 'Contractor' translated
						text: #contractor
						accept: #contractor:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AInvoiceGlamour >> initializeCurrencyItem [
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
AInvoiceGlamour >> initializeDate [
	(browser transmit) to: #date;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '* ', 'Date' translated
						text: #date
						accept: #date:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AInvoiceGlamour >> initializeEditor [
		(browser transmit) to: #editor;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ATextField
						on: model
						text: #editor
						accept: #editor:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AInvoiceGlamour >> initializeItems [
	(browser transmit) to: #items;
		andShow: [ :a| |table|
			table := a table.
			table
				title: '* ', 'Items' translated;
				
				onChangeOfPort: #selection act: [ :p|
					(p pane port: #selection) value ifNotNil: [ :v| model updateEditor: v ] ];
				
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

				display: [ :m| m items sortByPostTime ];
				column: 'Count' translated evaluated: [ :each| each amount ] width: 100;
				column: 'Goodies' translated evaluated: [ :each| each printTags ] width: 200;
				column: 'Sum' translated evaluated: [ :each| 
					(each class = ASwap)
						ifTrue: [ each swapAmount amount ]
						ifFalse: [ '' ] ] width: 100;
				column: 'Currency' translated evaluated: [ :each|
					(each class = ASwap)
						ifTrue: [ each swapAmount printTags ]
						ifFalse: [ '' ] ] width: 200;
				column: 'Unix Time' translated evaluated: [ :each| each unixTime ] width: 50 ]
]

{ #category : #initialization }
AInvoiceGlamour >> initializeNumber [
	(browser transmit) to: #number;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '* ', 'Number' translated
						text: #number
						accept: #number:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AInvoiceGlamour >> initializeOrganization [
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
AInvoiceGlamour >> initializeStore [
	(browser transmit) to: #store;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '* ', 'Store' translated
						text: #store
						accept: #store:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AInvoiceGlamour >> initializeSumItem [
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
AInvoiceGlamour >> initializeTmp [
]

{ #category : #initialization }
AInvoiceGlamour >> initializeTransmit [
	self initializeAccepted.
	self initializeNumber.
	self initializeOrganization.
	self initializeContractor.
	self initializeDate.
	self initializeContractNumber.
	self initializeStore.
	self initializeBarcode.
	self initializeAdditional.
	self initializeAmountItem.
	self initializeAccItem1.
	self initializeAccItem2.
	self initializeSumItem.
	self initializeCurrencyItem.
	self initializeItems.
	
]

{ #category : #initialization }
AInvoiceGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
AInvoiceGlamour >> upSelectionFrom: aPresentation [
	| aSwap |
	aSwap := (aPresentation pane port: #selection) value.
	Smalltalk at: #debug put: aSwap.
	model upItem: aSwap.
]
