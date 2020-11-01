"
Содержит все действия со счетами и также их кеш

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AAccountsStore,
	#superclass : #Object,
	#instVars : [
		'accIndexes'
	],
	#category : #'Accounting-Core'
}

{ #category : #accessing }
AAccountsStore >> accIndexes [
	^ accIndexes
]

{ #category : #accessing }
AAccountsStore >> accIndexes: anObject [
	accIndexes := anObject
]

{ #category : #'adding/removing' }
AAccountsStore >> add: anAccount [
	"добавить счет вместе со значением"
	TimeProfiler onBlock: [
	self addAccIndexes: anAccount].
]

{ #category : #'adding/removing' }
AAccountsStore >> addAccIndexes: anAccount [
	| accounts |
	accounts := anAccount indexes.
	accounts do: [ :a|
		(accIndexes like: a)
			ifNil: [ accIndexes add: a clone ]
			ifNotNil: [ :account| account addAccount: a.
				accIndexes isExternal ifTrue: [ 
								EIContextInstance value saveObject: account. ]  ]	
	]
]

{ #category : #'adding/removing' }
AAccountsStore >> addAll: anAccounts [
	"добавить счет вместе со значением"
	anAccounts do: [ :acc| self add: acc ].
]

{ #category : #'adding/removing' }
AAccountsStore >> delete: anAccount [
	^ self accIndexes remove: anAccount ifAbsent: [ nil ].
]

{ #category : #'adding/removing' }
AAccountsStore >> difAccIndexes: anAccount [
	| accounts |
	accounts := anAccount indexes.
	accounts do: [ :a|
		(accIndexes like: a)
			ifNil: [ accIndexes add: a clone invertAmounts ]
			ifNotNil: [ :account| account difAccount: a  ]	
	]
]

{ #category : #'adding/removing' }
AAccountsStore >> diffAll: anAccounts [
	"добавить счет вместе со значением"
	^ anAccounts collect: [ :acc| self difference: acc ].
]

{ #category : #'adding/removing' }
AAccountsStore >> difference: anAccount [
	| account accounts |
	account := (self select: anAccount) clone invert.
	accounts := account indexes.
	accounts do: [ :a|
		(accIndexes like: a)
			ifNil: [ accIndexes add: a clone ]
			ifNotNil: [ :acc| acc addAccount: a.
							accIndexes isExternal ifTrue: [ 
								EIContextInstance value saveObject: acc. ]  ]	].
	^ account
]

{ #category : #initialization }
AAccountsStore >> initialize [
	super initialize.
	accIndexes := Set new.
]

{ #category : #initialization }
AAccountsStore >> initializeExtraImage [
	accIndexes := EISet new.
]

{ #category : #'adding/removing' }
AAccountsStore >> removeEmptyAmounts [
	| rem |
	accIndexes do: [ :acc|
		rem := acc amounts select: [ :am| am amount = 0 or: [ am amount < 0.00001 and: [ am amount > -0.00001 ] ] ].
		rem do: [ :el| acc amounts remove: el ifAbsent: [  ] ] ]
]

{ #category : #enumerating }
AAccountsStore >> select: aTags [
	| acc |
	TimeProfiler onBlock: [
	acc := AAccount new addAll: aTags; yourself.
	^ (accIndexes like: acc)
			ifNil: [ AAccount new ]
			ifNotNil: [ :account| account clone ]]
]

{ #category : #enumerating }
AAccountsStore >> select: anAccount at: anIndex [
	| account amounts|
	account := self select: anAccount.
	amounts := account amounts asOrderedCollection.
	amounts size < anIndex
		ifFalse: [ ^ amounts at: anIndex ]
		ifTrue: [ ^ AAmount new ]
]
