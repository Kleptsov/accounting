"
Этот класс реализует хранение суммированных и индексированных счетов и также отмена.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	accumulator:		<Object>


    Implementation Points
"
Class {
	#name : #Accounts,
	#superclass : #Object,
	#instVars : [
		'accumulator',
		'keys',
		'mutex'
	],
	#category : #'Accounting-Core'
}

{ #category : #accessing }
Accounts >> accumulator [
	^ accumulator ifNil: [ accumulator := Set new ]
]

{ #category : #oparations }
Accounts >> add: anAccount [
	| indexes |
	indexes := anAccount allAccountVariants.
	indexes do: [ :el|
		self mutex critical: [ 
			(self accumulator like: el)
				ifNil: [ accumulator add: el clone ]
				ifNotNil: [ :acc| acc addAccount: el ] ] ]
]

{ #category : #oparations }
Accounts >> add: anAccount key: aKey [
	self add: anAccount.
	self mutex critical: [
		self keys at: aKey put: anAccount clone ].
]

{ #category : #oparations }
Accounts >> addOne: anAccount [
	self mutex critical: [
		(self accumulator like: anAccount)
			ifNil: [ accumulator add: anAccount clone ]
			ifNotNil: [ :acc| acc addAccount: anAccount ] ]
]

{ #category : #oparations }
Accounts >> dif: anAccount [
	| indexes |
	indexes := anAccount allAccountVariants.
	indexes do: [ :el|
		self mutex critical: [ 
		(self accumulator like: el)
			ifNil: [ accumulator add: el clone invertItems ]
			ifNotNil: [ :acc| acc difAccount: el ] ] ]
]

{ #category : #oparations }
Accounts >> difKey: aKey [
	| acc |
	acc := self keys at: aKey ifAbsent: [ Account new ].
	self dif: acc.
]

{ #category : #accessing }
Accounts >> keys [
	^ keys ifNil: [ keys := IdentityDictionary new ].
]

{ #category : #accessing }
Accounts >> mutex [
	^ mutex ifNil: [ mutex := Mutex new ]
]
