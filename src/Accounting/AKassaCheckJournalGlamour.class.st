"
Журнал кассовых чеков

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
	#name : #AKassaCheckJournalGlamour,
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
AKassaCheckJournalGlamour >> addNew [
	^ AKassaModel addNew
]

{ #category : #accessing }
AKassaCheckJournalGlamour >> documents [
	^ AConfig kassaChecks
]

{ #category : #intialization }
AKassaCheckJournalGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
AKassaCheckJournalGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Kassa Check Journal' translated.
	browser column: #kassaChecks span: 1.
	browser column: #kassaCheck span: 4.
]

{ #category : #intialization }
AKassaCheckJournalGlamour >> initializeKassaCheck [
	browser transmit from: #kassaChecks; to: #kassaCheck;
		andShow: [ :a|
			a custom: AKassaCheckGlamour new browser ].
	
	browser transmit to: #kassaCheck;
		andShow: [ :a|
			a text display: 'Select a Kassa Check' translated ].
]

{ #category : #intialization }
AKassaCheckJournalGlamour >> initializeKassaChecks [
	browser transmit to: #kassaChecks;
		andShow: [ :a|
			a table
				title: 'Kassa Checks' translated;
				
				act: [ :pr| self moveUp: (pr pane port: #selection) value. pr update ]
				icon: GLMUIThemeExtraIcons glamorousUp
				entitled: 'Move item up' translated;
				
				act: [ :pr| self moveDown: (pr pane port: #selection) value. pr update]
				icon: GLMUIThemeExtraIcons glamorousDown
				entitled: 'Move item down' translated;
				
				act: [ :pr| 	self addNew.
							browser update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :pr| self removeSelectionFrom: pr.
								browser update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				display: [ :m| m reverse ];
				column: '#' evaluated: [ :each| each number ] width: 45;
				column: 'Acquirer' translated evaluated: [ :each| each priceAccount, '-', each contractor ] ].
]

{ #category : #intialization }
AKassaCheckJournalGlamour >> initializeTransmit [
	self initializeKassaChecks.
	self initializeKassaCheck.
]

{ #category : #actions }
AKassaCheckJournalGlamour >> moveDown: anElement [
	| index |
	index := self documents indexOf: anElement.
	(index = (self documents size) or: [ index = 0 ])
		ifFalse: [ self documents at: index put: (self documents at: index + 1).
						self documents at: (index + 1) put: anElement ]
]

{ #category : #actions }
AKassaCheckJournalGlamour >> moveUp: anElement [
	| index |
	index := self documents indexOf: anElement.
	(index = 1 or: [ index = 0 ])
		ifFalse: [ self documents at: index put: (self documents at: index - 1).
						self documents at: (index - 1) put: anElement ]
]

{ #category : #opening }
AKassaCheckJournalGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
AKassaCheckJournalGlamour >> removeSelectionFrom: aPresentation [
	| cnt |
	cnt := (aPresentation pane port: #rawSelection) value.
	cnt cancelAccepted.
	cnt class documents remove: cnt ifAbsent: [  ].
]
