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
		'isSaved',
		'additional',
		'acceptedAccounts',
		'barcode'
	],
	#category : #'Accounting-Model'
}

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
	self subclassResponsibility 
]

{ #category : #accessing }
AModel >> accItem1: anObject [
	self subclassResponsibility 
]

{ #category : #accessing }
AModel >> accItem2 [
	self subclassResponsibility 
]

{ #category : #accessing }
AModel >> accItem2: anObject [
	self subclassResponsibility 
]

{ #category : #accessing }
AModel >> acceptedAccounts [
	^ acceptedAccounts ifNil: [ acceptedAccounts := OrderedCollection new ]
]

{ #category : #accessing }
AModel >> acceptedAccounts: someAcceptedAccounts [
	acceptedAccounts := someAcceptedAccounts
]

{ #category : #configuration }
AModel >> accounts [
	^ self configClass accounts
]

{ #category : #actions }
AModel >> addBarcode [
	| acc am |
	acc := AAccount new add: self barcode; yourself.
	AConfig barcodes delete: acc.
	am := AAmount new add: self accItem1; add: self accItem2; yourself.
	acc addAmount: am.
	AConfig barcodes add: acc.
	
]

{ #category : #accessing }
AModel >> additional [
	^ additional ifNil: [ additional := '' ]
]

{ #category : #accessing }
AModel >> additional: anObject [
	additional := anObject
]

{ #category : #accessing }
AModel >> barcode [
	^ barcode ifNil: [ barcode := '' ]
]

{ #category : #accessing }
AModel >> barcode: anObject [
	barcode := anObject.
	self updateAccountItems.
	self changed: #barcode.
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

{ #category : #accessing }
AModel >> isSaved [
	^ isSaved ifNil: [ isSaved := false ]
]

{ #category : #accessing }
AModel >> isSaved: aBoolean [
	isSaved := aBoolean
]

{ #category : #configuration }
AModel >> monthPrefix [
	^ self configClass monthPrefix
]

{ #category : #configuration }
AModel >> numberPrefix [
	^ self configClass numberPrefix.
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
AModel >> stringIsSaved [
	^ self isSaved
			ifTrue: [ ^ '' ]
			ifFalse: [ ^ 'not saved' ]
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
	| tags resultAmount |
	resultAmount := AConfig barcodes
		select: (AAccount new add: self barcode; yourself) at: 1.
	tags := resultAmount asOrderedCollection.
	tags isEmpty ifFalse: [ self accItem1: tags first ].
	tags size > 1 ifTrue: [ self accItem2: tags second ].
		
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
