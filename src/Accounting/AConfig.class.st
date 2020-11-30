"
Конфигурация счетов

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AConfig,
	#superclass : #Object,
	#classInstVars : [
		'requestName',
		'requestObligationName',
		'anyOrganization',
		'requestPrefix',
		'contractPrefix',
		'yearPrefix',
		'monthPrefix',
		'dayPrefix',
		'contractName',
		'contractObligationName',
		'invoicePrefix',
		'invoiceName',
		'paymentName',
		'paymentPrefix',
		'swapPrefix',
		'swapName',
		'periodPrefix',
		'taskPrefix',
		'taskName',
		'emptyAccountName',
		'emptyAmountName',
		'executeTaskName',
		'executeTaskPrefix',
		'accounts',
		'taskJournal',
		'nextTaskIndex2',
		'numberPrefix',
		'executeTasks2',
		'nextExecuteTaskIndex2',
		'requests2',
		'nextRequestIndex2',
		'contracts2',
		'nextContractIndex2',
		'invoices2',
		'nextInvoiceIndex2',
		'payments2',
		'nextPaymentIndex2',
		'swaps2',
		'nextSwapIndex2',
		'dictionary',
		'priceName',
		'contraPriceName',
		'nextPriceIndex',
		'prices',
		'kassaChecks',
		'nextKassaCheckIndex',
		'accountsList',
		'additionalNumberPrefix',
		'transferName',
		'transfers',
		'nextTransferIndex',
		'recordingOfName',
		'recordingOfs',
		'nextRecordingOfIndex',
		'writeOffName',
		'writeOffs',
		'nextWriteOffIndex',
		'nomenclatures',
		'nomenclature',
		'nextNomenclatureIndex',
		'barcodes',
		'nextAmountIndex'
	],
	#category : #'Accounting-Config'
}

{ #category : #accessing }
AConfig class >> accounts [
	^ accounts ifNil: [ accounts := AAccountsStore new ]
]

{ #category : #accessing }
AConfig class >> accounts: someAccounts [
	accounts := someAccounts.
]

{ #category : #accessing }
AConfig class >> accountsList [
	^ accountsList ifNil: [ accountsList := OrderedCollection new ]
]

{ #category : #accessing }
AConfig class >> accountsList: anAccountsList [
	accountsList := anAccountsList
]

{ #category : #accessing }
AConfig class >> additionalNumberPrefix [
	^ additionalNumberPrefix ifNil: [ additionalNumberPrefix := 'anmb' ]
]

{ #category : #accessing }
AConfig class >> additionalNumberPrefix: aName [
	additionalNumberPrefix := aName
]

{ #category : #accessing }
AConfig class >> anyOrganizaion [
	^ anyOrganization ifNil: [ anyOrganization := 'any_organizaion' ]
]

{ #category : #accessing }
AConfig class >> anyOrganization [
	^ anyOrganization ifNil: [ anyOrganization := 'any_organization' ]
]

{ #category : #accessing }
AConfig class >> barcodes [
	^ barcodes ifNil: [ barcodes := AAccountsStore new ]
]

{ #category : #accessing }
AConfig class >> barcodes: anAccount [
	barcodes := anAccount
]

{ #category : #accessing }
AConfig class >> contraPriceName [
	^ contraPriceName ifNil: [ contraPriceName := 'contraPrice' ]
]

{ #category : #accessing }
AConfig class >> contractName [
	^ contractName ifNil: [ contractName := 'contract' ]
]

{ #category : #accessing }
AConfig class >> contractObligationName [
	^ contractObligationName ifNil: [ contractObligationName := 'obligation_contract' ]
]

{ #category : #accessing }
AConfig class >> contractPrefix [
	^ contractPrefix ifNil: [ contractPrefix := 'cnt' ]
]

{ #category : #accessing }
AConfig class >> contracts2 [
	^ contracts2 ifNil: [ contracts2 := OrderedCollection new ]
]

{ #category : #accessing }
AConfig class >> dayPrefix [
	^ dayPrefix ifNil: [ dayPrefix := 'dd' ]
]

{ #category : #accessing }
AConfig class >> dictionary [
	^ dictionary ifNil: [ dictionary := ARangeSet new ]
]

{ #category : #accessing }
AConfig class >> dictionary: aDictionary [
	dictionary := aDictionary
]

{ #category : #accessing }
AConfig class >> emptyAccountName [
	^ emptyAccountName ifNil: [ emptyAccountName := 'empty_account' ]
]

{ #category : #accessing }
AConfig class >> emptyAmountName [
	^ emptyAmountName ifNil: [ emptyAmountName := 'empty_amount' ]
]

{ #category : #accessing }
AConfig class >> executeTaskName [
	^ executeTaskName ifNil: [ executeTaskName := 'execute_task' ]
]

{ #category : #accessing }
AConfig class >> executeTaskPrefix [
	^ executeTaskPrefix ifNil: [ executeTaskPrefix := 'etsk' ]
]

{ #category : #accessing }
AConfig class >> executeTasks [
]

{ #category : #accessing }
AConfig class >> executeTasks2 [
	^ executeTasks2 ifNil: [ executeTasks2 := OrderedCollection new ]
]

{ #category : #accessing }
AConfig class >> executeTasks2: anCollection [
	executeTasks2 := anCollection
]

{ #category : #accessing }
AConfig class >> invoiceName [
	^ invoiceName ifNil: [ invoiceName := 'invoice' ]
]

{ #category : #accessing }
AConfig class >> invoicePrefix [
	^ invoicePrefix ifNil: [ invoicePrefix := 'inv' ]
]

{ #category : #accessing }
AConfig class >> invoices [
]

{ #category : #accessing }
AConfig class >> invoices2 [
	^ invoices2 ifNil: [ invoices2 := OrderedCollection new ]
]

{ #category : #accessing }
AConfig class >> kassaChecks [
	^ kassaChecks ifNil: [ kassaChecks := OrderedCollection new ].
]

{ #category : #accessing }
AConfig class >> kassaChecks: aKassaChecks [
	kassaChecks := aKassaChecks.
]

{ #category : #accessing }
AConfig class >> monthPrefix [
	^ monthPrefix ifNil: [ monthPrefix := 'mm' ]
]

{ #category : #accessing }
AConfig class >> nextAmountIndex [
	nextAmountIndex ifNil: [ nextAmountIndex := 0 ].
	^ nextAmountIndex := nextAmountIndex + 1.
]

{ #category : #accessing }
AConfig class >> nextContractIndex2 [
	nextContractIndex2 ifNil: [ nextContractIndex2 := 0 ].
	^ nextContractIndex2 := nextContractIndex2 + 1.
]

{ #category : #accessing }
AConfig class >> nextContractIndex2: anIndex [
	nextContractIndex2 := anIndex
]

{ #category : #accessing }
AConfig class >> nextExecuteTaskIndex2 [
	nextExecuteTaskIndex2 ifNil: [ nextExecuteTaskIndex2 := 0 ].
	^ nextExecuteTaskIndex2 := nextExecuteTaskIndex2 + 1.
]

{ #category : #accessing }
AConfig class >> nextExecuteTaskIndex2: anIndex [
	nextExecuteTaskIndex2 := anIndex.
]

{ #category : #accessing }
AConfig class >> nextInvoiceIndex2 [
	nextInvoiceIndex2 ifNil: [ nextInvoiceIndex2 := 0 ].
	^ nextInvoiceIndex2 := nextInvoiceIndex2 + 1.
]

{ #category : #accessing }
AConfig class >> nextInvoiceIndex2: anIndex [
	nextInvoiceIndex2 := anIndex
]

{ #category : #accessing }
AConfig class >> nextKassaCheckIndex [
	nextKassaCheckIndex ifNil: [ nextKassaCheckIndex := 0 ].
	^ nextKassaCheckIndex := nextKassaCheckIndex + 1.
]

{ #category : #accessing }
AConfig class >> nextKassaCheckIndex: anIndex [
	nextKassaCheckIndex := anIndex
]

{ #category : #accessing }
AConfig class >> nextNomenclatureIndex [
	nextNomenclatureIndex ifNil: [ nextNomenclatureIndex := 0 ].
	^ nextNomenclatureIndex := nextNomenclatureIndex + 1.
]

{ #category : #accessing }
AConfig class >> nextPaymentIndex2 [
	nextPaymentIndex2 ifNil: [ nextPaymentIndex2 := 0 ].
	^ nextPaymentIndex2 := nextPaymentIndex2 + 1.
]

{ #category : #accessing }
AConfig class >> nextPaymentIndex2: anIndex [
	nextPaymentIndex2 := anIndex
]

{ #category : #accessing }
AConfig class >> nextPriceIndex [
	nextPriceIndex ifNil: [ nextPriceIndex := 0 ].
	^ nextPriceIndex := nextPriceIndex + 1.
]

{ #category : #accessing }
AConfig class >> nextPriceIndex: anIndex [
	nextPriceIndex := anIndex
]

{ #category : #accessing }
AConfig class >> nextRecordingOfIndex [
	nextRecordingOfIndex ifNil: [ nextRecordingOfIndex := 0 ].
	^ nextRecordingOfIndex := nextRecordingOfIndex + 1.
]

{ #category : #accessing }
AConfig class >> nextRecordingOfIndex: anIndex [
	nextRecordingOfIndex := anIndex
]

{ #category : #accessing }
AConfig class >> nextRequestIndex2 [
	nextRequestIndex2 ifNil: [ nextRequestIndex2 := 0 ].
	nextRequestIndex2 := nextRequestIndex2 + 1.
	^ nextRequestIndex2.
]

{ #category : #accessing }
AConfig class >> nextRequestIndex2: anIndex [
	nextRequestIndex2 := anIndex
]

{ #category : #accessing }
AConfig class >> nextSwapIndex2 [
	nextSwapIndex2 ifNil: [ nextSwapIndex2 := 0 ].
	^ nextSwapIndex2 := nextSwapIndex2 + 1.
]

{ #category : #accessing }
AConfig class >> nextSwapIndex2: anIndex [
	nextSwapIndex2 := anIndex
]

{ #category : #accessing }
AConfig class >> nextTaskIndex2 [
	nextTaskIndex2 ifNil: [ nextTaskIndex2 := 0 ].
	^ nextTaskIndex2 := nextTaskIndex2 + 1.
]

{ #category : #accessing }
AConfig class >> nextTaskIndex2: anIndex [
	nextTaskIndex2 := anIndex
]

{ #category : #accessing }
AConfig class >> nextTransferIndex [
	nextTransferIndex ifNil: [ nextTransferIndex := 0 ].
	^ nextTransferIndex := nextTransferIndex + 1.
]

{ #category : #accessing }
AConfig class >> nextTransferIndex: anIndex [
	nextTransferIndex := anIndex
]

{ #category : #accessing }
AConfig class >> nextWriteOffIndex [
	nextWriteOffIndex ifNil: [ nextWriteOffIndex := 0 ].
	^ nextWriteOffIndex := nextWriteOffIndex + 1.
]

{ #category : #accessing }
AConfig class >> nextWriteOffIndex: anIndex [
	nextWriteOffIndex := anIndex
]

{ #category : #accessing }
AConfig class >> nomenclature [
	^ 'nomenclature'
]

{ #category : #accessing }
AConfig class >> nomenclatures [
	^ nomenclatures ifNil: [ nomenclatures := OrderedCollection new ]
]

{ #category : #accessing }
AConfig class >> nomenclatures: aNomenclatures [
	nomenclatures := aNomenclatures.
]

{ #category : #accessing }
AConfig class >> numberPrefix [
	^ numberPrefix ifNil: [ numberPrefix := 'nmb' ]
]

{ #category : #accessing }
AConfig class >> numberPrefix: aPrefix [
	numberPrefix := aPrefix
]

{ #category : #accessing }
AConfig class >> paymentName [
	^ paymentName ifNil: [ paymentName := 'payment' ]
]

{ #category : #accessing }
AConfig class >> paymentPrefix [
	^ paymentPrefix ifNil: [ paymentPrefix := 'pmn' ]
]

{ #category : #accessing }
AConfig class >> payments2 [
	^ payments2 ifNil: [ payments2 := OrderedCollection new ]
]

{ #category : #accessing }
AConfig class >> periodPrefix [
	^ periodPrefix ifNil: [ periodPrefix := 'per' ]
]

{ #category : #accessing }
AConfig class >> priceName [
	^ priceName ifNil: [ priceName := 'price' ]
]

{ #category : #accessing }
AConfig class >> prices [
	^ prices ifNil: [ prices := OrderedCollection new ].
]

{ #category : #accessing }
AConfig class >> recordingOfName [
	^ recordingOfName ifNil: [ recordingOfName := 'recordingOf' ]
]

{ #category : #accessing }
AConfig class >> recordingOfName: aName [
	recordingOfName := aName
]

{ #category : #accessing }
AConfig class >> recordingOfs [
	^ recordingOfs ifNil: [ recordingOfs := OrderedCollection new ]
]

{ #category : #accessing }
AConfig class >> recordingOfs: aCollection [
	recordingOfs := aCollection
]

{ #category : #accessing }
AConfig class >> requestName [
	^ requestName ifNil: [ requestName := 'request' ]
]

{ #category : #accessing }
AConfig class >> requestObligationName [
	^ requestObligationName ifNil: [ requestObligationName := 'obligation_request' ]
]

{ #category : #accessing }
AConfig class >> requestObligationName: aName [
	requestObligationName := aName
]

{ #category : #accessing }
AConfig class >> requestPrefix [
	^ requestPrefix ifNil: [ requestPrefix := 'req' ]
]

{ #category : #accessing }
AConfig class >> requests2 [
	^ requests2 ifNil: [ requests2 := OrderedCollection new ]
]

{ #category : #accessing }
AConfig class >> swapName [
	^ swapName ifNil: [ swapName := 'swap' ]
]

{ #category : #accessing }
AConfig class >> swapPrefix [
	^ swapPrefix ifNil: [ swapPrefix := 'swp' ]
]

{ #category : #accessing }
AConfig class >> swaps2 [
	^ swaps2 ifNil: [ swaps2 := OrderedCollection new ].
]

{ #category : #accessing }
AConfig class >> taskJournal [
	^ taskJournal ifNil: [ taskJournal := OrderedCollection new ]
]

{ #category : #accessing }
AConfig class >> taskJournal: aTaskJournal [
	taskJournal := aTaskJournal
]

{ #category : #accessing }
AConfig class >> taskName [
	^ taskName ifNil: [ taskName := 'task' ]
]

{ #category : #accessing }
AConfig class >> taskPrefix [
	^ taskPrefix ifNil: [ taskPrefix := 'tsk' ]
]

{ #category : #accessing }
AConfig class >> tasks [
]

{ #category : #accessing }
AConfig class >> transferName [
	^ transferName ifNil: [ transferName := 'transfer' ]
]

{ #category : #accessing }
AConfig class >> transferName: aTransferName [
	transferName := aTransferName
]

{ #category : #accessing }
AConfig class >> transfers [
	^ transfers ifNil: [ transfers := OrderedCollection new ]
]

{ #category : #accessing }
AConfig class >> transfers: aTransfers [
	transfers := aTransfers
]

{ #category : #accessing }
AConfig class >> writeOffName [
	^ writeOffName ifNil: [ writeOffName = 'writeOff' ]
]

{ #category : #accessing }
AConfig class >> writeOffName: aName [
	writeOffName := aName
]

{ #category : #accessing }
AConfig class >> writeOffs [
	^ writeOffs ifNil: [ writeOffs := OrderedCollection new ]
]

{ #category : #accessing }
AConfig class >> writeOffs: aCollection [
	writeOffs := aCollection
]

{ #category : #accessing }
AConfig class >> yearPrefix [
	^ yearPrefix ifNil: [ yearPrefix := 'yyyy' ]
]
