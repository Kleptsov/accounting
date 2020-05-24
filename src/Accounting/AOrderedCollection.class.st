Class {
	#name : #AOrderedCollection,
	#superclass : #OrderedCollection,
	#category : #'Accounting-Core'
}

{ #category : #printing }
AOrderedCollection >> asString [
	^ self printString
]

{ #category : #printing }
AOrderedCollection >> printOn: aStream [
	self do: [ :el|
		aStream nextPutAll: ' '.
		aStream nextPutAll: el asString ].
]

{ #category : #printing }
AOrderedCollection >> printString [
	| stream |
	stream := WriteStream on: ''.
	self printOn: stream.
	^ stream contents.
]
