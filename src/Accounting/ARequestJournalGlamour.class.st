"
Журнал заявок

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
	#name : #ARequestJournalGlamour,
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
ARequestJournalGlamour >> addNew [
	ARequestModel addNew.
]

{ #category : #actions }
ARequestJournalGlamour >> documents [
	^ AConfig requests2
]

{ #category : #intialization }
ARequestJournalGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
ARequestJournalGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Request Journal' translated.
	browser column: #requests span: 1.
	browser column: #request span: 4.
	browser column: #tmp size: 0.
]

{ #category : #intialization }
ARequestJournalGlamour >> initializeRequest [
	browser transmit from: #requests; to: #request;
		andShow: [ :a|
			a custom: ARequestGlamour new browser ].
		
	browser transmit to: #request;
		andShow: [ :a|
			a text display: 'Select a Request' translated ].
		
	
]

{ #category : #intialization }
ARequestJournalGlamour >> initializeRequests [
	browser transmit to: #requests;
		andShow: [ :a|
			a table
				title: 'Requests' translated;
				
				act: [ :pr| self moveUp: (pr pane port: #selection) value. pr update ]
				icon: GLMUIThemeExtraIcons glamorousUp
				entitled: 'Move Item Up' translated;
				
				act: [ :pr| self moveDown: (pr pane port: #selection) value. pr update]
				icon: GLMUIThemeExtraIcons glamorousDown
				entitled: 'Move Item Down' translated;
				
				act: [ :pr| 	self addNew. browser update ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :pr| self removeSelectionFrom: pr. browser update ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				display: [ :m| m reverse ];
				column: '#' evaluated: [ :each| each number ] width: 35;
				column: 'Request Account' translated evaluated: [ :each| each organization, ' ', each login  ] ].
]

{ #category : #intialization }
ARequestJournalGlamour >> initializeTransmit [
	self initializeRequests.
	self initializeRequest.
]

{ #category : #actions }
ARequestJournalGlamour >> moveDown: anElement [
	| index |
	index := self documents indexOf: anElement.
	(index = (self documents size) or: [ index = 0 ])
		ifFalse: [ self documents at: index put: (self documents at: index + 1).
						self documents at: (index + 1) put: anElement ]
]

{ #category : #actions }
ARequestJournalGlamour >> moveUp: anElement [
	| index |
	index := self documents indexOf: anElement.
	(index = 1 or: [ index = 0 ])
		ifFalse: [ self documents at: index put: (self documents at: index - 1).
						self documents at: (index - 1) put: anElement ]
]

{ #category : #opening }
ARequestJournalGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
ARequestJournalGlamour >> removeSelectionFrom: aPresentation [
	| req |
	req := (aPresentation pane port: #rawSelection) value.
	req removeAccounts.
	req class documents remove: req ifAbsent: [  ] .
]
