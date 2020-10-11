"
Графический интерфейс журнала

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	accumulator:		<Object>


    Implementation Points
"
Class {
	#name : #AInvoiceJournalGlamour,
	#superclass : #AGlamour,
	#instVars : [
		'accumulator'
	],
	#category : #'Accounting-GUI'
}

{ #category : #actions }
AInvoiceJournalGlamour >> addNew [
	AInvoiceModel addNew
]

{ #category : #intialization }
AInvoiceJournalGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
AInvoiceJournalGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Invoice Journal' translated.
	browser column: #invoices span: 1.
	browser column: #invoice span: 4.
]

{ #category : #intialization }
AInvoiceJournalGlamour >> initializeInvoice [
	browser transmit from: #invoices; to: #invoice;
		andShow: [ :a|
			a custom: AInvoiceGlamour new browser ].
		
	browser transmit to: #invoice;
		andShow: [ :a|
			a text display: 'Select a Invoice' translated ]
]

{ #category : #intialization }
AInvoiceJournalGlamour >> initializeInvoices [
	browser transmit to: #invoices;
		andShow: [ :a|
			a table
				title: 'Invoices' translated;
				
				act: [ :pr|
							self addNew.
							pr update ]
					icon: GLMUIThemeExtraIcons glamorousAdd
					entitled: 'Add' translated;
					
				act: [ :pr| self removeSelectionFrom: pr.
								pr update ]
					icon: GLMUIThemeExtraIcons glamorousRemove
					entitled: 'Remove' translated;
					
				"format: [ :m| m number, ' invoice' ];"
				display: [ :m| m reverse ];
				column: '#' evaluated: [ :each| each number, '-', each contractNumber ] width: 45;
				column: 'Contractor' translated evaluated: [ :each| each contractor ] ].
]

{ #category : #intialization }
AInvoiceJournalGlamour >> initializeTransmit [
	self initializeInvoices.
	self initializeInvoice.
]

{ #category : #opening }
AInvoiceJournalGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
AInvoiceJournalGlamour >> removeSelectionFrom: aPresentation [
	| inv |
	inv := (aPresentation pane port: #rawSelection) value.
	inv cancelAccepted.
	inv class documents remove: inv ifAbsent: [  ]
]
