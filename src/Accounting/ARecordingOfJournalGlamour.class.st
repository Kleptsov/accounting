"
Графический интерфейс журнала оприходывания 

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
	#name : #ARecordingOfJournalGlamour,
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
ARecordingOfJournalGlamour >> addNew [
	ARecordingOfModel addNew
]

{ #category : #intialization }
ARecordingOfJournalGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
ARecordingOfJournalGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Recording of Journal' translated.
	browser column: #recordingOfs span: 1.
	browser column: #recordingOf span: 4.
]

{ #category : #intialization }
ARecordingOfJournalGlamour >> initializeRecordingOf [
	browser transmit from: #recordingOfs; to: #recordingOf;
		andShow: [ :a|
			a custom: ARecordingOfGlamour new browser ].
	
	browser transmit to: #recordingOf;
		andShow: [ :a|
			a text display: 'Select a Recording of Document' translated ].
]

{ #category : #intialization }
ARecordingOfJournalGlamour >> initializeRecordingOfs [
	browser transmit to: #recordingOfs;
		andShow: [ :a|
			a table
				title: 'Recording of' translated;
				
				act: [ :pr| 	self addNew. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :pr| self removeSelectionFrom: pr. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				display: [ :m| m reverse ];
				column: '#' evaluated: [ :each| each number ] width: 30;
				column: 'Organization' translated evaluated: [ :each| each organization, ' ',each account2, '-', each account3] ].
]

{ #category : #intialization }
ARecordingOfJournalGlamour >> initializeTransmit [
	self initializeRecordingOfs.
	self initializeRecordingOf.
]

{ #category : #opening }
ARecordingOfJournalGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
ARecordingOfJournalGlamour >> removeSelectionFrom: aPresentation [
	| sw |
	sw := (aPresentation pane port: #rawSelection) value.
	sw cancelAccepted.
	sw class documents remove: sw ifAbsent: [  ]
]
