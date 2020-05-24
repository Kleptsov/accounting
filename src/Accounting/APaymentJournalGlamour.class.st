"
Графический интерфейс журнала платежек

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
	#name : #APaymentJournalGlamour,
	#superclass : #AGlamour,
	#instVars : [
		'accumulator'
	],
	#classInstVars : [
		'model',
		'browser'
	],
	#category : #'Accounting-GUI'
}

{ #category : #actions }
APaymentJournalGlamour >> addNew [
	APaymentModel addNew
]

{ #category : #intialization }
APaymentJournalGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
APaymentJournalGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Payment Journal' translated.
	browser column: #payments span: 1.
	browser column: #payment span: 4.
]

{ #category : #intialization }
APaymentJournalGlamour >> initializePayment [
	browser transmit from: #payments; to: #payment;
		andShow: [ :a|
			a custom: APaymentGlamour new browser. ].
		
	browser transmit to: #payment;
		andShow: [ :a|
			a text display: 'Select a Payment' translated ]
]

{ #category : #intialization }
APaymentJournalGlamour >> initializePayments [
	browser transmit to: #payments;
		andShow: [ :a|
			a table
				title: 'Payments' translated;
				
				act: [ :pr| 	self addNew. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :pr| self removeSelectionFrom: pr. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				display: [ :m| m reverse ];
				column: '#' evaluated: [ :each| each number, '-', each contractNumber ] width: 45;
				column: 'Contractor' translated evaluated: [ :each| each contractor ] ].
]

{ #category : #intialization }
APaymentJournalGlamour >> initializeTransmit [
	self initializePayments.
	self initializePayment.
]

{ #category : #opening }
APaymentJournalGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
APaymentJournalGlamour >> removeSelectionFrom: aPresentation [
	| p |
	p := (aPresentation pane port: #rawSelection) value.
	p removeAccounts.
	p class documents remove: p ifAbsent: [  ]
]
