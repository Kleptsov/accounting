"
Модель списания товаров

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AWriteOffModel,
	#superclass : #ARecordingOfModel,
	#category : #'Accounting-Model'
}

{ #category : #adding }
AWriteOffModel class >> documents [
	^ self configClass writeOffs
]

{ #category : #adding }
AWriteOffModel class >> nextIndex [
	^ self configClass nextWriteOffIndex
]

{ #category : #actions }
AWriteOffModel >> accept [
	| amounts t |
	t := Time
		millisecondsToRun: [ self cancelAccepted.
			amounts := self createAmounts.
			self accounts add: amounts.
			self savedAccounts: { amounts } ].
	self
		trace:
			self number asString , ' write-off saved. Milliseconds to run: '
				, t asString , String cr.
	^ amounts
]

{ #category : #actions }
AWriteOffModel >> createAmounts [
	| sacc |
	sacc := AAccount new.
	sacc addAll: {self writeOffName. (self numberPrefix, self number)}.
	sacc add: self organization.
	(self account2 = '') ifFalse: [ sacc add: self account2 ].
	(self account3 = '') ifFalse: [ sacc add: self account3 ].
	sacc addAll: (ADateTagsBuilder new date: self date; build).
	sacc difAccount: self items.
	^ sacc
]

{ #category : #actions }
AWriteOffModel >> open [
	^ AWriteOffGlamour openOn: self
]
