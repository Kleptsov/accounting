"
Модель контракта

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	contractor:		<Object>
	date:		<Object>
	editor:		<Object>
	items:		<Object>
	number:		<Object>
	organization:		<Object>


    Implementation Points
"
Class {
	#name : #AContractModel,
	#superclass : #AModel,
	#instVars : [
		'number',
		'additionalNumber',
		'organization',
		'contractor',
		'date',
		'editor',
		'items',
		'strongSelection',
		'accountEditor',
		'itemsList',
		'currencyName',
		'receiptName'
	],
	#category : #'Accounting-Model'
}

{ #category : #'as yet unclassified' }
AContractModel class >> baseTitle [
	^ 'Contract' translated.
]

{ #category : #adding }
AContractModel class >> documents [
	^ self configClass contracts2
]

{ #category : #adding }
AContractModel class >> nextIndex [
	^ self configClass nextContractIndex2 asString
]

{ #category : #actions }
AContractModel >> accept [
	| accs t |
	t := Time
		millisecondsToRun: [ self cancelAccepted.
			accs := self createAccounts.
			self accounts addAll: accs.
			self savedAccounts: accs ].
	self
		trace:
			self number asString , '-' , self additionalNumber
				, ' contract is saved. Milliseconds to run: ' , t asString
				, String cr.
	^ accs
]

{ #category : #accessing }
AContractModel >> accountEditor [
	^ accountEditor ifNil: [ accountEditor := AAccountEditor new ]
]

{ #category : #accessing }
AContractModel >> accountEditor: anAccountEditor [
	accountEditor := anAccountEditor
]

{ #category : #actions }
AContractModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
]

{ #category : #actions }
AContractModel >> addAccount2: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self contractor: (anArray at: 1).
]

{ #category : #accessing }
AContractModel >> additionalNumber [
	^ additionalNumber ifNil: [ additionalNumber := '' ]
]

{ #category : #accessing }
AContractModel >> additionalNumber: anObject [
	additionalNumber := anObject.
	self changed: #additionalNumber.
]

{ #category : #accessing }
AContractModel >> additionalNumberPrefix [
	^ AConfig additionalNumberPrefix.
]

{ #category : #actions }
AContractModel >> allChanging [
	| coll c c2 c3 report |
	coll := OrderedCollection new.
	c := AConfig contracts2 select: [ :el| el number = self number ].
	coll addAll: c.
	c2 := AConfig invoices2 select: [ :el| el contractNumber = self number ].
	coll addAll: c2.
	c3 := AConfig payments2 select: [ :el| el contractNumber = self number ].
	coll addAll: c3.
	report := AContractReportModel new
		contractNumber: self number;
		organization: self organization;
		makeReport;
		yourself.
	coll add: report.
	^ coll.
]

{ #category : #actions }
AContractModel >> asCSV [
	| writeStream |
	writeStream := WriteStream on: ''.
	items do: [ :acc|
		writeStream nextPutAll: '"',acc amount	
	]
]

{ #category : #accessing }
AContractModel >> contractor [
	^ contractor ifNil: [ contractor := '' ]
]

{ #category : #accessing }
AContractModel >> contractor: anObject [
	contractor := anObject.
	self changed: #contractor
]

{ #category : #actions }
AContractModel >> convertDate [
	^ (DateParser readingFrom: (ReadStream on: self date) pattern: 'd.mm.yyyy') parse
]

{ #category : #actions }
AContractModel >> createAccounts [
	| org contr |
	org := self createOrganizationAccount.
	contr := self createContractorAccount.
	^ { org. contr }.
]

{ #category : #actions }
AContractModel >> createAndOpenInvoice [
	| inv |
	inv := self createInvoice.
	inv morphViewInWindow.
	^ inv
]

{ #category : #actions }
AContractModel >> createAndOpenPayment [
	| p |
	p := self createPayment.
	p morphViewInWindow.
	^ p.
]

{ #category : #actions }
AContractModel >> createContractorAccount [
	| a d addNumber |
	a := AAccount new.
	a add: self numberPrefix, self number.
	a add: self contractName.
	a add: self contractor.
	addNumber := self additionalNumber = '' ifTrue: [ '0' ] ifFalse: [ self additionalNumber ].
	a add: AConfig additionalNumberPrefix, addNumber.
	d := self convertDate.
	a add: (self yearPrefix, d year asString).
	a add: (self monthPrefix, d monthIndex asString).
	a add: (self dayPrefix, d dayOfMonth asString).
	self items amounts do: [ :el| a difAmount: (el swapAmount clone) ].
	^ a.
]

{ #category : #actions }
AContractModel >> createDatesFor: aAccount [
	| d |
	d := self convertDate.
	d add: (self yearPrefix, d year asString).
	d add: (self monthPrefix, d monthIndex asString).
	d add: (self dayPrefix, d dayOfMonth asString).
]

{ #category : #actions }
AContractModel >> createFirsts [
	|firsts d|
	d := self convertDate.
	firsts := Set new.
	firsts add: organization.
	firsts add: (self yearPrefix, d year asString).
	firsts add: (self monthPrefix, d monthIndex asString).
	firsts add: (self dayPrefix, d dayOfMonth asString).
	^ firsts.
]

{ #category : #actions }
AContractModel >> createInvoice [
	| inv |
	inv := AInvoiceModel addNew.
	inv
		organization: self organization;
		contractor: self contractor;
		contractNumber: self number;
		receiptName: self receiptName;
	currencyName: self currencyName.
	inv items addAccount: self items.
	inv changeReceipt.
	^ inv
]

{ #category : #actions }
AContractModel >> createOrganizationAccount [
	| a d addNumber |
	a := AAccount new.
	a add: self numberPrefix, self number.
	a add: self contractName.
	a add: self organization.
	addNumber := self additionalNumber = '' ifTrue: [ '0' ] ifFalse: [ self additionalNumber ].
	a add: AConfig additionalNumberPrefix, addNumber.
	d := self convertDate.
	a add: (self yearPrefix, d year asString).
	a add: (self monthPrefix, d monthIndex asString).
	a add: (self dayPrefix, d dayOfMonth asString).
	self items amounts do: [ :el| a difAmount: el asAmount clone].
	^ a.
]

{ #category : #actions }
AContractModel >> createPayment [
	| p sum |
	p := APaymentModel addNew.
	p organization: self organization.
	p contractor: self contractor.
	p contractNumber: self number.
	p receiptName: self receiptName.
	p currencyName: self currencyName.
	sum := self items amounts inject: 0 into: [ :s :each| s + each swapAmount amount ].
	p sum: sum asString.
	^ p
]

{ #category : #actions }
AContractModel >> createSeconds [
	|seconds d |
	d := self convertDate.
	seconds := Set new.
	seconds add: self contractor.
	seconds add: (self yearPrefix, d year asString).
	seconds add: (self monthPrefix, d monthIndex asString).
	seconds add: (self dayPrefix, d dayOfMonth asString).
	^ seconds
]

{ #category : #accessing }
AContractModel >> currencyName [
	^ currencyName ifNil: [ currencyName := '' ]
]

{ #category : #accessing }
AContractModel >> currencyName: anObject [
	currencyName := anObject.
	self changed: #currencyName with: self.
]

{ #category : #accessing }
AContractModel >> date [
	^ date ifNil: [ date := self today ]
]

{ #category : #accessing }
AContractModel >> date: anObject [
	date := anObject.
	self changed: #date.
]

{ #category : #actions }
AContractModel >> downItem [
	self items downAmount: (self accountEditor makeSwap).
	self changed: #itemsList with: self.
]

{ #category : #actions }
AContractModel >> downItem: aSwap [
	self items downAmount: aSwap.
]

{ #category : #accessing }
AContractModel >> editor [
	^ editor ifNil: [ editor := '' ]
]

{ #category : #accessing }
AContractModel >> editor: anObject [
	editor := anObject.
]

{ #category : #accessing }
AContractModel >> firstName [
	^ self number, ' - ', self additionalNumber
]

{ #category : #initialization }
AContractModel >> initialize [
	super initialize.
	self itemsList announcer
		when: MorphTreeSelectionChanged
		do: [ :a | (a selection lastSelectedNode) ifNotNil: [ :n| self accountEditor updateEditor: n item ] ]
]

{ #category : #initialization }
AContractModel >> initializeSelection: anAnnouncer [
	anAnnouncer
		when: MorphTreeSelectionChanged
		do: [ :a | (a selection lastSelectedNode) ifNotNil: [ :n|
								self accountEditor updateEditor: n item ] ].
]

{ #category : #accessing }
AContractModel >> items [
	^ items ifNil: [ items := AAccount new ]
]

{ #category : #accessing }
AContractModel >> items: someItems [
	items := someItems.
]

{ #category : #accessing }
AContractModel >> itemsList [
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
			
	itemsList
		columnLabel: 'Price' translated
		selector: #swapAmount
		morph: [ :v :c | 
			c startWidth: 50.
			v amount asString asMorph ].
		
	itemsList
		columnLabel: 'Currency' translated
		selector: #swapAmount
		morph: [ :v :c | 
			| col |
			c startWidth: 100.
			col := v asOrderedCollection.
			(col isEmpty
				ifFalse: [ col first asString ]
				ifTrue: [ '' ]) asMorph ].
			
	itemsList rootItems: self items sortByPostTime.
	^ itemsList
]

{ #category : #accessing }
AContractModel >> itemsList: anItemsList [
	itemsList := anItemsList.
	self update: #itemsList with: self.
]

{ #category : #rendering }
AContractModel >> morphController [
	^ FDirectController new
]

{ #category : #rendering }
AContractModel >> morphRenderer [
	^ AContractMorphRenderer new.
]

{ #category : #rendering }
AContractModel >> morphView [
	^ self morphController
			listen: #yourself from: self.
]

{ #category : #rendering }
AContractModel >> morphViewAllChanging [
	| m |
	m := ADocumentJournalModel on: [ self allChanging ].
	^ m morphView.
]

{ #category : #rendering }
AContractModel >> morphViewAllChangingInWindow [
	| m w |
	m := self morphViewAllChanging.
	w := StandardWindow new.
	w title: ('Contract Changing' translated).
	w addMorph: m frame: LayoutFrame new.
	w open.
	^ m	
]

{ #category : #rendering }
AContractModel >> morphViewInWindow [
	| m w |
	m := self morphView.
	w := StandardWindow new.
	w title: (self number, '-', self additionalNumber, ' ', 'Contract' translated).
	w addMorph: m frame: LayoutFrame new.
	w open.
	^ m
]

{ #category : #accessing }
AContractModel >> number [
	^ number ifNil: [ number := '' ]
]

{ #category : #accessing }
AContractModel >> number: anObject [
	number := anObject.
	self changed: #number.
]

{ #category : #actions }
AContractModel >> open [
	^ AContractGlamour openOn: self
]

{ #category : #accessing }
AContractModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
AContractModel >> organization: anObject [
	organization := anObject.
	self changed: #organization.
]

{ #category : #accessing }
AContractModel >> receiptName [
	^ receiptName ifNil: [ receiptName := '' ]
]

{ #category : #accessing }
AContractModel >> receiptName: anObject [
	receiptName := anObject.
	self changed: #receiptName with: self.
]

{ #category : #actions }
AContractModel >> removeSwapItem [
	self items amounts
			remove: (self accountEditor makeSwap) ifAbsent: [ nil ].
	self changed: #itemsList with: self.
]

{ #category : #accessing }
AContractModel >> secondName [
	^ self contractor, ' - ', self organization.
]

{ #category : #accessing }
AContractModel >> strongSelection [
	^ strongSelection
]

{ #category : #accessing }
AContractModel >> strongSelection: anObject [
	strongSelection := anObject.
	self changed: #strongSelection
]

{ #category : #actions }
AContractModel >> swapItems: anSwapAmount [
	strongSelection ifNil: [ strongSelection := anSwapAmount. ^ self ].
	strongSelection swapTimeFrom: anSwapAmount.
	strongSelection := nil.
]

{ #category : #actions }
AContractModel >> upItem [
	self items upAmount: (self accountEditor makeSwap).
	self changed: #itemsList with: self.
]

{ #category : #actions }
AContractModel >> upItem: aSwap [
	self items upAmount: aSwap.
]

{ #category : #actions }
AContractModel >> updateEditor: anSwap [
	anSwap ifNil: [ ^ self ].
	self accountEditor updateEditor: anSwap
]

{ #category : #actions }
AContractModel >> updateOrAddSwapItem [
	| sw |
	sw := self accountEditor makeSwap.
	sw ifNil: [ ^ self ].
	self items updateOrAddAmount: sw.
	self changed: #itemsList with: self.
]
