"
Модель отчета по контракту (ам), включает в себя выборку по контрактам, накладным и платежкам.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	contractNumber:		<Object>
	day:		<Object>
	month:		<Object>
	organization:		<Object>
	report:		<Object>
	year:		<Object>


    Implementation Points
"
Class {
	#name : #AContractReportModel,
	#superclass : #AAbstractReportModel,
	#instVars : [
		'contractNumber',
		'additionalContractNumber',
		'day',
		'month',
		'year',
		'organization',
		'report',
		'selectedItem',
		'itemsList',
		'accountEditor'
	],
	#category : #'Accounting-Report'
}

{ #category : #accessing }
AContractReportModel >> accountEditor [
	^ accountEditor ifNil: [ accountEditor := AAccountEditor new ]
]

{ #category : #accessing }
AContractReportModel >> accountEditor: anObject [
	accountEditor := anObject
]

{ #category : #actions }
AContractReportModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
]

{ #category : #accessing }
AContractReportModel >> additionalContractNumber [
	^ additionalContractNumber ifNil: [ additionalContractNumber := '' ]
]

{ #category : #accessing }
AContractReportModel >> additionalContractNumber: anObject [
	additionalContractNumber := anObject
]

{ #category : #accessing }
AContractReportModel >> contractNumber [
	^ contractNumber ifNil: [ contractNumber := '' ]
]

{ #category : #accessing }
AContractReportModel >> contractNumber: anObject [
	contractNumber := anObject.
	self changed: #contractNumber
]

{ #category : #actions }
AContractReportModel >> createInvoice [
	| i items index |
	i := AInvoiceModel addNew.
	items := self report.
	index := 0.
	items amounts do: [ :el|
			el unixTime: el unixTime + index.
			index := index + 1 ].
	i contractNumber: self contractNumber.
	i organization: self organization.
	i items: items.
	i date: (Date today printFormat: #(1 2 3 $. 1 1 2) ).
	^ i.
]

{ #category : #actions }
AContractReportModel >> createPayment [
	| p |
	p := APaymentModel addNew.
	p contractNumber: self contractNumber.
	p organization: self organization.
	p date: (Date today printFormat: #(1 2 3 $. 1 1 2) ). "dd.mm.yyyy"
	^ p.
]

{ #category : #accessing }
AContractReportModel >> day [
	^ day ifNil: [ day := '' ]
]

{ #category : #accessing }
AContractReportModel >> day: anObject [
	day := anObject.
	self changed: #day
]

{ #category : #accessing }
AContractReportModel >> firstName [
	^ ''
]

{ #category : #initialization }
AContractReportModel >> initializeSelection: anAnnouncer [
	anAnnouncer
		when: MorphTreeSelectionChanged
		do: [ :a | (a selection lastSelectedNode) ifNotNil: [ :n|
								self accountEditor updateEditor: n item ] ].
]

{ #category : #accessing }
AContractReportModel >> itemsList [
	itemsList := FMorphTreeModel new.
	
	self initializeSelection: itemsList announcer. 
	
	itemsList columnLabel: 'Count' translated selector: #amount morph: [:v :c|
		c startWidth: 50.
		v asString asMorph ].
	
	itemsList
		columnLabel: 'Goodies' translated
		selector: #yourself
		morph: [ :v :c | 
			| col |
			c startWidth: 300.
			col := v asOrderedCollection.
			(col isEmpty
				ifFalse: [ col inject: '' into: [ :sum :el| sum, el asString, ' ' ]  ]
				ifTrue: [ '' ]) asMorph ].
			
	itemsList rootItems: self report amounts.
	^ itemsList
]

{ #category : #actions }
AContractReportModel >> makeReport [
	| q c t |
	t := Time
		millisecondsToRun: [
			q := self queryContract.
			c := self accounts select: q.
			"q := self queryInvoice.
			i := self accounts select: q.
			q := self queryPayment.
			p := self accounts select: q.
			c
				addAccount: i;
				addAccount: p."
			c removeEmptyAmounts ].
		report := c .
	self
		trace:
			'A contract report is created. Milliseconds to run: ' , t asString
				, String cr.
	self changed: #itemsList with: self.
	^ c
]

{ #category : #accessing }
AContractReportModel >> month [
	^ month ifNil: [ month := '' ]
]

{ #category : #accessing }
AContractReportModel >> month: anObject [
	month := anObject.
	self changed: #month
]

{ #category : #rendering }
AContractReportModel >> morphController [
	^ FDirectController new
]

{ #category : #rendering }
AContractReportModel >> morphRenderer [
	^ AContractReportMorphRenderer new
]

{ #category : #rendering }
AContractReportModel >> morphView [
	^ self morphController
			listen: #yourself from: self.
]

{ #category : #rendering }
AContractReportModel >> morphViewInWindow [
	| m w |
	m := self morphView.
	w := StandardWindow new.
	w title: ('Contract Report' translated).
	w addMorph: m frame: LayoutFrame new.
	w open.
	^ m
]

{ #category : #accessing }
AContractReportModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
AContractReportModel >> organization: anObject [
	organization := anObject.
	self changed: #organization.
]

{ #category : #actions }
AContractReportModel >> queryContract [
	| query |
	query := Set new.
	(self organization = '') ifFalse: [ query add: self organization ].
	(self contractNumber = '') ifFalse: [ query add: self numberPrefix, self contractNumber ].
	(self additionalContractNumber = '') ifFalse: [ query add: self additionalNumberPrefix, self additionalContractNumber ].
	(self year = '') ifFalse: [ query add: self yearPrefix, self year ].
	(self month = '') ifFalse: [ query add: self monthPrefix, self month ].
	(self day = '') ifFalse: [query add: self dayPrefix, self day ].
	^ query.
]

{ #category : #actions }
AContractReportModel >> queryInvoice [
	| query |
	query := Set new.
	query add: self organization.
	query add: self invoiceName.
	(self contractNumber = '') ifFalse: [ query add: self numberPrefix, self contractNumber ].
	(self additionalContractNumber = '')
		ifFalse: [ query add: self additionalNumberPrefix, self additionalContractNumber ].
	(self year = '') ifFalse: [ query add: self yearPrefix, self year ].
	(self month = '') ifFalse: [ query add: self monthPrefix, self month ].
	(self day = '') ifFalse: [query add: self dayPrefix, self day ].
	^ query.
]

{ #category : #actions }
AContractReportModel >> queryPayment [
	| query |
	query := Set new.
	query add: self organization.
	query add: self paymentName.
	(self contractNumber = '') ifFalse: [ query add: self numberPrefix, self contractNumber ].
	(self additionalContractNumber = '')
		ifFalse: [ query add: self additionalNumberPrefix, self additionalContractNumber ].
	(self year = '') ifFalse: [ query add: self yearPrefix, self year ].
	(self month = '') ifFalse: [ query add: self monthPrefix, self month ].
	(self day = '') ifFalse: [query add: self dayPrefix, self day ].
	^ query.
]

{ #category : #accessing }
AContractReportModel >> report [
	^ report ifNil: [ report := AAccount new ]
]

{ #category : #accessing }
AContractReportModel >> report: anObject [
	report := anObject
]

{ #category : #accessing }
AContractReportModel >> secondName [
	^ 'Report' translated
]

{ #category : #accessing }
AContractReportModel >> selectedItem [
	^ selectedItem ifNil: [ selectedItem := '' ]
]

{ #category : #accessing }
AContractReportModel >> selectedItem: anObject [
	selectedItem := anObject.
	self changed: #selectedItem
]

{ #category : #accessing }
AContractReportModel >> year [
	^ year ifNil: [ year := '' ]
]

{ #category : #accessing }
AContractReportModel >> year: anObject [
	year := anObject.
	self changed: #year
]
