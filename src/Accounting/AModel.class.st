"
Абстрактная модель содержащая общие методы

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AModel,
	#superclass : #Object,
	#instVars : [
		'additional',
		'accepted',
		'answer',
		'process',
		'savedAccounts'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
AModel class >> MorphViewInWindow [
	^ self addNew morphViewInWindow
]

{ #category : #adding }
AModel class >> addNew [
	| n |
	n := self new.
	n number: self nextIndex asString.
	self documents add: n.
	^ n.
]

{ #category : #accessing }
AModel class >> anyOrganization [
	^ self configClass anyOrganization.
]

{ #category : #accessing }
AModel class >> configClass [
	^ AConfig
]

{ #category : #adding }
AModel class >> current [
	^ self documents.
]

{ #category : #adding }
AModel class >> documents [
	self subclassResponsibility.
]

{ #category : #adding }
AModel class >> morphViewInWindow [
	^ self addNew morphViewInWindow
]

{ #category : #adding }
AModel class >> nextIndex [
	self subclassResponsibility
]

{ #category : #adding }
AModel class >> openNew [
	| n |
	n := self addNew.
	n open.
	^ n.
]

{ #category : #adding }
AModel class >> remove: aDocument [
	self documents remove: aDocument ifAbsent: [  ].
]

{ #category : #accessing }
AModel >> accItem1 [
	^ self accountEditor accItem1
]

{ #category : #accessing }
AModel >> accItem1: anObject [
	self accountEditor accItem1: anObject
]

{ #category : #accessing }
AModel >> accItem2 [
	^ self accountEditor accItem2.
]

{ #category : #accessing }
AModel >> accItem2: anObject [
	self accountEditor accItem2: anObject
]

{ #category : #actions }
AModel >> accept [
	self subclassResponsibility.
]

{ #category : #actions }
AModel >> accepted [
	^ accepted ifNil: [ accepted = false ].
]

{ #category : #actions }
AModel >> accepted: anObject [
	accepted := anObject.
	accepted 	ifTrue: [ self accept ] ifFalse: [ self cancelAccepted ].
	self changed: #accepted.
]

{ #category : #configuration }
AModel >> accounts [
	^ self configClass accounts
]

{ #category : #actions }
AModel >> addBarcode [
	| acc am accEditor |
	acc := AAccount new add: self barcode; yourself.
	AConfig barcodes delete: acc.
	am := AAmount new.
	accEditor := self accountEditor.
	accEditor accItem1 = '' ifFalse: [ am add: accEditor accItem1 ].
	accEditor accItem2 = '' ifFalse: [ am add: accEditor accItem2 ].
	accEditor accItem3 = '' ifFalse: [ am add: accEditor accItem3 ].
	am isEmpty ifTrue: [ ^ self ].
	acc addAmount: am.
	AConfig barcodes add: acc
]

{ #category : #accessing }
AModel >> additional [
	^ additional ifNil: [ additional := '' ]
]

{ #category : #accessing }
AModel >> additional: anObject [
	additional := anObject
]

{ #category : #view }
AModel >> answer: anAnswer [
	answer := anAnswer.
	process ifNotNil: [ process resume ].
]

{ #category : #actions }
AModel >> cancelAccepted [
	| res |
	res := AConfig accounts diffAll: self savedAccounts.
	self savedAccounts: {} asOrderedCollection.
	^ res.
]

{ #category : #configuration }
AModel >> configClass [
	^ self class configClass
]

{ #category : #configuration }
AModel >> contraPriceName [
	^ self configClass contraPriceName
]

{ #category : #configuration }
AModel >> contractName [
	^ self configClass contractName
]

{ #category : #configuration }
AModel >> contractObligationName [
	^ self configClass contractObligationName
]

{ #category : #configuration }
AModel >> dayPrefix [
	^ self configClass dayPrefix
]

{ #category : #information }
AModel >> inform: aStringMsg [
	super inform: aStringMsg
]

{ #category : #configuration }
AModel >> invoiceName [
	^ self configClass invoiceName.
]

{ #category : #configuration }
AModel >> invoicePrefix [
	^ self configClass invoicePrefix.
]

{ #category : #configuration }
AModel >> monthPrefix [
	^ self configClass monthPrefix
]

{ #category : #configuration }
AModel >> numberPrefix [
	^ self configClass numberPrefix.
]

{ #category : #view }
AModel >> open [
	self subclassResponsibility
]

{ #category : #view }
AModel >> openModal [
	answer := nil.
	process := Processor activeProcess.
	[ self open ] fork.
	process suspend.
	^ answer.
]

{ #category : #configuration }
AModel >> paymentName [
	^ self configClass paymentName.
]

{ #category : #configuration }
AModel >> paymentPrefix [
	^ self configClass paymentPrefix.
]

{ #category : #configuration }
AModel >> priceName [
	^ self configClass priceName
]

{ #category : #configuration }
AModel >> recordingOfName [
	^ self configClass recordingOfName
]

{ #category : #configuration }
AModel >> rootSwaps [
	^ self configClass rootSwaps.
]

{ #category : #accessing }
AModel >> savedAccounts [
	^ savedAccounts ifNil: [ savedAccounts := OrderedCollection new ]
]

{ #category : #accessing }
AModel >> savedAccounts: aSavedAccounts [
	savedAccounts := aSavedAccounts
]

{ #category : #configuration }
AModel >> swapName [
	^ self configClass swapName
]

{ #category : #configuration }
AModel >> today [
	^ (Date today printFormat: #(1 2 3 $. 1 1 2) )
]

{ #category : #configuration }
AModel >> transferName [
	^ self configClass transferName.
]

{ #category : #configuration }
AModel >> transfers [
	^ self configClass transfers
]

{ #category : #actions }
AModel >> updateAccountItems [
	| resultAmount |
	resultAmount := AConfig barcodes
		select: (AAccount new add: self barcode; yourself) at: 1.
	self accountEditor updateEditor: resultAmount.
	^ resultAmount
]

{ #category : #actions }
AModel >> updateEditor: anSwap [
	self accountEditor updateEditor: anSwap.
]

{ #category : #configuration }
AModel >> writeOffName [
	^ self configClass writeOffName
]

{ #category : #configuration }
AModel >> writeOffs [
	^ self configClass writeOffs
]

{ #category : #configuration }
AModel >> yearPrefix [
	^ self configClass yearPrefix
]
