"
Графический интерфейс задачи

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ATaskGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
ATaskGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
ATaskGlamour >> initializeAccount [
	(browser transmit) to: #account;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Account' translated
						text: #account
						accept: #account:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATaskGlamour >> initializeAdditional [
	(browser transmit) to: #additional;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Additional' translated
						text: #additional
						accept: #additional:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATaskGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Task' translated.
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserActions.
	browser row: [ :r|
		r column: #number.
		r column: #date ] size: 43.
	browser row: #a1 size: 5.
	browser row: [ :r|
		r column: #organization.
		r column: #login.
		r column: #account ] size: 43.
	browser row: #a2 size: 5.
	browser row: #additional size: 43.
	browser row: #task.
]

{ #category : #initialization }
ATaskGlamour >> initializeBrowserActions [
		
	browser act: [ :p|
						model addAccount1: (AListDialogWindow selectItemFrom:
										AConfig accountsList).
						p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousInto
				entitled: 'Add Account 1' translated.
				
	browser act: [ :p|
			model removeAccounts.
			p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousUndo
		entitled: 'Unwire' translated.
				
	browser addAction: (AAction accept: [ model accept]).
	browser addAction: (AAction newExecuteTask: [ model createExecuteTask open ] ).
]

{ #category : #initialization }
ATaskGlamour >> initializeDate [
	(browser transmit) to: #date;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '*', 'Date' translated
						text: #date
						accept: #date:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATaskGlamour >> initializeLogin [
	(browser transmit) to: #login;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: 'Login' translated
						text: #login
						accept: #login:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATaskGlamour >> initializeNumber [
	(browser transmit) to: #number;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '*', 'Number' translated
						text: #number
						accept: #number:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATaskGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '*', 'Organization' translated
						text: #organization
						accept: #organization:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
ATaskGlamour >> initializeTask [
	(browser transmit) to: #task;
		andShow: [ :a|
			a text
				title: '* ', 'Task' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model task: textPresentation text asString ];
				display: [ :m| m task ] ].
]

{ #category : #initialization }
ATaskGlamour >> initializeTransmit [
	self initializeNumber.
	self initializeOrganization.
	self initializeDate.
	self initializeTask.
	self initializeAdditional.
	self initializeLogin.
	self initializeAccount.
]

{ #category : #opening }
ATaskGlamour >> open [
	browser openOn: model
]
