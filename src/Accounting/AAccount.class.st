"
Счет. Содержит теги счета и величины.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	amounts:		<Object>


    Implementation Points
"
Class {
	#name : #AAccount,
	#superclass : #ACacheTags,
	#instVars : [
		'amounts'
	],
	#category : #'Accounting-Core'
}

{ #category : #'instance creation' }
AAccount class >> empty [
	^ self new
			add: self configClass emptyAccountName;
			yourself.
]

{ #category : #operations }
AAccount >> addAccount: anAccount [
	anAccount amounts do: [ :am|
		(amounts like: am)
			ifNil: [ amounts add: (am clone unixTime: am unixTime) ]
			ifNotNil: [ :amount| amount addAmount: am ] ]
]

{ #category : #operations }
AAccount >> addAmount: anAmount [
	|a|
	a := amounts like: anAmount.
	a
		ifNil: [ amounts add: anAmount clone ]
		ifNotNil: [ a addAmount: anAmount  ]
]

{ #category : #operations }
AAccount >> addAmounts: someAmounts [
	someAmounts do: [ :am|
		self addAmount: am	
	]
]

{ #category : #copying }
AAccount >> allAccounts [
	| accounts |
	accounts := self allTags collect: [ :el|
		self class new
			addAll: el;
			yourself	
	].
	^ accounts
]

{ #category : #accessing }
AAccount >> amounts [
	^ amounts
]

{ #category : #accessing }
AAccount >> amounts: anObject [
	amounts := anObject
]

{ #category : #copying }
AAccount >> asAmounts [
	| acc |
	acc := AAccount new.
	self amounts do: [ :a|
		acc addAmount: a asAmount].
	^ acc
]

{ #category : #converting }
AAccount >> asSwap [
	| sw am ams |
	sw := ASwap new.
	sw addAll: self.
	ams := (self amounts asOrderedCollection).
	ams ifNotEmpty: [ am := ams first.
		sw swapAmount addAll: am ].
	^ sw.
]

{ #category : #copying }
AAccount >> clone [
	| instance |
	instance := self class new.
	instance addAll: self.
	instance amounts addAll: ( self amounts collect: [ :el| el clone ] ).
	instance update.
	^ instance
]

{ #category : #copying }
AAccount >> cloneAmounts: someAmounts [
	amounts removeAll.
	amounts addAll: ( someAmounts collect: [ :el| el clone ] ).
]

{ #category : #copying }
AAccount >> copyToClipboard [
	Clipboard clipboardText: self printCSV
]

{ #category : #operations }
AAccount >> difAccount: anAccount [
	anAccount amounts do: [ :am|
		(amounts like: am)
			ifNil: [ amounts add: am clone invert]
			ifNotNil: [ :amount| amount difAmount: am ] ]
]

{ #category : #operations }
AAccount >> difAmount: anAmount [
	|a|
	a := amounts like: anAmount.
	a
		ifNil: [ amounts add: anAmount clone invert ]
		ifNotNil: [ a difAmount: anAmount  ]
]

{ #category : #operations }
AAccount >> downAmount: anAmount [
	| amountAtCollection |
	anAmount ifNil: [ ^ self ].
	amountAtCollection := nil.
	self sortByPostTime do: [ :el|
		amountAtCollection ifNotNil: [
			amountAtCollection swapTimeFrom: el.
			amountAtCollection := nil ].
		el = anAmount ifTrue: [amountAtCollection := el].
	]
]

{ #category : #copying }
AAccount >> indexes [
	| accounts |
	accounts := self allTags collect: [ :el|
		self class new
			addAll: el;
			cloneAmounts: self amounts;
			yourself	
	].
	^ accounts
]

{ #category : #initialization }
AAccount >> initialize [
	super initialize.
	amounts := Set new.
]

{ #category : #initialization }
AAccount >> initialize: n [
	super initialize: n.
	self initialize.
]

{ #category : #operations }
AAccount >> invert [
	self amounts do: [ :el|
		el invert ]
]

{ #category : #copying }
AAccount >> invertAmounts [
	^ amounts collect: [ :a| a clone invert ]
]

{ #category : #printing }
AAccount >> printCSV [
	| stream |
	stream := WriteStream on: ''.
	self printCSVOn: stream.
	^ stream contents.
]

{ #category : #printing }
AAccount >> printCSVOn: aStream [
	| size |
	size := self amounts size.
	self amounts do: [ :el|
		size := size - 1.
		el printCSVOn: aStream.
		size = 0 ifFalse: [ aStream nextPutAll: String cr. ] ]
]

{ #category : #printing }
AAccount >> printOn: aStream [
	aStream nextPutAll: 'Account:'.
	self do: [ :t|
		aStream nextPutAll: ' '.
		aStream nextPutAll: t ].
	aStream nextPutAll: ' ('.
	amounts do: [ :am|
		aStream nextPutAll: ' '.
		am printOn: aStream. ].
	aStream nextPutAll: ' )'.
]

{ #category : #operations }
AAccount >> removeAmount: anAmount [
	amounts remove: anAmount ifAbsent: [  ]
]

{ #category : #operations }
AAccount >> removeEmptyAmounts [
	| emptyAmounts |
	emptyAmounts := amounts select: [:a|
		a amount = 0	 or: [ a amount < 0.0001 and: [ a amount > -0.0001 ] ] ].
	emptyAmounts do: [ :a| amounts remove: a ].
]

{ #category : #enumerating }
AAccount >> sort: aBlock [
	^ self amounts asOrderedCollection sort: aBlock
]

{ #category : #enumerating }
AAccount >> sortByPostTime [
	^ self sort: [ :el :el2| el unixTime > el2 unixTime ]
]

{ #category : #operations }
AAccount >> upAmount: anAmount [
	| previous |
	previous := nil.
	self sortByPostTime do: [ :el|
		(previous notNil and: [el = anAmount])
			ifTrue: [ previous swapTimeFrom: el ].
		previous := el.
	]
]

{ #category : #operations }
AAccount >> updateOrAddAmount: anAmount [
	|a t |
	a := amounts like: anAmount.
	a
		ifNil: [ amounts add: anAmount clone ]
		ifNotNil: [ t := a unixTime.
						self removeAmount: a.
						anAmount unixTime: t.
						amounts add: anAmount ]
]
