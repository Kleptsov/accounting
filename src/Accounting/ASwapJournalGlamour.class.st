"
Графический интерфейс журнала обменных операций

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
	#name : #ASwapJournalGlamour,
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
ASwapJournalGlamour >> addNew [
	ASwapModel addNew
]

{ #category : #intialization }
ASwapJournalGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
ASwapJournalGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Swap Journal' translated.
	browser column: #swaps span: 1.
	browser column: #swap span: 4.
]

{ #category : #intialization }
ASwapJournalGlamour >> initializeSwap [
	browser transmit from: #swaps; to: #swap;
		andShow: [ :a|
			a custom: ASwapGlamour new browser ].
	
	browser transmit to: #swap;
		andShow: [ :a|
			a text display: 'Select a Swap' translated ].
]

{ #category : #intialization }
ASwapJournalGlamour >> initializeSwaps [
	browser transmit to: #swaps;
		andShow: [ :a|
			a table
				title: 'Swaps' translated;
				
				act: [ :pr| 	self addNew. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :pr| self removeSelectionFrom: pr. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				display: [ :m| m reverse ];
				column: '#' evaluated: [ :each| each number ] width: 30;
				column: 'Organization' translated evaluated: [ :each| each organization, '-', each contractor ] ].
]

{ #category : #intialization }
ASwapJournalGlamour >> initializeTransmit [
	self initializeSwaps.
	self initializeSwap.
]

{ #category : #opening }
ASwapJournalGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
ASwapJournalGlamour >> removeSelectionFrom: aPresentation [
	| sw |
	sw := (aPresentation pane port: #rawSelection) value.
	sw cancelAccepted.
	sw class documents remove: sw ifAbsent: [  ]
]
