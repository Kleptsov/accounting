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
		'accountEditor'
	],
	#category : #'Accounting-Model'
}

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
AContractModel >> asCSV [
	| writeStream |
	writeStream := WriteStream on: ''.
	items do: [ :acc|
		writeStream nextPutAll: '"',acc amount	
	]
]

{ #category : #accessing }
AContractModel >> barcode [
	^ barcode ifNil: [ barcode := '' ]
]

{ #category : #accessing }
AContractModel >> barcode: anObject [
	barcode := anObject.
	self updateAccountItems.
	self changed: #barcode.
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
"	| builder |
	builder := AVirtualSwapBuilder new.
	builder first addAll: self createFirsts.
	builder second addAll: self createSeconds.
	builder right add: self contractName.
	builder left add: self contractObligationName.
	builder common addAll: { self numberPrefix, number.}.
	(self additionalNumber = '') ifFalse: [ 
		builder common addAll: { self additionalNumberPrefix, self additionalNumber } ].
	builder swaps: self items.
	^ builder build."
]

{ #category : #actions }
AContractModel >> createContractorAccount [
	| a d addNumber |
	a := AAccount new.
	a add: self numberPrefix, self number.
	a add: self contractor.
	addNumber := self additionalNumber = '' ifTrue: [ '0' ] ifFalse: [ self additionalNumber ].
	a add: AConfig additionalNumberPrefix, addNumber.
	d := self convertDate.
	a add: (self yearPrefix, d year asString).
	a add: (self monthPrefix, d monthIndex asString).
	a add: (self dayPrefix, d dayOfMonth asString).
	self items amounts do: [ :el| a addAmount: (el swapAmount clone) ].
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
	inv organization: self organization.
	inv contractor: self contractor.
	inv contractNumber: self number.
	inv items addAccount: self items.
	^ inv
]

{ #category : #actions }
AContractModel >> createOrganizationAccount [
	| a d addNumber |
	a := AAccount new.
	a add: self organization.
	addNumber := self additionalNumber = '' ifTrue: [ '0' ] ifFalse: [ self additionalNumber ].
	a add: AConfig additionalNumberPrefix, addNumber.
	d := self convertDate.
	a add: (self yearPrefix, d year asString).
	a add: (self monthPrefix, d monthIndex asString).
	a add: (self dayPrefix, d dayOfMonth asString).
	self items amounts do: [ :el| a addAmount: el asAmount clone].
	^ a.
]

{ #category : #actions }
AContractModel >> createPayment [
	| p sum |
	p := APaymentModel addNew.
	p organization: self organization.
	p contractor: self contractor.
	p contractNumber: self number.
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
AContractModel >> date [
	^ date ifNil: [ date := self today ]
]

{ #category : #accessing }
AContractModel >> date: anObject [
	date := anObject.
	self changed: #date.
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
AContractModel >> items [
	^ items ifNil: [ items := AAccount new ]
]

{ #category : #accessing }
AContractModel >> items: someItems [
	items := someItems.
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

{ #category : #actions }
AContractModel >> removeAccounts [
	| "acc" "acc2" |
	
	AConfig accounts diffAll: self savedAccounts.
	self savedAccounts removeAll.
	
	"acc := AAccount new.
	acc add: self numberPrefix, self number.
	acc add: self contractName.
	(self additionalNumber = '') ifTrue: [ self additionalNumber: '0' ].
	acc add: self additionalNumberPrefix, self additionalNumber.
	self accounts remove: acc."
	
	
	"acc2 := AAccount new.
	acc2 add: self numberPrefix, self number.
	acc2 add: self contractObligationName.
	(self additionalNumber = '')
		ifFalse: [ acc2 add: self additionalNumberPrefix, self additionalNumber ].
	self accounts remove: acc2."
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
]
