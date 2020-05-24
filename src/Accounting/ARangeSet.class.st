"
Словарь тегов. Представление тегов другими тегами.

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	iterationCount:		<Object>


    Implementation Points
"
Class {
	#name : #ARangeSet,
	#superclass : #Set,
	#instVars : [
		'iterationCount'
	],
	#category : #'Accounting-Core'
}

{ #category : #initialize }
ARangeSet >> initialize [
	super initialize.
	iterationCount := 5.
]

{ #category : #initialize }
ARangeSet >> initialize: n [
	super initialize: n.
	self initialize.
]

{ #category : #accessing }
ARangeSet >> rangeLike: anObject [
	| v |
	v := anObject.
	iterationCount timesRepeat: [ 
		(self like: v)
			ifNil: [ ^ v ]
			ifNotNil: [ :val| (val value)
										ifNil: [ ^ val ]
										ifNotNil: [ v := val value ] ] ].
	^ v.
]

{ #category : #accessing }
ARangeSet >> sequenceLike: anObject [
	| v coll |
	coll := OrderedCollection new.
	v := anObject.
	iterationCount timesRepeat: [ 
		(self like: v)
			ifNil: [ ^ coll ]
			ifNotNil: [ :val| (val value)
										ifNil: [ ^ coll ]
										ifNotNil: [ v := val value.
													coll add: v ] ] ].
	^ coll.
]
