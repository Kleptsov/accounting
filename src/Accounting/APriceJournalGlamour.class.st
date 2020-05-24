"
Журнал документов цен

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
	#name : #APriceJournalGlamour,
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
APriceJournalGlamour >> addNew [
	APriceModel addNew
]

{ #category : #intialization }
APriceJournalGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
APriceJournalGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Price Document Journal' translated.
	browser column: #prices span: 1.
	browser column: #price span: 4.
]

{ #category : #intialization }
APriceJournalGlamour >> initializePrice [
	browser transmit from: #prices; to: #price;
		andShow: [ :a|
			a custom: APriceGlamour new browser. ].
		
	browser transmit to: #price;
		andShow: [ :a|
			a text display: 'Select a Price Document' translated ]
]

{ #category : #intialization }
APriceJournalGlamour >> initializePrices [
	browser transmit to: #prices;
		andShow: [ :a|
			a tree
				title: 'Prices' translated;
				
				act: [ :p | (p pane port: #selection) value clone open. p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousBrowse
				entitled: 'Clone' translated;
				
				act: [ :pr| 	self addNew. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :pr| self removeSelectionFrom: pr. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				format: [ :m| m number, ' ', 'Price Document' translated ];
				
				display: [ :m| m reverse ] ].
]

{ #category : #intialization }
APriceJournalGlamour >> initializeTransmit [
	self initializePrices.
	self initializePrice.
]

{ #category : #opening }
APriceJournalGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
APriceJournalGlamour >> removeSelectionFrom: aPresentation [
	| prc |
	prc := (aPresentation pane port: #rawSelection) value.
	prc removeAccounts.
	prc class documents remove: prc ifAbsent: [  ] .
]
