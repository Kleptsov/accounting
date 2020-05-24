"
Ассоциация тегов. Используется в коллекции ARangeSet

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	value:		<Object>


    Implementation Points
"
Class {
	#name : #AAssociationTags,
	#superclass : #ATags,
	#instVars : [
		'value'
	],
	#category : #'Accounting-Core'
}

{ #category : #accessing }
AAssociationTags class >> key: aKey value: aValue [
	| at vt|
	at := self new.
	vt := self new.
	ATagsBuilder new
		tags: vt;
		string: aValue;
		build.
	at value: vt.
	ATagsBuilder new
		tags: at;
		string: aKey;
		build.
	^ at
]

{ #category : #converting }
AAssociationTags >> asSwapAmount [
	| sw |
	sw := ASwap new.
	sw addAll: self.
	^ sw
]

{ #category : #printing }
AAssociationTags >> printOn: aStream [
	self do: [ :t|
		aStream nextPutAll: ' '.
		aStream nextPutAll: t ].
	self value ifNil: [ ^ self ].
	aStream nextPutAll: ' -> '.
	self value printOn: aStream.
]

{ #category : #printing }
AAssociationTags >> printValue [
	^ self value ifNotNil: [ :v| v printKey ] ifNil: [ '' ]
]

{ #category : #accessing }
AAssociationTags >> value [
	^ value
]

{ #category : #accessing }
AAssociationTags >> value: aValue [
	value := aValue
]
