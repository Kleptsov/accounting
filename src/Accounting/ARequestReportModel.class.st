"
Модель отчета заявок

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	contractNumber:		<Object>
	day:		<Object>
	login:		<Object>
	month:		<Object>
	number:		<Object>
	organization:		<Object>
	report:		<Object>
	year:		<Object>


    Implementation Points
"
Class {
	#name : #ARequestReportModel,
	#superclass : #AAbstractReportModel,
	#instVars : [
		'number',
		'contractNumber',
		'day',
		'month',
		'year',
		'login',
		'organization',
		'report',
		'selectionItem'
	],
	#category : #'Accounting-Report'
}

{ #category : #configuration }
ARequestReportModel >> accounts [
	^ self configClass accounts
]

{ #category : #actions }
ARequestReportModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
	anArray size < 2 ifTrue: [
		self login: '' ]
]

{ #category : #accessing }
ARequestReportModel >> contractNumber [
	^ contractNumber ifNil: [ contractNumber := '' ]
]

{ #category : #accessing }
ARequestReportModel >> contractNumber: anObject [
	contractNumber := anObject
]

{ #category : #configuration }
ARequestReportModel >> contractObligationName [
	^ self configClass contractObligationName
]

{ #category : #actions }
ARequestReportModel >> createContract [
	| c items |
	c := AContractModel addNew.
	items := self report.
	c items: items.
	c date: (Date today printFormat: #(1 2 3 $. 1 1 2) ).
	c organization: self organization.
	^ c.
]

{ #category : #accessing }
ARequestReportModel >> day [
	^ day ifNil: [ day := '' ]
]

{ #category : #accessing }
ARequestReportModel >> day: anObject [
	day := anObject
]

{ #category : #configuration }
ARequestReportModel >> dayPrefix [
	^ self configClass dayPrefix
]

{ #category : #accessing }
ARequestReportModel >> login [
	^ login ifNil: [ login := '' ]
]

{ #category : #accessing }
ARequestReportModel >> login: anObject [
	login := anObject
]

{ #category : #actions }
ARequestReportModel >> makeReport [
	| q a b t |
	t := Time
		millisecondsToRun: [ q := self queryRequest.
			a := self accounts select: q.
			q := self queryContract.
			b := self accounts select: q.
			a addAccount: b.
			a amounts: (a amounts select: [ :am | am amount > 0 ]).
			report := a ].
	self
		trace:
			'A request report is created. Milliseconds to run: ' , t asString
				, String cr.
	^ a
]

{ #category : #accessing }
ARequestReportModel >> month [
	^ month ifNil: [ month := '' ]
]

{ #category : #accessing }
ARequestReportModel >> month: anObject [
	month := anObject
]

{ #category : #configuration }
ARequestReportModel >> monthPrefix [
	^ self configClass monthPrefix
]

{ #category : #accessing }
ARequestReportModel >> number [
	^ number ifNil: [ number := '' ]
]

{ #category : #accessing }
ARequestReportModel >> number: anObject [
	number := anObject
]

{ #category : #configuration }
ARequestReportModel >> numberPrefix [
	^ self configClass numberPrefix
]

{ #category : #accessing }
ARequestReportModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
ARequestReportModel >> organization: anObject [
	organization := anObject
]

{ #category : #actions }
ARequestReportModel >> queryContract [
	| query |
	query := AAccount new.
	query add: self organization.
	query add: self contractObligationName.
	(self contractNumber = '') ifFalse: [ query add: self numberPrefix, self contractNumber ].
	^ query.
]

{ #category : #actions }
ARequestReportModel >> queryRequest [
	| query |
	query := AAccount new.
	query add: self requestName.
	query add: self organization.
	(self number = '') ifFalse: [ query add: self numberPrefix, self number ].
	(self login = '') ifFalse: [ query add: self login ] .
	(self year = '') ifFalse: [ query add: self yearPrefix, self year ].
	(self month = '') ifFalse: [ query add: self monthPrefix, self month ].
	(self day = '') ifFalse: [query add: self dayPrefix, self day ].
	^ query.
]

{ #category : #actions }
ARequestReportModel >> removeItem [
	self report amounts remove: selectionItem ifAbsent: [  ].
]

{ #category : #accessing }
ARequestReportModel >> report [
	^ report ifNil: [ report := AAccount new ]
]

{ #category : #accessing }
ARequestReportModel >> report: anObject [
	report := anObject
]

{ #category : #configuration }
ARequestReportModel >> requestName [
	^ self configClass requestName
]

{ #category : #accessing }
ARequestReportModel >> selectionItem [
	^ selectionItem ifNil: [ selectionItem := '' ]
]

{ #category : #accessing }
ARequestReportModel >> selectionItem: anObject [
	selectionItem := anObject
]

{ #category : #accessing }
ARequestReportModel >> year [
	^ year ifNil: [ year := '' ]
]

{ #category : #accessing }
ARequestReportModel >> year: anObject [
	year := anObject
]

{ #category : #configuration }
ARequestReportModel >> yearPrefix [
	^ self configClass yearPrefix
]
