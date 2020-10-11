"
Графический интерфейс журнала выполнения заданий

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	browser:		<Object>
	model:		<Object>


    Implementation Points
"
Class {
	#name : #AExecuteTaskJournalGlamour,
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
AExecuteTaskJournalGlamour >> addNew [
	AExecuteTaskModel addNew
]

{ #category : #intialization }
AExecuteTaskJournalGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
AExecuteTaskJournalGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Execute Task Journal' translated.
	browser column: #tasks span: 1.
	browser column: #task span: 4.
]

{ #category : #intialization }
AExecuteTaskJournalGlamour >> initializeTask [
	browser transmit from: #tasks; to: #task;
		andShow: [ :a|
			a custom: AExecuteTaskGlamour new browser. ].
		
	browser transmit to: #task;
		andShow: [ :a|
			a text display: 'Select a Task' translated ]
]

{ #category : #intialization }
AExecuteTaskJournalGlamour >> initializeTasks [
	browser transmit to: #tasks;
		andShow: [ :a|
			a table
				title: 'Execute Tasks' translated;
				
				act: [ :pr| self removeSelectionFrom: pr. pr update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				display: [ :m| m reverse ];
				column: '#' evaluated: [ :each| each number ] width: 35;
				column: 'Execute Task Account' translated evaluated: [ :each| each organization, ' ', each login  ] ].
]

{ #category : #intialization }
AExecuteTaskJournalGlamour >> initializeTransmit [
	self initializeTasks.
	self initializeTask.
]

{ #category : #opening }
AExecuteTaskJournalGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
AExecuteTaskJournalGlamour >> removeSelectionFrom: aPresentation [
	| extask |
	extask := (aPresentation pane port: #rawSelection) value.
	extask cancelAccepted.
	extask class documents remove: extask ifAbsent: [  ].
]
