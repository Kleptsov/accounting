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
	#name : #AAccounts,
	#superclass : #Object,
	#instVars : [
		'accIndexes',
		'actIndexes'
	],
	#category : #'Accounting-Core'
}

{ #category : #accessing }
AAccounts >> accIndexes [
	^ accIndexes
]

{ #category : #accessing }
AAccounts >> accIndexes: anObject [
	accIndexes := anObject
]

{ #category : #accessing }
AAccounts >> actIndexes [
	^ actIndexes
]

{ #category : #accessing }
AAccounts >> actIndexes: anObject [
	actIndexes := anObject
]

{ #category : #'adding/removing' }
AAccounts >> add: anAccount [
	"добавить счет вместе со значением"
	self addAccIndexes: anAccount.
	self addActIndexes: anAccount.
]

{ #category : #'adding/removing' }
AAccounts >> add: anAccount keyAccount: anKeyAccount [
	"добавить счет вместе со значением"
	
	self addAccIndexes: anAccount.
	(actIndexes like: anKeyAccount)
			ifNil: [ actIndexes
							add: (anKeyAccount clone add: (anAccount clone); 	yourself) ]
			ifNotNil: [ :acc| acc amounts add: anAccount clone ]
]

{ #category : #'adding/removing' }
AAccounts >> addAccIndexes: anAccount [
	| accounts |
	accounts := anAccount indexes.
	accounts do: [ :a|
		(accIndexes like: a)
			ifNil: [ accIndexes add: a clone ]
			ifNotNil: [ :account| account addAccount: a  ]	
	]
]

{ #category : #'adding/removing' }
AAccounts >> addActIndexes: anAccount [
	| accounts acc|
	accounts := anAccount allAccounts.
	accounts do: [ :a|
		(actIndexes like: a)
			ifNil: [ 	acc := a. actIndexes add: acc. ]
			ifNotNil: [ :account| acc := account ].
		acc amounts add: anAccount.	
	]
]

{ #category : #'adding/removing' }
AAccounts >> addAll: anAccounts [
	"добавить счет вместе со значением"
	"TimeProfiler onBlock:["
	anAccounts do: [ :acc| self add: acc ]."]"
]

{ #category : #'adding/removing' }
AAccounts >> delete: anAccount [
	self actIndexes remove: anAccount ifAbsent: [ nil ].
	^ self accIndexes remove: anAccount ifAbsent: [ nil ].
]

{ #category : #'adding/removing' }
AAccounts >> difAccIndexes: anAccount [
	| accounts |
	accounts := anAccount indexes.
	accounts do: [ :a|
		(accIndexes like: a)
			ifNil: [ accIndexes add: a clone invertAmounts ]
			ifNotNil: [ :account| account difAccount: a  ]	
	]
]

{ #category : #initialization }
AAccounts >> initialize [
	super initialize.
	accIndexes := Set new.
	actIndexes := Set new.
]

{ #category : #'adding/removing' }
AAccounts >> remove: anAccount [
	(actIndexes like: anAccount) ifNotNil: [ :acc| 
		acc amounts do: [ :account|
			self difAccIndexes: account ].
		actIndexes remove: acc.
	]
]

{ #category : #'adding/removing' }
AAccounts >> removeEmptyAmounts [
	| rem |
	accIndexes do: [ :acc|
		rem := acc amounts select: [ :am| am amount = 0 or: [ am amount < 0.00001 and: [ am amount > -0.00001 ] ] ].
		rem do: [ :el| acc amounts remove: el ifAbsent: [  ] ] ]
]

{ #category : #enumerating }
AAccounts >> select: aTags [
	| acc |
	acc := AAccount new addAll: aTags; yourself.
	^ (accIndexes like: acc)
			ifNil: [ AAccount new ]
			ifNotNil: [ :account| account clone ]
]

{ #category : #enumerating }
AAccounts >> select: anAccount at: anIndex [
	| account amounts|
	account := self select: anAccount.
	amounts := account amounts asOrderedCollection.
	amounts size < anIndex
		ifFalse: [ ^ amounts at: anIndex ]
		ifTrue: [ ^ AAmount new ]
]
