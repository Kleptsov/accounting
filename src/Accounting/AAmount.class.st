"
Величина счета. Состоит из числа и тегов

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	amount:		<Object>


    Implementation Points
"
Class {
	#name : #AAmount,
	#superclass : #ACacheTags,
	#instVars : [
		'amount',
		'unixTime'
	],
	#category : #'Accounting-Core'
}

{ #category : #'instance creation' }
AAmount class >> empty [
	^ self new
			add: self configClass emptyAmountName;
			yourself.
]

{ #category : #operations }
AAmount >> addAmount: anAmount [
	amount := amount + anAmount amount
]

{ #category : #accessing }
AAmount >> amount [
	^ amount
]

{ #category : #accessing }
AAmount >> amount: anObject [
	amount := anObject
]

{ #category : #converting }
AAmount >> asAmount [
	^ self clone
]

{ #category : #converting }
AAmount >> asSwap [
	| sw |
	sw := ASwap new.
	sw amount: self amount.
	self do: [ :el|
		sw add: el ].
	^ sw
]

{ #category : #copying }
AAmount >> clone [
	| instance |
	instance := self class new.
	instance amount: self amount.
	instance addAll: self.
	instance postTime: self postTime.
	^ instance
]

{ #category : #operations }
AAmount >> difAmount: anAmount [
	amount := amount - anAmount amount
]

{ #category : #initialization }
AAmount >> initialize [
	super initialize.
	amount := 0.
	unixTime := DateAndTime now asUnixTime.
]

{ #category : #initialization }
AAmount >> initialize: n [
	super initialize: n.
	self initialize.
]

{ #category : #operations }
AAmount >> invert [
	amount := amount * (-1).
]

{ #category : #accessing }
AAmount >> postTime [
	^ DateAndTime fromUnixTime: self unixTime
]

{ #category : #accessing }
AAmount >> postTime: aDateAndTime [
	unixTime := aDateAndTime asUnixTime
]

{ #category : #printing }
AAmount >> printCSVOn: aStream [
	|size|
	aStream nextPutAll: self amount asString;
		nextPut: $,;
		nextPut: $".
	size := self size.
	self do: [ :tag|
		size := size - 1.
		aStream nextPutAll: tag asString.
		size = 0 ifFalse: [ aStream nextPut: Character space ]
	].
	aStream nextPut: $".
]

{ #category : #printing }
AAmount >> printOn: aStream [
	aStream
		nextPutAll: (amount round: 4) asString.
	self do: [ :t|
		aStream nextPutAll: ' ';
			nextPutAll: t ].
]

{ #category : #printing }
AAmount >> printTags [
	| stream |
	stream := WriteStream on: ''.
	self printTagsOn: stream.
	^ stream contents.
]

{ #category : #printing }
AAmount >> printTagsOn: aStream [
	| size |
	size := self size.
	self do: [ :t|
		aStream nextPutAll: t asString.
		size := size - 1.
		size = 0 ifFalse: [ aStream nextPut: Character space ] ]
]

{ #category : #operations }
AAmount >> swapTimeFrom: anAmount [
	| time |
	time := self unixTime.
	self unixTime: anAmount unixTime.
	anAmount unixTime: time.
]

{ #category : #accessing }
AAmount >> unixTime [
	^ unixTime ifNil: [ unixTime := DateAndTime now asUnixTime ]
]

{ #category : #accessing }
AAmount >> unixTime: anUnixTime [
	unixTime := anUnixTime
]
