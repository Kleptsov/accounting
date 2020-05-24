"
Графический интерфейс реализующий обменные операции

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ASwapGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #actions }
ASwapGlamour >> downSelectionFrom: aPresentation [
	| aSwap |
	aSwap := (aPresentation pane port: #selection) value.
	model downItem: aSwap.
]

{ #category : #initialization }
ASwapGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
ASwapGlamour >> initializeAccItem1 [
	(browser transmit) to: #accItem1;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('Account' translated, ' 1')
						text: #accItem1
						accept: #accItem1:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ASwapGlamour >> initializeAccItem2 [
	(browser transmit) to: #accItem2;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ('Account' translated, ' 2')
						text: #accItem2
						accept: #accItem2:
						acceptAction: [ :v| morphPresentation selection: v asString ].
			] ]
]

{ #category : #initialization }
ASwapGlamour >> initializeAdditional [
	(browser transmit) to: #additional;
		andShow: 	[ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:('Additional' translated)
						text: #additional
						accept: #additional:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ASwapGlamour >> initializeAmountItem [
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
ASwapGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: [ :m| m number, ' ', 'Swap' translated ] .
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserActions.
	browser row: [ :r|
		r column: #number.
		r column: #date.
	] size: 43.
	browser row: [ :r|
		r column: #organization.
		r column: #organizationAccount.
		r column: #organizationAccount2.
	] size: 43.
	browser row: [ :r| 
		r column: #contractor.
		r column: #contractorAccount.
		r column: #contractorAccount2 ] size: 43.
	browser row: #additional size: 43.
	browser row: [ :r| 
		r column: #amountItem span: 0.1.
		r column: #accItem1 span: 0.35.
		r column: #accItem2 span: 0.35.
		r column: #sumItem span: 0.1.
		r column: #currencyItem span: 0.1 ]  size: 43.
	browser row: #items.
]

{ #category : #initialization }
ASwapGlamour >> initializeBrowserActions [
	
	browser act: [ :p|
		Clipboard clipboardText: model items printCSV. self inform: 'copy to clipboard' ]
		icon: GLMUIThemeExtraIcons glamorousSave
		entitled: 'Copy to Clipboard' translated.
		
	browser act: [ :p|
		model addAccount1:(AListDialogWindow selectItemFrom: AConfig accountsList).
						p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 2' translated.
		
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
		
	browser act: [ :p|
		model accept.
		p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousAccept
		entitled: 'Accept' translated
]

{ #category : #initialization }
ASwapGlamour >> initializeContractor [
	(browser transmit) to: #contractor;
		andShow:
		[ :composite|
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
ASwapGlamour >> initializeContractorAccount [
	(browser transmit) to: #contractorAccount;
		andShow: 	[ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:('Contractor Account' translated)
						text: #contractorAccount
						accept: #contractorAccount:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ASwapGlamour >> initializeContractorAccount2 [
	(browser transmit) to: #contractorAccount2;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:('Contractor Account' translated, ' 2')
						text: #contractorAccount2
						accept: #contractorAccount2:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ASwapGlamour >> initializeCurrencyItem [
	(browser transmit) to: #currencyItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Currency' translated
						text: #currencyItem
						accept: #currencyItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
			] ]
]

{ #category : #initialization }
ASwapGlamour >> initializeDate [
	(browser transmit) to: #date;
		andShow: 	[ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:('* ', 'Date' translated, ' ', 'dd:mm:yyyy' translated)
						text: #date
						accept: #date:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ASwapGlamour >> initializeItems [
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
				
				act: [ :p| (p pane port: #entity) value updateOrAddSwapItem. "model updateOrAddSwapItem"
								p update ]
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
				column: 'Goodies' translated evaluated: [ :each| each printTags ] width: 200;
				column: ('Count' translated, ' 2') evaluated: [ :each| each swapAmount amount ] width: 100;
				column: ('Goodies' translated, ' 2') evaluated: [ :each| each swapAmount printTags ] width: 200;
				column: 'Unix Time' translated evaluated: [ :each| each unixTime printString ] width: 50 ]
]

{ #category : #initialization }
ASwapGlamour >> initializeNumber [
	(browser transmit) to: #number;
		andShow: 	[ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:('* ', 'Number' translated)
						text: #number
						accept: #number:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ASwapGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: 	[ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:('* ', 'Organization' translated)
						text: #organization
						accept: #organization:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ASwapGlamour >> initializeOrganizationAccount [
	(browser transmit) to: #organizationAccount;
		andShow: 	[ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:('Organization Account' translated)
						text: #organizationAccount
						accept: #organizationAccount:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ASwapGlamour >> initializeOrganizationAccount2 [
	(browser transmit) to: #organizationAccount2;
		andShow: 	[ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:('Contractor Account' translated, ' 2')
						text: #contractorAccount2
						accept: #contractorAccount2:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ASwapGlamour >> initializeSumItem [
	(browser transmit) to: #sumItem;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Sum' translated
						text: #sumItem
						accept: #sumItem:
						acceptAction: [ :v| morphPresentation selection: v asString ].
			] ]
]

{ #category : #initialization }
ASwapGlamour >> initializeTransmit [
	self initializeNumber.
	self initializeDate.
	self initializeOrganization.
	self initializeOrganizationAccount.
	self initializeOrganizationAccount2.
	self initializeContractor.
	self initializeContractorAccount.
	self initializeContractorAccount2.
	self initializeAdditional.
	self initializeItems.
	self initializeAmountItem.
	self initializeAccItem1.
	self initializeAccItem2.
	self initializeSumItem.
	self initializeCurrencyItem.
]

{ #category : #initialization }
ASwapGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
ASwapGlamour >> upSelectionFrom: aPresentation [
	| aSwap |
	aSwap := (aPresentation pane port: #selection) value.
	model upItem: aSwap.
]
