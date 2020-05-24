"
Модель отчета по обменным операциям

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	day:		<Object>
	month:		<Object>
	organization:		<Object>
	report:		<Object>
	swapNumber:		<Object>
	year:		<Object>


    Implementation Points
"
Class {
	#name : #ASwapReportModel,
	#superclass : #AAbstractReportModel,
	#instVars : [
		'swapNumber',
		'day',
		'month',
		'year',
		'organization',
		'report',
		'selectedItem'
	],
	#category : #'Accounting-Report'
}

{ #category : #actions }
ASwapReportModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
]

{ #category : #accessing }
ASwapReportModel >> day [
	^ day ifNil: [ day := '' ]
]

{ #category : #accessing }
ASwapReportModel >> day: anObject [
	day := anObject
]

{ #category : #actions }
ASwapReportModel >> makeReport [
	| q t |
	t := Time
		millisecondsToRun: [ q := self makeSwap.
			report := self accounts select: q ].
	self
		trace:
			'A swap report is created. Milliseconds to run: ' , t asString
				, String cr.
	^ report
]

{ #category : #actions }
ASwapReportModel >> makeSwap [
	| query |
	query := AAccount new.
	query add: self organization.
	query add: self swapName.
	(self swapNumber = '') ifFalse: [ query add: self numberPrefix, self swapNumber ].
	(self year = '') ifFalse: [ query add: self yearPrefix, self year ].
	(self month = '') ifFalse: [ query add: self monthPrefix, self month ].
	(self day = '') ifFalse: [query add: self dayPrefix, self day ].
	^ query.
]

{ #category : #accessing }
ASwapReportModel >> month [
	^ month ifNil: [ month := '' ]
]

{ #category : #accessing }
ASwapReportModel >> month: anObject [
	month := anObject
]

{ #category : #accessing }
ASwapReportModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
ASwapReportModel >> organization: anObject [
	organization := anObject
]

{ #category : #accessing }
ASwapReportModel >> report [
	^ report ifNil: [ report := AAccount new ]
]

{ #category : #accessing }
ASwapReportModel >> report: anObject [
	report := anObject
]

{ #category : #accessing }
ASwapReportModel >> selectedItem [
	^ selectedItem ifNil: [ selectedItem := '' ]
]

{ #category : #accessing }
ASwapReportModel >> selectedItem: anObject [
	selectedItem := anObject
]

{ #category : #accessing }
ASwapReportModel >> swapNumber [
	^ swapNumber ifNil: [ swapNumber := '' ]
]

{ #category : #accessing }
ASwapReportModel >> swapNumber: anObject [
	swapNumber := anObject
]

{ #category : #accessing }
ASwapReportModel >> year [
	^ year ifNil: [ year := '' ]
]

{ #category : #accessing }
ASwapReportModel >> year: anObject [
	year := anObject
]
