"
Графический интерфейс журнала списания

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
	#name : #AWriteOffJournalGlamour,
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
AWriteOffJournalGlamour >> addNew [
	AWriteOffModel addNew
]

{ #category : #intialization }
AWriteOffJournalGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
AWriteOffJournalGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Write-off Journal' translated.
	browser column: #writeOffs span: 1.
	browser column: #writeOff span: 4.
]

{ #category : #intialization }
AWriteOffJournalGlamour >> initializeTransmit [
	self initializeWriteOffs.
	self initializeWriteOff.
]

{ #category : #intialization }
AWriteOffJournalGlamour >> initializeWriteOff [
	browser transmit from: #writeOffs; to: #writeOff;
		andShow: [ :a|
			a custom: AWriteOffGlamour new browser ].
	
	browser transmit to: #writeOff;
		andShow: [ :a|
			a text display: 'Select a Write-off Document' translated ].
]

{ #category : #intialization }
AWriteOffJournalGlamour >> initializeWriteOffs [
	browser transmit to: #writeOffs;
		andShow: [ :a|
			a table
				title: 'Write-off' translated;
				
				act: [ :pr| 	self addNew. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'add';
				
				act: [ :pr| self removeSelectionFrom: pr. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'remove';
				
				display: [ :m| m reverse ];
				column: '#' evaluated: [ :each| each number ] width: 30;
				column: 'organization' evaluated: [ :each| each organization, ' ',each account2, '-', each account3] ].
]

{ #category : #opening }
AWriteOffJournalGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
AWriteOffJournalGlamour >> removeSelectionFrom: aPresentation [
	| sw |
	sw := (aPresentation pane port: #rawSelection) value.
	sw cancelAccepted.
	sw class documents remove: sw ifAbsent: [  ]
]
