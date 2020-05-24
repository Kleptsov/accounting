"
Графический интерфейс исполнения задачи

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AExecuteTaskGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
AExecuteTaskGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
AExecuteTaskGlamour >> initializeAccount [
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
AExecuteTaskGlamour >> initializeAdditional [
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
AExecuteTaskGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Execute Task' translated.
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserActions.
	browser row: [ :r|
		r column: #number.
		r column: #organization ] size: 43.
	browser row: #a1 size: 5.
	browser row: [ :r|
		r column: #login.
		r column: #account.
		r column: #date.
		r column: #percent ] size: 43.
	browser row: #a2 size: 5.
	browser row: #additional size: 43.
	browser row: #task.
]

{ #category : #initialization }
AExecuteTaskGlamour >> initializeBrowserActions [
	browser act: [ :p| model removeAccounts. p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousUndo
		entitled: 'Unwire' translated.
		
	browser act: [ :p| self model accept ]
		icon: GLMUIThemeExtraIcons glamorousAccept
		entitled: 'Accept'.
]

{ #category : #initialization }
AExecuteTaskGlamour >> initializeDate [
	(browser transmit) to: #date;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '* ', 'Date' translated
						text: #date
						accept: #date:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AExecuteTaskGlamour >> initializeLogin [
	(browser transmit) to: #login;
		andShow: [ :a|
			a text
				title: '* ', 'Login' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model login: textPresentation text asString ];
				display: [ :m| m login ] ].
	(browser transmit) to: #login;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '* ', 'Login' translated
						text: #login
						accept: #login:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AExecuteTaskGlamour >> initializeNumber [
	(browser transmit) to: #number;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '* ', 'Number' translated
						text: #number
						accept: #number:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AExecuteTaskGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '* ', 'Organization' translated
						text: #organization
						accept: #organization:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AExecuteTaskGlamour >> initializePercent [
	(browser transmit) to: #percent;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: '* ', 'Percent' translated
						text: #percent
						accept: #percent:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AExecuteTaskGlamour >> initializeTask [
	(browser transmit) to: #task;
		andShow: [ :a|
			a text
				title: '* ', 'Task' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model task: textPresentation text asString ];
				display: [ :m| m task ] ].
]

{ #category : #initialization }
AExecuteTaskGlamour >> initializeTransmit [
	self initializeNumber.
	self initializeOrganization.
	self initializeLogin.
	self initializeAccount.
	self initializeDate.
	self initializePercent.
	self initializeTask.
	self initializeAdditional.
]

{ #category : #opening }
AExecuteTaskGlamour >> open [
	browser openOn: model
]
