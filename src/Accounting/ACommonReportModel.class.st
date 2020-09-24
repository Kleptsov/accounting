"
Модель отчетов по счетам

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	day:		<Object>
	first:		<Object>
	fourth:		<Object>
	month:		<Object>
	report:		<Object>
	second:		<Object>
	third:		<Object>
	year:		<Object>


    Implementation Points
"
Class {
	#name : #ACommonReportModel,
	#superclass : #AAbstractReportModel,
	#instVars : [
		'year',
		'month',
		'day',
		'acc1',
		'acc2',
		'acc3',
		'acc4',
		'first',
		'second',
		'third',
		'fourth',
		'report',
		'selectedItems',
		'selected'
	],
	#category : #'Accounting-Report'
}

{ #category : #accessing }
ACommonReportModel >> acc1 [
	^ acc1 ifNil: [ acc1 := '' ]
]

{ #category : #accessing }
ACommonReportModel >> acc1: anObject [
	acc1 := anObject.
	self changed: #acc1.
]

{ #category : #accessing }
ACommonReportModel >> acc2 [
	^ acc2 ifNil: [ acc2 := '' ]
]

{ #category : #accessing }
ACommonReportModel >> acc2: anObject [
	acc2 := anObject.
	self changed: #acc2
]

{ #category : #accessing }
ACommonReportModel >> acc3 [
	^ acc3 ifNil: [ acc3 := '' ]
]

{ #category : #accessing }
ACommonReportModel >> acc3: anObject [
	acc3 := anObject.
	self changed: #acc3
]

{ #category : #accessing }
ACommonReportModel >> acc4 [
	^ acc4 ifNil: [ acc4 := '' ]
]

{ #category : #accessing }
ACommonReportModel >> acc4: anObject [
	acc4 := anObject.
	self changed: #acc4
]

{ #category : #actions }
ACommonReportModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self acc1: (anArray at: 1).
	anArray size < 2 ifTrue: [
		self acc2: ''.
		self acc3: ''.
		self acc4: ''.
		^ self ].
	self acc2: (anArray at: 2).
	anArray size < 3 ifTrue: [
		self acc3: ''.
		self acc4: ''. ^ self ].
	self acc3: (anArray at: 3).
	anArray size < 4 ifTrue: [ 
		self acc4: ''.
		^ self ].
	self acc4: (anArray at: 4).
]

{ #category : #actions }
ACommonReportModel >> createRecordingOf [
	| w |
	w := ARecordingOfModel addNew.
	w items addAccount: self selectedItems.
	w organization: self acc1.
	w account2: self acc2.
	w account3: self acc3.
	^ w
]

{ #category : #actions }
ACommonReportModel >> createTransfer [
	| w |
	w := ATransferModel addNew.
	w items addAccount: self selectedItems.
	w organization: self acc1.
	w sourceAccount: self acc2.
	^ w
]

{ #category : #actions }
ACommonReportModel >> createWriteOff [
	| w |
	w := AWriteOffModel addNew.
	w items addAccount: self selectedItems.
	w organization: self acc1.
	w account2: self acc2.
	w account3: self acc3.
	^ w
]

{ #category : #accessing }
ACommonReportModel >> day [
	^ day ifNil: [ day := '' ]
]

{ #category : #accessing }
ACommonReportModel >> day: anObject [
	day := anObject.
	self changed: #day
]

{ #category : #actions }
ACommonReportModel >> makeReport [
	| q t |
	t := Time
		millisecondsToRun: [ q := self query.
			self inform: q asString.
			report := self accounts select: q.
			report
				amounts: (report amounts select: [ :am | am amount ~= 0 ]) ].
	self
		trace:
			'Common report is created. Milliseconds to run: ' , t asString
				, String cr.
	^ report
]

{ #category : #accessing }
ACommonReportModel >> month [
	^ month ifNil: [ month := '' ]
]

{ #category : #accessing }
ACommonReportModel >> month: aMonth [
	month := aMonth.
	self changed: #month
]

{ #category : #actions }
ACommonReportModel >> open [
	^ ACommonReportGlamour openOn: self
]

{ #category : #actions }
ACommonReportModel >> query [
	| q |
	q := AAccount new.
	(self acc1 = '') ifFalse: [ q add: self acc1 ].
	(self acc2 = '') ifFalse: [ q add: self acc2 ].
	(self acc3 = '') ifFalse: [ q add: self acc3 ].
	(self acc4 = '') ifFalse: [ q add: self acc4 ].
	(self year = '') ifFalse: [ q add: self yearPrefix, self year ].
	(self month = '') ifFalse: [ q add: self monthPrefix, self month ].
	(self day = '') ifFalse: [q add: self dayPrefix, self day ].
	^ q
]

{ #category : #accessing }
ACommonReportModel >> report [
	^ report ifNil: [ report := AAccount new ]
]

{ #category : #accessing }
ACommonReportModel >> report: anObject [
	report := anObject
]

{ #category : #actions }
ACommonReportModel >> selectItem: anAmount [
	self selectedItems addAmount: anAmount.
	self report removeAmount: anAmount.
]

{ #category : #accessing }
ACommonReportModel >> selected [
	^ selected ifNil: [ selected := '' ]
]

{ #category : #accessing }
ACommonReportModel >> selected: anObject [
	selected := anObject.
	self changed: #selected
]

{ #category : #accessing }
ACommonReportModel >> selectedItems [
	^ selectedItems ifNil: [ selectedItems := AAccount new  ]
]

{ #category : #accessing }
ACommonReportModel >> selectedItems: anObject [
	selectedItems := anObject
]

{ #category : #actions }
ACommonReportModel >> unselectItem: anAmount [
	self selectedItems removeAmount: anAmount.
	self report addAmount: anAmount.
]

{ #category : #accessing }
ACommonReportModel >> year [
	^ year ifNil: [ year := '' ]
]

{ #category : #accessing }
ACommonReportModel >> year: anObject [
	year := anObject.
	self changed: #year
]
