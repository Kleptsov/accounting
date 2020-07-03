"
Модель выполнения задания

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
	percent:		<Object>
	task:		<Object>


    Implementation Points
"
Class {
	#name : #AExecuteTaskModel,
	#superclass : #AModel,
	#instVars : [
		'number',
		'date',
		'organization',
		'task',
		'percent',
		'login',
		'account'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
AExecuteTaskModel class >> documents [
	^ self configClass executeTasks2
]

{ #category : #adding }
AExecuteTaskModel class >> nextIndex [
	^ self configClass nextExecuteTaskIndex2 asString
]

{ #category : #actions }
AExecuteTaskModel >> accept [
	| s swap t |
	t := Time
		millisecondsToRun: [ self removeAccounts.
			swap := ASwapBuilder new.
			swap common add: self executeTaskName.
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
			self accounts addAll: s ].
	self
		trace:
			self number asString , ' execute task is saved. Milliseconds to run: '
				, t asString , String cr.
	^ s
]

{ #category : #accessing }
AExecuteTaskModel >> account [
	^ account ifNil: [ account := '' ]
]

{ #category : #accessing }
AExecuteTaskModel >> account: anObject [
	account := anObject.
	self changed: #account
]

{ #category : #accessing }
AExecuteTaskModel >> date [
	^ date ifNil: [ date := '' ]
]

{ #category : #accessing }
AExecuteTaskModel >> date: anObject [
	date := anObject.
	self changed: #date.
]

{ #category : #configuration }
AExecuteTaskModel >> emptyAccountName [
	^ self configClass emptyAccountName
]

{ #category : #configuration }
AExecuteTaskModel >> executeTaskName [
	^ self configClass executeTaskName
]

{ #category : #configuration }
AExecuteTaskModel >> executeTaskPrefix [
	^ self configClass executeTaskPrefix
]

{ #category : #actions }
AExecuteTaskModel >> firstAmount [
	| amount |
	amount := AAmount new
					addAll: { self task. };
					amount: (self percent asNumber / 100 * (-1)) asFloat.
	^ amount.
	
]

{ #category : #accessing }
AExecuteTaskModel >> login [
	^ login ifNil: [ login := '' ]
]

{ #category : #accessing }
AExecuteTaskModel >> login: anObject [
	login := anObject.
	self changed: #login.
]

{ #category : #accessing }
AExecuteTaskModel >> number [
	^ number ifNil: [ number := '' ]
]

{ #category : #accessing }
AExecuteTaskModel >> number: anObject [
	number := anObject.
	self changed: #number
]

{ #category : #configuration }
AExecuteTaskModel >> numberPrefix [
	^ self configClass numberPrefix
]

{ #category : #actions }
AExecuteTaskModel >> open [
	^ AExecuteTaskGlamour openOn: self
]

{ #category : #accessing }
AExecuteTaskModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
AExecuteTaskModel >> organization: anObject [
	organization := anObject.
	self changed: #organization.
]

{ #category : #accessing }
AExecuteTaskModel >> percent [
	^ percent ifNil: [ percent := '' ]
]

{ #category : #accessing }
AExecuteTaskModel >> percent: anObject [
	percent := anObject.
	self changed: #percent.
]

{ #category : #actions }
AExecuteTaskModel >> removeAccounts [
	| rAccount |
	rAccount := AAccount new
		addAll: { self numberPrefix, self number. self executeTaskName };
		yourself.
	self accounts remove: rAccount
]

{ #category : #accessing }
AExecuteTaskModel >> task [
	^ task ifNil: [ task := '' ]
]

{ #category : #accessing }
AExecuteTaskModel >> task: anObject [
	task := anObject.
	self changed: #task.
]
