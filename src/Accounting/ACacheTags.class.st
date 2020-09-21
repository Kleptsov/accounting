"
Поведение кешированных тегов

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	alluuid:		<Object>


    Implementation Points
"
Class {
	#name : #ACacheTags,
	#superclass : #ATags,
	#instVars : [
		'alluuid',
		'printVersion'
	],
	#category : #'Accounting-Core'
}

{ #category : #printing }
ACacheTags >> printTags [
	| stream |
	stream := WriteStream on: ''.
	self printTagsOn: stream.
	^ stream contents.
]

{ #category : #printing }
ACacheTags >> printTagsOn: aStream [
	| size |
	size := self size.
	self do: [ :t|
		aStream nextPutAll: t asString.
		size := size - 1.
		size = 0 ifFalse: [ aStream nextPut: Character space ] ]
]
