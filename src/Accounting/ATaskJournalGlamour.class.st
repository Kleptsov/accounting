"
Журнал задач

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
	#name : #ATaskJournalGlamour,
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
ATaskJournalGlamour >> addNew [
	ATaskModel addNew
]

{ #category : #intialization }
ATaskJournalGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
ATaskJournalGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Task Journal' translated.
	browser column: #tasks span: 1.
	browser column: #task span: 4.
]

{ #category : #intialization }
ATaskJournalGlamour >> initializeTask [
	browser transmit from: #tasks; to: #task;
		andShow: [ :a|
			a custom: ATaskGlamour new browser. ].
		
	browser transmit to: #task;
		andShow: [ :a|
			a text display: 'Select a Task' translated ]
]

{ #category : #intialization }
ATaskJournalGlamour >> initializeTasks [
	browser transmit to: #tasks;
		andShow: [ :a|
			a table
				title: 'Tasks' translated;
				
				act: [ :pr| 	self addNew. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :pr| self removeSelectionFrom: pr. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				display: [ :m| m reverse ];
				column: '#' evaluated: [ :each| each number ] width: 35;
				column: 'Task Account' translated evaluated: [ :each| each organization, ' ', each login  ] ].
]

{ #category : #intialization }
ATaskJournalGlamour >> initializeTransmit [
	self initializeTasks.
	self initializeTask.
]

{ #category : #opening }
ATaskJournalGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
ATaskJournalGlamour >> removeSelectionFrom: aPresentation [
	| tsk|
	tsk := (aPresentation pane port: #rawSelection) value.
	tsk removeAccounts.
	tsk class documents remove: tsk ifAbsent: [  ] .
]
