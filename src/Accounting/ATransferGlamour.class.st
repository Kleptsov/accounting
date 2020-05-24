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
ATransferGlamour >> initializeAdditional [
	(browser transmit) to: #additional;
		andShow: [ :a|
			a text
				title: 'Additional' translated;
				onChangeOfPort: #text act: [ :tp| model additional: tp text asString ];
				display: [ :m| m additional ] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: [ :m| m number, ' ', 'Transfer' translated ] .
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserActions.
	browser row: [ :r|
		r column: #number.
		r column: #date.
	] size: 68.
	browser row: [ :r|
		r column: #organization.
		r column: #sourceAccount.
		r column: #destAccount.
	] size: 68.
	browser row: #tmp size: 0.
	browser row: #additional size: 68.
	browser row: #editor size: 35.
	browser row: #items.
]

{ #category : #initialization }
ATransferGlamour >> initializeBrowserActions [
	
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
ATransferGlamour >> initializeDate [
	(browser transmit) to: #date;
		andShow: [ :a|
			a text
				title: ('* ', 'Date' translated, ' ','dd:mm:yyyy' translated);
				onChangeOfPort: #text act: [ :tp| model date: tp text asString ];
				display: [ :m| m date ] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeDestAccount [
	(browser transmit) to: #destAccount;
		andShow: [ :a|
			a text
				title: 'Destination Account' translated;
				onChangeOfPort: #text act: [ :tp| model destAccount: tp text asString ];
				display: [ :m| m destAccount ] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeEditor [
	"display when created"
	(browser transmit) to: #editor;
		andShow: [ :a|
			a text
				onChangeOfPort: #text act: [ :textPresentation | 
					model editor: textPresentation text asString ];
				format: [ :m| m isText ifTrue: [ m ] ifFalse: [ m editor ] ];
				display: [ :m| m ]
		].
	
	"display when select an item"
	(browser transmit) from: #items port: #selection; from: #tmp; to: #editor;
		andShow: [ :a|
			a text
				allowNil;
				onChangeOfPort: #text act: [ :textPresentation | 
					model editor: textPresentation text asString ];
				display: [ :item :tmp| item asString ].
			
			a text
				allowAllNil;
				onChangeOfPort: #text act: [ :textPresentation | 
					model editor: textPresentation text asString ];
				display: [ :item :tmp| model editor asString ].
			 ].
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
				
				act: [ :p| (p pane port: #entity) value addItem. "model addItem"
								p update ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :p| (p pane port: #entity) value removeItem. "model removeItem"
								p update ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;

				display: [ :m| m items sortByPostTime ];
				
				column: 'Count' translated evaluated: [ :each| each amount asString ] width: 100;
				column: 'Goodies' translated evaluated: [ :each| each printTags ] width: 600;
				column: 'Unix Time' translated evaluated: [ :each| each unixTime printString ] width: 50 ]
]

{ #category : #initialization }
ATransferGlamour >> initializeNumber [
	(browser transmit) to: #number;
		andShow: [ :a|
			a text
				title: '* ', 'Number' translated;
				onChangeOfPort: #text act: [ :tp| model number: tp text asString ];
				display: [ model number ] ].
]

{ #category : #initialization }
ATransferGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: [ :a|
			a text
				title: '* ', 'Organization' translated;
				onChangeOfPort: #text act: [ :tp| model organization: tp text asString ];
				display: [ :m| m organization ] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeSourceAccount [
	(browser transmit) to: #sourceAccount;
		andShow: [ :a|
			a text
				title: 'Source Account' translated;
				onChangeOfPort: #text act: [ :tp| model sourceAccount: tp text asString ];
				display: [ :m| m sourceAccount ] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeTmp [
	(browser transmit) to: #tmp; from: #items port: #selection;
		andShow: [ :a|
			a text display: [ :sel| model selectionItem: sel. '' ] ]
]

{ #category : #initialization }
ATransferGlamour >> initializeTransmit [
	self initializeNumber.
	self initializeDate.
	self initializeOrganization.
	self initializeSourceAccount.
	self initializeDestAccount.
	self initializeAdditional.
	self initializeEditor.
	self initializeItems.
	self initializeTmp.
	
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
