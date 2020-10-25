"
Модель задачи

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	date:		<Object>
	login:		<Object>
	number:		<Object>
	organization:		<Object>
	period:		<Object>
	task:		<Object>


    Implementation Points
"
Class {
	#name : #ATaskModel,
	#superclass : #AModel,
	#instVars : [
		'number',
		'date',
		'organization',
		'task',
		'login',
		'account'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
ATaskModel class >> baseTitle [
	^ 'Task' translated
]

{ #category : #adding }
ATaskModel class >> documents [
	^ self configClass taskJournal
]

{ #category : #adding }
ATaskModel class >> nextIndex [
	^ self configClass nextTaskIndex2 asString
]

{ #category : #adding }
ATaskModel class >> title [
	^ 'Tasks' translated
]

{ #category : #actions }
ATaskModel >> accept [
	| s swap t |
	t := Time
		millisecondsToRun: [ self cancelAccepted.
			swap := ASwapBuilder new.
			swap common add: self taskName.
			swap common add: self numberPrefix , self number.
			swap first add: self organization.
			swap first addAll: (ADateTagsBuilder new date: self date) build.
			self login = ''
				ifFalse: [ swap first add: self login ].
			self account = ''
				ifFalse: [ swap first add: self account ].
			swap second add: self emptyAccountName.
			swap firstAmounts add: self firstAmount.
			s := swap build.
			self accounts addAll: s.
			self savedAccounts: s ].
	self
		trace:
			self number asString , ' task is saved. Milliseconds to run: '
				, t asString , String cr.
	^ s
]

{ #category : #accessing }
ATaskModel >> account [
	^ account ifNil: [ account := '' ]
]

{ #category : #accessing }
ATaskModel >> account: anObject [
	account := anObject.
	self changed: #account
]

{ #category : #actions }
ATaskModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
	anArray size < 2 ifTrue: [ self login: ''; account: ''. ^ self ].
	self login: (anArray at: 2).
	anArray size < 3 ifTrue: [ self account: ''. ^ self ].
	self account: (anArray at: 3).
]

{ #category : #accessing }
ATaskModel >> anyOrganization [
	^ self class anyOrganization
]

{ #category : #accessing }
ATaskModel >> completeTaskButtonName [
	^ 'Complete Task'
]

{ #category : #actions }
ATaskModel >> createAndOpenExecuteTask [
	^ self createExecuteTask open.
]

{ #category : #actions }
ATaskModel >> createExecuteTask [
	| exeT |
	exeT := AExecuteTaskModel new.
	exeT
		task: self task;
		number: self configClass nextExecuteTaskIndex2;
		date: self today;
		organization: self organization;
		login: self login;
		account: self account;
		percent: '100'.
	AExecuteTaskModel documents add: exeT.
	^ exeT
		
]

{ #category : #accessing }
ATaskModel >> date [
	^ date ifNil: [ date := '' ]
]

{ #category : #accessing }
ATaskModel >> date: anObject [
	date := anObject.
	self changed: #date.
]

{ #category : #configuration }
ATaskModel >> emptyAccountName [
	^ self configClass emptyAccountName
]

{ #category : #actions }
ATaskModel >> firstAmount [
	^ AAmount new
			amount: 1;
			add: self task;
			yourself
	
]

{ #category : #accessing }
ATaskModel >> firstName [
	^ self number asString.
]

{ #category : #initialization }
ATaskModel >> initialize [
	super initialize.
	date := self today.
]

{ #category : #accessing }
ATaskModel >> login [
	^ login ifNil: [ login := '' ]
]

{ #category : #accessing }
ATaskModel >> login: anObject [
	login := anObject.
	self changed: #login
]

{ #category : #rendering }
ATaskModel >> morphController [
	^ FDirectController new.
]

{ #category : #rendering }
ATaskModel >> morphRenderer [
	^ ATaskMorphRenderer new
]

{ #category : #rendering }
ATaskModel >> morphView [
	^ self morphController listen: #yourself from: self.
]

{ #category : #rendering }
ATaskModel >> morphViewInWindow [
	| m w |
	m := self morphView.
	w := StandardWindow new.
	w title: (self number, ' ', 'Task' translated).
	w addMorph: m frame: LayoutFrame new.
	w open.
	^ m
]

{ #category : #accessing }
ATaskModel >> number [
	^ number ifNil: [ number := '' ]
]

{ #category : #accessing }
ATaskModel >> number: anObject [
	number := anObject.
	self changed: #number.
]

{ #category : #configuration }
ATaskModel >> numberPrefix [
	^ self configClass numberPrefix
]

{ #category : #actions }
ATaskModel >> open [
	^ ATaskGlamour openOn: self
]

{ #category : #accessing }
ATaskModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
ATaskModel >> organization: anObject [
	organization := anObject.
	self changed: #organization
]

{ #category : #accessing }
ATaskModel >> secondName [
	^ self organization, 
		(self login = '' ifFalse: [' - ', self login] ifTrue: [ '' ]),
		(self account = '' ifFalse: [ ' - ', self account ] ifTrue: [ '' ] )
]

{ #category : #accessing }
ATaskModel >> task [
	^ task ifNil: [ task := '' ]
]

{ #category : #accessing }
ATaskModel >> task: anObject [
	task := anObject.
	self changed: #task
]

{ #category : #configuration }
ATaskModel >> taskName [
	^ self configClass taskName
]

{ #category : #configuration }
ATaskModel >> taskPrefix [
	^ self configClass emptyAccountName
]

{ #category : #accessing }
ATaskModel >> title [
	^ self number, ' ', 'Task' translated
]
