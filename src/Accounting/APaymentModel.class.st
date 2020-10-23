"
Модель платежки

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	contractNumber:		<Object>
	contractor:		<Object>
	currencyName:		<Object>
	date:		<Object>
	number:		<Object>
	organization:		<Object>
	receiptName:		<Object>
	sum:		<Object>


    Implementation Points
"
Class {
	#name : #APaymentModel,
	#superclass : #AModel,
	#instVars : [
		'number',
		'contractNumber',
		'receiptName',
		'currencyName',
		'sum',
		'date',
		'organization',
		'contractor'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
APaymentModel class >> baseTitle [
	^ 'Payment' translated
]

{ #category : #adding }
APaymentModel class >> documents [
	^ self configClass payments2
]

{ #category : #adding }
APaymentModel class >> nextIndex [
	^ self configClass nextPaymentIndex2 asString
]

{ #category : #actions }
APaymentModel >> accept [
	| s t |
	t := Time millisecondsToRun: 
	[self cancelAccepted.
	s := self buildSwap.
	self accounts addAll: s.
	self savedAccounts: s].
	self log: self number asString, ' payment is saved. Milliseconds to run: ', t asString, String cr.
	^ s.
]

{ #category : #actions }
APaymentModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
]

{ #category : #actions }
APaymentModel >> addAccount2: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self contractor: (anArray at: 1).
]

{ #category : #actions }
APaymentModel >> buildSwap [
	| s |
	s := ASwapBuilder new.
	s common add: self numberPrefix, self contractNumber.
	s common add: self paymentPrefix, self number.
	s common add: self paymentName.
	s common addAll:(ADateTagsBuilder new date: self date) build.
	s first add: self organization.
	s second add: self contractor.
	s firstAmounts add: self firstAmount.
	s secondAmounts add: self secondAmount.
	^ s build.
	
]

{ #category : #accessing }
APaymentModel >> contractNumber [
	^ contractNumber ifNil: [ contractNumber := '' ]
]

{ #category : #accessing }
APaymentModel >> contractNumber: anObject [
	contractNumber := anObject.
	self changed: #contractNumber.
]

{ #category : #accessing }
APaymentModel >> contractor [
	^ contractor ifNil: [ contractor := '' ]
]

{ #category : #accessing }
APaymentModel >> contractor: anObject [
	contractor := anObject.
	self changed: #contractor.
]

{ #category : #accessing }
APaymentModel >> currencyName [
	^ currencyName ifNil: [ currencyName := '' ]
]

{ #category : #accessing }
APaymentModel >> currencyName: anObject [
	currencyName := anObject.
	self changed: #currencyName.
]

{ #category : #accessing }
APaymentModel >> date [
	^ date ifNil: [ date := '' ]
]

{ #category : #accessing }
APaymentModel >> date: anObject [
	date := anObject.
	self changed: #date.
]

{ #category : #actions }
APaymentModel >> firstAmount [
	^ AAmount new
			amount: sum asNumber;
			add: self receiptName;
			yourself
]

{ #category : #accessing }
APaymentModel >> firstName [
	^ self number, ' - ', self contractNumber
]

{ #category : #rendering }
APaymentModel >> morphController [
	^ FDirectController new
]

{ #category : #rendering }
APaymentModel >> morphRenderer [
	^ APaymentMorphRenderer new.
]

{ #category : #rendering }
APaymentModel >> morphView [
	^ self changed: #yourself with: self
]

{ #category : #rendering }
APaymentModel >> morphViewInWindow [
	| m w |
	m := self morphView.
	w := StandardWindow new.
	w title: (self number, '-', self organization, ' - ', self contractor, ' ', 'Payment' translated).
	w addMorph: m frame: LayoutFrame new.
	w open.
	^ m
	
]

{ #category : #accessing }
APaymentModel >> number [
	^ number ifNil: [ number := '' ]
]

{ #category : #accessing }
APaymentModel >> number: anObject [
	number := anObject.
	self changed: #number.
]

{ #category : #actions }
APaymentModel >> open [
	^ APaymentGlamour openOn: self
]

{ #category : #accessing }
APaymentModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
APaymentModel >> organization: anObject [
	organization := anObject.
	self changed: #organization.
]

{ #category : #accessing }
APaymentModel >> receiptName [
	^ receiptName ifNil: [ receiptName := '' ]
]

{ #category : #accessing }
APaymentModel >> receiptName: anObject [
	receiptName := anObject.
	self changed: #receiptName.
]

{ #category : #actions }
APaymentModel >> secondAmount [
	^ AAmount new
			amount: sum asNumber;
			add: self currencyName;
			yourself.
]

{ #category : #accessing }
APaymentModel >> secondName [
	^ self contractor, ' - ', self organization.
]

{ #category : #accessing }
APaymentModel >> sum [
	^ sum ifNil: [ sum := '' ]
]

{ #category : #accessing }
APaymentModel >> sum: anObject [
	sum := anObject.
	self changed: #sum
]
