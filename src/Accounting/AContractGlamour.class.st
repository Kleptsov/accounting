"
Графический интерфейс договора

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AContractGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #actions }
AContractGlamour >> downSelectionFrom: aPresentation [
	| aSwap |
	aSwap := (aPresentation pane port: #selection) value.
	model downItem: aSwap.
]

{ #category : #initialization }
AContractGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
AContractGlamour >> initializeAccItem1 [
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
AContractGlamour >> initializeAccItem2 [
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
AContractGlamour >> initializeAdditional [
	(browser transmit) to: #additional;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Additional' translated)
						text: #additional
						accept: #additional:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AContractGlamour >> initializeAdditionalNumber [
	(browser transmit) to: #additionalNumber;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Additional Number' translated)
						text: #additionalNumber
						accept: #additionalNumber:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
			
]

{ #category : #initialization }
AContractGlamour >> initializeAmountItem [
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
AContractGlamour >> initializeBarcode [
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
AContractGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	self initializeBrowserTitle.
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserActions.
	browser row: [ :r|
		r column: #accepted.
		r column: #number.
		r column: #additionalNumber.
		r column: #date.
	] size: 43.
	browser row: #a1 size: 5.
	browser row: [ :r|
		r column: #organization.
		r column: #contractor.
	] size: 43.
	browser row: #a2 size: 5.
	browser row: [ :r|
		r column: #barcode span: 0.3.
		r column: #additional span: 0.7 ] size: 43.
	browser row: #a3 size: 5.
	browser row: [ :r| 
		r column: #amountItem span: 0.1.
		r column: #accItem1 span: 0.35.
		r column: #accItem2 span: 0.35.
		r column: #sumItem span: 0.1.
		r column: #currencyItem span: 0.1 ]  size: 43.
	browser row: #items.
]

{ #category : #initialization }
AContractGlamour >> initializeBrowserActions [

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
		model addAccount2:(AListDialogWindow selectItemFrom: AConfig accountsList).
						p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 2' translated.
		
	browser
		act: [ :p| model createPayment open ]
		icon: GLMUIThemeExtraIcons glamorousBrowse
		entitled: 'New Payment' translated.
]

{ #category : #initialization }
AContractGlamour >> initializeBrowserTitle [
	browser title: [:m| m number, ' ', 'Contract' translated].
]

{ #category : #initialization }
AContractGlamour >> initializeContractor [
	(browser transmit) to: #contractor;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '*', 'Contractor' translated)
						text: #contractor
						accept: #contractor:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AContractGlamour >> initializeCurrencyItem [
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
AContractGlamour >> initializeDate [
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
AContractGlamour >> initializeItems [
	(browser transmit) to: #items;
		andShow: [ :a|
			a table
				title: 'Items' translated;
				
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
				
				act: [ :p| (p pane port: #entity) value items amounts "model items"
									remove: (p pane port: #selection) value ifAbsent: [  ].
							p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				onChangeOfPort: #selection act: [ :p|
					(p pane port: #selection) value ifNotNil: [ :v| model updateEditor: v ] ];
				
				display: [ :m| m items sortByPostTime ];
				column: 'Count' translated evaluated: [ :each| each amount ] width: 50;
				column: 'Goodies' translated evaluated: [ :each| each printTags ] width: 300;
				column: 'Sum' translated evaluated: [ :each| each swapAmount amount ] width: 100;
				column: 'Currency' translated evaluated: [ :each| each swapAmount printTags ] width: 100;
				column: 'Unix Time' translated evaluated: [ :each| each unixTime ] width: 50 ]
]

{ #category : #initialization }
AContractGlamour >> initializeNumber [
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
AContractGlamour >> initializeOrganization [
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
AContractGlamour >> initializeSumItem [
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
AContractGlamour >> initializeTransmit [
	self initializeAccepted.
	self initializeNumber.
	self initializeAdditionalNumber.
	self initializeOrganization.
	self initializeContractor.
	self initializeDate.
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
AContractGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
AContractGlamour >> upSelectionFrom: aPresentation [
	| aSwap |
	aSwap := (aPresentation pane port: #selection) value.
	model upItem: aSwap.
]

{ #category : #actions }
AContractGlamour >> updateAccountItems [
	
]
