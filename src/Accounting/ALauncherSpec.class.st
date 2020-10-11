"
Главное окно запуска всех функций

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	menu:		<Object>
	text:		<Object>


    Implementation Points
"
Class {
	#name : #ALauncherSpec,
	#superclass : #ASpec,
	#instVars : [
		'menu',
		'text'
	],
	#category : #'Accounting-GUI'
}

{ #category : #specs }
ALauncherSpec class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		newColumn: [ :c|
			c 	add: #menu height: self toolbarHeight;
				add: #text ]
]

{ #category : #specs }
ALauncherSpec class >> example [
	^ self new openWithSpec
]

{ #category : #initialization }
ALauncherSpec >> initializeWidgets [
	self extent: 600@200.
	menu := MenuModel new.
	menu addGroup: [ :group|
			group addItem: [ :item|
				item name: 'Task' translated; subMenu: self subTaskMenu ].
			group addItem: [ :item|
				item name: 'Request' translated; subMenu: self subRequestMenu ].
			group addItem: [ :item|
				item name: 'Contract' translated; subMenu: self subContractMenu ].
			group addItem: [ :item|
				item name: 'Store' translated; subMenu: self subStoreMenu ].
			group addItem: [ :item|
				item name: 'Swap' translated; subMenu: self subSwapMenu ].
			group addItem: [ :item|
				item name: 'Retail' translated; subMenu: self subRetailMenu ].
			group addItem: [ :item|
				item name: 'Organizer' translated; subMenu: self subOrganizerMenu ].
			group addItem: [ :item| 
				item name: 'Report' translated; subMenu: self subReportMenu ] ].
	menu applyTo: self.
	text := self newText.
]

{ #category : #accessing }
ALauncherSpec >> menu [
	^ menu
]

{ #category : #accessing }
ALauncherSpec >> menu: anObject [
	menu := anObject
]

{ #category : #initialization }
ALauncherSpec >> subContractMenu [
	^ MenuModel new
		addGroup: [ :group|
			group addItem: [ :item|
				item name: 'New Contract' translated; action: [ AContractModel openNew. ] ].
			group addItem: [ :item|
				item name: 'New Invoice' translated; action: [ AInvoiceModel openNew ] ].
			group addItem: [ :item| 
				item name: 'New Payment' translated; action: [ APaymentModel openNew ] ].
			group addItem: [ :item|
				item name: 'Contract Journal' translated; action: [ AContractJournalGlamour openOn: AConfig contracts2 ] ].
			group addItem: [ :item|
				item name: 'Invoice Journal' translated; action: [ AInvoiceJournalGlamour openOn: AConfig invoices2 ] ].
			group addItem: [ :item|
				item name: 'Payment Journal' translated; action: [ APaymentJournalGlamour openOn: AConfig payments2 ] ].
			group addItem: [ :item|
				item name: 'Contract Report' translated; action: [ ACommonContractReportGlamour2 openOn: 1 ] ].
		]
]

{ #category : #initialization }
ALauncherSpec >> subOrganizerMenu [
	^ MenuModel new
		addGroup: [ :group|
			group addItem: [ :item|
				item
					name: 'Account Explorer' translated; action: [ AAccountExplorerModel new open ] ].
			group addItem: [ :item|
				item name: 'Price Selector' translated; action: [ APriceSelectorModel new open ] ].
			group addItem: [ :item|
				item name: 'Barcode Selector' translated; action: [ ABarcodeSelectorModel new open ] ] ] 
]

{ #category : #initialization }
ALauncherSpec >> subReportMenu [
	^ MenuModel new
		addGroup: [ :group|
			group addItem: [ :item|
				item name: 'Common Report' translated; action: [ ACommonReportModel new open. ] ].
			group addItem: [ :item|
				item name: 'Contract Report' translated; action: [ ACommonContractReportGlamour2 openOn: 1 ] ].
			group addItem: [ :item|
				item name: 'Request Report' translated; action: [ ARequestReportGlamour openOn: ARequestReportModel new ] ].
			group addItem: [ :item|
				item name: 'Swap Report' translated; action: [ ACommonSwapReportGlamour openOn: 1 ] ].
			group addItem: [ :item|
				item name: 'Task Report' translated; action: [ ATaskReportGlamour openOn: ATaskReportModel new ] ].
			]
]

{ #category : #initialization }
ALauncherSpec >> subRequestMenu [
	^ MenuModel new
		addGroup: [ :group|
			group addItem: [ :item|
				item
					name: 'New' translated; action: [ ARequestModel openNew. ] ].
			group addItem: [ :item|
				item name: 'Request Journal' translated; action: [ ARequestJournalGlamour openOn: AConfig requests2 ] ].
			group addItem: [ :item|
				item name: 'Report' translated; action: [ ARequestReportGlamour openOn: ARequestReportModel new ].
		]
	]
]

{ #category : #initialization }
ALauncherSpec >> subRetailMenu [
	^ MenuModel new
		addGroup: [ :group|
			group addItem: [ :item|
				item name: 'Dictionary' translated; action: [ ADictionaryGlamour openOn: ADictionaryModel new ] ].
			group addItem: [ :item|
				item name: 'Kassa' translated; action: [ AKassaModel openNew. ] ].
			group addItem: [ :item|
				item name: 'New Prices' translated; action: [ APriceGlamour openOn: APriceModel addNew ] ].
			group addItem: [ :item|
				item name: 'Price Document Journal' translated; action: [ APriceJournalGlamour openOn: AConfig prices ] ].
			group addItem: [ :item|
				item name: 'Check Document Journal' translated; action: [ AKassaCheckJournalGlamour openOn: AConfig kassaChecks ] ].
			group addItem: [ :item|
				item name: 'Report' translated; action: [ self inform: 'Kassa Report' ] ].
		]
]

{ #category : #initialization }
ALauncherSpec >> subStoreMenu [
	^ MenuModel new
		addGroup: [ :group|
			group addItem: [ :item|
				item name: 'New Transfer' translated; action: [ ATransferModel openNew ] ].
			group addItem: [ :item|
				item name: 'New Recording of' translated; action: [ ARecordingOfModel openNew ] ].
			group addItem: [ :item|
				item name: 'New Write-off' translated; action: [ AWriteOffModel openNew ] ].
			group addItem: [ :item|
				item name: 'Transfer Journal' translated; action: [ ATransferJournalGlamour openOn: AConfig transfers ] ].
			group addItem: [ :item|
				item name: 'Recording of Journal' translated; action: [ ARecordingOfJournalGlamour openOn: AConfig recordingOfs ] ].
			group addItem: [ :item|
				item name: 'Write-off Journal' translated; action: [ AWriteOffJournalGlamour openOn: AConfig writeOffs ] ]			
		]
]

{ #category : #initialization }
ALauncherSpec >> subSwapMenu [
	^ MenuModel new
		addGroup: [ :group|
			group addItem: [ :item|
				item name: 'New' translated; action: [  ASwapModel openNew ] ].
			group addItem: [ :item|
				item name: 'Journal' translated; action: [ ASwapJournalGlamour openOn: AConfig swaps2 ] ].
			group addItem: [ :item|
				item name: 'Report' translated; action: [ ACommonSwapReportGlamour openOn: 1 ] ].
		]
]

{ #category : #initialization }
ALauncherSpec >> subTaskMenu [
	^ MenuModel new
		addGroup: [ :group|
			group addItem: [ :item|
				item
					name: 'New' translated; action: [ ATaskModel morphViewInWindow. ] ].
			group addItem: [ :item|
				item name: 'Task Journal' translated; action: [ ATaskJournalGlamour openOn: AConfig taskJournal ] ].
			group addItem: [ :item| 
				item name: 'Execute Task Journal' translated; action: [ AExecuteTaskJournalGlamour openOn: AConfig executeTasks2 ] ].
			group addItem: [ :item|
				item name: 'Report' translated; action: [ ATaskReportGlamour openOn: ATaskReportModel new ] ].
		 ]
]

{ #category : #accessing }
ALauncherSpec >> text [
	^ text
]

{ #category : #accessing }
ALauncherSpec >> text: anObject [
	text := anObject
]

{ #category : #initialization }
ALauncherSpec >> title [
	^ 'Accounting Launcher' translated
]
