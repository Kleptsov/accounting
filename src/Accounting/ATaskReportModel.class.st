"
Модел отчета задач

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	day:		<Object>
	login:		<Object>
	month:		<Object>
	number:		<Object>
	organization:		<Object>
	report:		<Object>
	selectedTask:		<Object>
	task:		<Object>
	year:		<Object>


    Implementation Points
"
Class {
	#name : #ATaskReportModel,
	#superclass : #AAbstractReportModel,
	#instVars : [
		'day',
		'month',
		'year',
		'organization',
		'task',
		'report',
		'selectedTask',
		'login',
		'account'
	],
	#category : #'Accounting-Report'
}

{ #category : #accessing }
ATaskReportModel >> account [
	^ account ifNil: [ account := '' ]
]

{ #category : #accessing }
ATaskReportModel >> account: anObject [
	account := anObject.
	self changed: #account.
]

{ #category : #configuration }
ATaskReportModel >> accounts [
	^ AConfig accounts
]

{ #category : #actions }
ATaskReportModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
	anArray size < 2 ifTrue: [ self login: ''; account: ''. ^ self ].
	self login: (anArray at: 2).
	anArray size < 3 ifTrue: [ self account: ''. ^ self ].
	self account: (anArray at: 3).
]

{ #category : #actions }
ATaskReportModel >> createExecuteTask [
	| e t |
	e := AExecuteTaskModel addNew.
	t := self selectedTask inject: '' into: [ :s :el| s, el ].
	e task: t.
	e date: self today.
	e organization: self organization.
	e percent: self selectedTask amount * 100.
	e login: self login.
	e account: self account.
	^ e.
]

{ #category : #actions }
ATaskReportModel >> createReport [
	| q a b |
	"unused"
	q := self queryTask.
	a := self accounts select: q.
	q := self queryExecuteTask.
	b := self accounts select: q.
	a addAccount: b.
	a removeEmptyAmounts.
	self report: a amounts.
	^ a.
]

{ #category : #accessing }
ATaskReportModel >> day [
	^ day ifNil: [ day := '' ]
]

{ #category : #accessing }
ATaskReportModel >> day: anObject [
	day := anObject.
	self changed: #day
]

{ #category : #accessing }
ATaskReportModel >> login [
	^ login ifNil: [ login := '' ]
]

{ #category : #accessing }
ATaskReportModel >> login: anObject [
	login := anObject.
	self changed: #login
]

{ #category : #actions }
ATaskReportModel >> makeReport [
	| q a b t |
	t := Time
		millisecondsToRun: [ q := self queryTask.
			a := self accounts select: q.
			q := self queryExecuteTask.
			b := self accounts select: q.
			a addAccount: b.
			a removeEmptyAmounts.
			self report: a ].
	self
		trace: 'Report is created. Milliseconds to run: ' , t asString , String cr.
	^ a
]

{ #category : #accessing }
ATaskReportModel >> month [
	^ month ifNil: [ month := '' ]
]

{ #category : #accessing }
ATaskReportModel >> month: anObject [
	month := anObject.
	self changed: #month
]

{ #category : #actions }
ATaskReportModel >> open [
	^ ATaskReportGlamour openOn: self
]

{ #category : #accessing }
ATaskReportModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
ATaskReportModel >> organization: anObject [
	organization := anObject.
	self changed: #organization
]

{ #category : #actions }
ATaskReportModel >> queryExecuteTask [
	| query |
	query := AAccount new.
	query add: self organization.
	query add: self executeTaskName.
	(self login = '') ifFalse: [ query add: self login ].
	(self account = '') ifFalse: [ query add: self account ].
	(self year = '') ifFalse: [ query add: self yearPrefix, self year ].
	(self month = '') ifFalse: [ query add: self monthPrefix, self month ].
	(self day = '') ifFalse: [ query add: self dayPrefix, self day ].
	^ query.
]

{ #category : #actions }
ATaskReportModel >> queryTask [
	| query |
	query := AAccount new.
	query add: self organization.
	query add: self taskName.
	(self login = '') ifFalse: [ query add: self login ].
	(self account = '') ifFalse: [ query add: self account ].
	(self year = '') ifFalse: [ query add: self yearPrefix, self year ].
	(self month = '') ifFalse: [ query add: self monthPrefix, self month ].
	(self day = '') ifFalse: [query add: self dayPrefix, self day ].
	^ query.
]

{ #category : #accessing }
ATaskReportModel >> report [
	^ report ifNil: [ report := AAccount new ]
]

{ #category : #accessing }
ATaskReportModel >> report: anObject [
	report := anObject
]

{ #category : #accessing }
ATaskReportModel >> selectedTask [
	^ selectedTask
]

{ #category : #accessing }
ATaskReportModel >> selectedTask: anObject [
	selectedTask := anObject.
	self changed: #selectedTaskString
]

{ #category : #accessing }
ATaskReportModel >> selectedTaskString [
	^ self selectedTask ifNil: [ '' ] ifNotNil: [ :el| el asString ]
]

{ #category : #accessing }
ATaskReportModel >> selectedTaskString: aTask [
]

{ #category : #accessing }
ATaskReportModel >> task [
	^ task ifNil: [ task := '' ]
]

{ #category : #accessing }
ATaskReportModel >> task: anObject [
	task := anObject.
	self changed: #task
]

{ #category : #accessing }
ATaskReportModel >> year [
	^ year ifNil: [ year := '' ]
]

{ #category : #accessing }
ATaskReportModel >> year: anObject [
	year := anObject.
	self changed: #year
]
