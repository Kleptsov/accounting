Class {
	#name : #ATagsBuilder,
	#superclass : #Object,
	#instVars : [
		'tags',
		'array'
	],
	#category : #'Accounting-Building'
}

{ #category : #'instance creation' }
ATagsBuilder class >> fromArray: anArray [
	^ self new
		array: anArray;
		build.
]

{ #category : #building }
ATagsBuilder >> array: anArray [
	array := anArray
]

{ #category : #building }
ATagsBuilder >> build [
	self tags addAll: array.
	^ tags
]

{ #category : #initialization }
ATagsBuilder >> initialize [
	super initialize.
]

{ #category : #accessing }
ATagsBuilder >> string: aString [
	array := (aString findTokens: ' ').
]

{ #category : #accessing }
ATagsBuilder >> tags [
	^ tags ifNil: [ tags := ATags new ]
]

{ #category : #accessing }
ATagsBuilder >> tags: anObject [
	tags := anObject
]
