"
Абстрактый класс AbstractAccount предназначен для хранения методов оптимизированных для Account

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AbstractAccount,
	#superclass : #Set,
	#instVars : [
		'hash',
		'symbolHash'
	],
	#category : #'Accounting-Core'
}

{ #category : #comparing }
AbstractAccount >> = anAccount [
	^ self symbolHash = anAccount symbolHash
]

{ #category : #'adding & removing' }
AbstractAccount >> add: anObject [
	super add: anObject asString.
	self updateHash.
]

{ #category : #'adding & removing' }
AbstractAccount >> addAll: aCollection [
	aCollection do: [ :el|
		super add: el asString ].
	self updateHash.
	^ aCollection.
]

{ #category : #comparing }
AbstractAccount >> symbolHash [
	^ symbolHash ifNil: [ self updateHash. symbolHash ].
]

{ #category : #comparing }
AbstractAccount >> updateHash [
	|s|
	s := WriteStream on: '' .
	self asOrderedCollection sort do: [ :el|
		s nextPutAll: '==>'; nextPutAll: el asString.
	].
	symbolHash := s contents asSymbol.
]
