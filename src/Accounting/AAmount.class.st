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
		'unixTime',
		'val'
	],
	#category : #'Accounting-Core'
}

{ #category : #'instance creation' }
AAmount class >> empty [
	^ self new
			add: self configClass emptyAmountName;
			yourself.
]

{ #category : #'value operations' }
AAmount >> addAmount: anAmount [
	self initializeVal.
	self val plus: anAmount val.
	"amount := amount + anAmount amount"
]

{ #category : #'value operations' }
AAmount >> amount [
	self initializeVal.
	^ self val value.
	"^ amount"
]

{ #category : #'value operations' }
AAmount >> amount: anObject [
	self initializeVal.
	self val reset plus: anObject.
	"amount := anObject"
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
	sw addAll: self.
	^ sw
]

{ #category : #copying }
AAmount >> clone [
	| instance |
	instance := self class new.
	instance val plus: self amount.
	instance addAll: self.
	instance postTime: self postTime.
	^ instance
]

{ #category : #'value operations' }
AAmount >> difAmount: anAmount [
	self initializeVal.
	self val minus: anAmount val.
	"amount := amount - anAmount amount"
]

{ #category : #initialization }
AAmount >> initialize [
	super initialize.
	unixTime := DateAndTime now asUnixTime.
]

{ #category : #initialization }
AAmount >> initialize: n [
	super initialize: n.
	self initialize.
]

{ #category : #initialization }
AAmount >> initializeVal [
	amount
		ifNotNil: [ self val plus: amount.
						amount := nil. ]
]

{ #category : #'value operations' }
AAmount >> invert [
	self initializeVal.
	self val invert.
	"amount := amount * (-1)."
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

{ #category : #'value operations' }
AAmount >> printOn: aStream [
	aStream nextPutAll: (self val value round: 4) asString.
	self do: [ :t|
		aStream nextPutAll: ' '; nextPutAll: t ]. 
	"aStream
		nextPutAll: (amount round: 4) asString.
	self do: [ :t|
		aStream nextPutAll: ' ';
			nextPutAll: t ]."
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

{ #category : #accessing }
AAmount >> val [
	^ val ifNil: [ val := AValue new ]
]
