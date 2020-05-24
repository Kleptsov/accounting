"
Журнал документов перемещения

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
	#name : #ATransferJournalGlamour,
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
ATransferJournalGlamour >> addNew [
	ATransferModel addNew
]

{ #category : #intialization }
ATransferJournalGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
ATransferJournalGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Transfer Journal' translated.
	browser column: #transfers span: 1.
	browser column: #transfer span: 4.
]

{ #category : #intialization }
ATransferJournalGlamour >> initializeTransfer [
	browser transmit from: #transfers; to: #transfer;
		andShow: [ :a|
			a custom: ATransferGlamour new browser ].
	
	browser transmit to: #transfer;
		andShow: [ :a|
			a text display: 'Select a Transfer Document' translated ].
]

{ #category : #intialization }
ATransferJournalGlamour >> initializeTransfers [
	browser transmit to: #transfers;
		andShow: [ :a|
			a table
				title: 'Transfers' translated;
				
				act: [ :pr| 	self addNew. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :pr| self removeSelectionFrom: pr. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				display: [ :m| m reverse ];
				column: '#' evaluated: [ :each| each number ] width: 30;
				column: 'Organization' translated evaluated: [ :each| each organization, ' ',each sourceAccount, '-', each destAccount] ].
]

{ #category : #intialization }
ATransferJournalGlamour >> initializeTransmit [
	self initializeTransfers.
	self initializeTransfer.
]

{ #category : #opening }
ATransferJournalGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
ATransferJournalGlamour >> removeSelectionFrom: aPresentation [
	| sw |
	sw := (aPresentation pane port: #rawSelection) value.
	sw removeAccounts.
	sw class documents remove: sw ifAbsent: [  ]
]
