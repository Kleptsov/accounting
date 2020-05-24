"
Графический интерфейс журнала контрактов

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
	#name : #AContractJournalGlamour,
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
AContractJournalGlamour >> addNew [
	AContractModel addNew
]

{ #category : #accessing }
AContractJournalGlamour >> documents [
	^ AConfig contracts2
]

{ #category : #intialization }
AContractJournalGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
AContractJournalGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Contract Journal' translated.
	browser column: #contracts span: 1.
	browser column: #contract span: 4.
]

{ #category : #intialization }
AContractJournalGlamour >> initializeContract [
	browser transmit from: #contracts; to: #contract;
		andShow: [ :a|
			a custom: AContractGlamour new browser ].
	
	browser transmit to: #contract;
		andShow: [ :a|
			a text display: 'Select a Contract' translated ].
]

{ #category : #intialization }
AContractJournalGlamour >> initializeContracts [
	browser transmit to: #contracts;
		andShow: [ :a|
			a table
				title: 'Contracts' translated;
				
				act: [ :pr| self moveUp: (pr pane port: #selection) value. pr update ]
				icon: GLMUIThemeExtraIcons glamorousDown
				entitled: 'Move item up' translated;
				
				act: [ :pr| self moveDown: (pr pane port: #selection) value. pr update]
				icon: GLMUIThemeExtraIcons glamorousUp
				entitled: 'Move item down' translated;
				
				act: [ :pr| 	self addNew.
							browser update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :pr| self removeSelectionFrom: pr.
								browser update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				"format: [ :m| m number, '-', m additionalNumber, ' contract' ];"
				
				display: [ :m| m reverse];
				column: '#' evaluated: [ :each| each number, '-', each additionalNumber ] width: 45;
				column: 'Contractor' translated evaluated: [ :each| each contractor ] ].
]

{ #category : #intialization }
AContractJournalGlamour >> initializeTransmit [
	self initializeContracts.
	self initializeContract.
]

{ #category : #actions }
AContractJournalGlamour >> moveDown: anElement [
	| index |
	index := self documents indexOf: anElement.
	(index = (self documents size) or: [ index = 0 ])
		ifFalse: [ self documents at: index put: (self documents at: index + 1).
						self documents at: (index + 1) put: anElement ]
]

{ #category : #actions }
AContractJournalGlamour >> moveUp: anElement [
	| index |
	index := self documents indexOf: anElement.
	(index = 1 or: [ index = 0 ])
		ifFalse: [ self documents at: index put: (self documents at: index - 1).
						self documents at: (index - 1) put: anElement ]
]

{ #category : #opening }
AContractJournalGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
AContractJournalGlamour >> removeSelectionFrom: aPresentation [
	| cnt |
	cnt := (aPresentation pane port: #rawSelection) value.
	cnt removeAccounts.
	cnt class documents remove: cnt ifAbsent: [  ].
]
