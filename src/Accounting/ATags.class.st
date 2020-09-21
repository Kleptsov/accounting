"
Реализовано поведение тегов

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	uuid:		<Object>


    Implementation Points
"
Class {
	#name : #ATags,
	#superclass : #Set,
	#instVars : [
		'uuid',
		'symbolId'
	],
	#classInstVars : [
		'uuidDictionary'
	],
	#category : #'Accounting-Core'
}

{ #category : #'instance creation' }
ATags class >> newUUIDFor: aSymbol [
	| id |
	id := self uuidDictionary
		at: aSymbol
		ifAbsentPut: [ UUID withAll: (MD5 hashMessage: aSymbol asString) ].
	^ id.
]

{ #category : #'instance creation' }
ATags class >> uuidDictionary [
	^ uuidDictionary ifNil: [ uuidDictionary := IdentityDictionary new ].
	
]

{ #category : #'instance creation' }
ATags class >> uuidDictionary: aDictionary [
	uuidDictionary := aDictionary.
	
]

{ #category : #testing }
ATags >> = aTags [
	^ self symbolId = aTags symbolId
	"^ self uuid = aTags uuid"
]

{ #category : #adding }
ATags >> add: anObject [
	super add: anObject asString.
	self updateHash.
	^ anObject
]

{ #category : #adding }
ATags >> addAll: anCollection [
	super addAll: anCollection.
	self updateHash.
	^ anCollection
]

{ #category : #adding }
ATags >> allTags [
	^ AllVariantsBuilder new
			sourceColl: self;
			build;
			result.
	
]

{ #category : #comparing }
ATags >> hash [
	^ self symbolId hash.
	"^ self uuid hash"
]

{ #category : #printing }
ATags >> printKey [
	| s |
	s := WriteStream on: ''.
	self do: [ :t| s nextPutAll: t; nextPutAll: ' ' ].
	^ s contents.
]

{ #category : #printing }
ATags >> printValue [
	^ ''
]

{ #category : #accesing }
ATags >> symbolId [
	^ symbolId ifNil: [ self updateHash. symbolId ].
]

{ #category : #updating }
ATags >> update [
	self updateHash.
]

{ #category : #updating }
ATags >> updateHash [
	|s|
	s := WriteStream on: '' .
	self asOrderedCollection sort do: [ :el|
		s nextPutAll: '==>'; nextPutAll: el.
	].
	symbolId := s contents asSymbol.
	"uuid := self class newUUIDFor: symbolId."
]
