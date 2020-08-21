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
		'acceptedAccounts'
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

{ #category : #accessing }
AModel >> additional [
	^ additional ifNil: [ additional := '' ]
]

{ #category : #accessing }
AModel >> additional: anObject [
	additional := anObject
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
