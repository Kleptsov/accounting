"
Конструирование тегов даты

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	collection:		<Object>
	date:		<Object>


    Implementation Points
"
Class {
	#name : #ADateTagsBuilder,
	#superclass : #Object,
	#instVars : [
		'date',
		'collection'
	],
	#category : #'Accounting-Building'
}

{ #category : #building }
ADateTagsBuilder >> build [
	| d |
	d := (DateParser readingFrom: (ReadStream on: self date) pattern: 'd.mm.yyyy') parse.
	collection at: 1 put: (AConfig yearPrefix, d year asString).
	collection at: 2 put: (AConfig monthPrefix, d monthIndex asString).
	collection at: 3 put: (AConfig dayPrefix, d dayOfMonth asString).
	^ collection
]

{ #category : #accessing }
ADateTagsBuilder >> collection [
	^ collection
]

{ #category : #accessing }
ADateTagsBuilder >> collection: anObject [
	collection := anObject
]

{ #category : #accessing }
ADateTagsBuilder >> date [
	^ date
]

{ #category : #accessing }
ADateTagsBuilder >> date: anObject [
	date := anObject
]

{ #category : #initialization }
ADateTagsBuilder >> initialize [
	super initialize.
	collection := Array new: 3.
]
