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
		'savedAccounts',
		'title',
		'announcer'
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

{ #category : #accessing }
AModel >> additional [
	^ additional ifNil: [ additional := '' ]
]

{ #category : #accessing }
AModel >> additional: anObject [
	additional := anObject
]

{ #category : #accessing }
AModel >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
AModel >> announcer: anObject [
	announcer := anObject
]

{ #category : #accessing }
AModel >> answer [
	^ answer ifNil: [ answer := [ :v| ] ].
]

{ #category : #accessing }
AModel >> answer: anObject [
	answer := anObject
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

{ #category : #actions }
AModel >> delete [
	self accepted: false.
	self class documents remove: self ifAbsent: [  ].
]

{ #category : #accessing }
AModel >> description [
	^ 'Description'
]

{ #category : #accessing }
AModel >> firstName [
	^ ''
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
AModel >> menu [
	^ nil
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

{ #category : #accessing }
AModel >> rootNodeClassFromItem: anItem [
	^ ADocumentNodeModel
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

{ #category : #accessing }
AModel >> secondName [
	^ ''
]

{ #category : #configuration }
AModel >> swapName [
	^ self configClass swapName
]

{ #category : #accessing }
AModel >> title [
	^ title ifNil: [ title := 'Document' ]
]

{ #category : #accessing }
AModel >> title: anObject [
	title := anObject
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
