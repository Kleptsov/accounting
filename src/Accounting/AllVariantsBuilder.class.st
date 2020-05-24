"
Создание из коллекции тегов всех возможных вариантов тегов

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	result:		<Object>
	sourceColl:		<Object>


    Implementation Points
"
Class {
	#name : #AllVariantsBuilder,
	#superclass : #Object,
	#instVars : [
		'sourceColl',
		'result'
	],
	#category : #'Accounting-Building'
}

{ #category : #building }
AllVariantsBuilder >> build [
	| size bit nextColl |
	size := sourceColl size.
	1 to: (2 raisedTo: size) do: [ :index|
		nextColl := OrderedCollection new.
		1 to: size do: [ :bitShift|
			bit := index bitAt: bitShift.
			bit = 1 ifTrue: [ nextColl add: (sourceColl at: bitShift) ] ].
		nextColl isEmpty ifFalse: [ result add: nextColl ].
	].
	^ result
]

{ #category : #initialization }
AllVariantsBuilder >> initialize [
	super initialize.
	result := OrderedCollection new.
]

{ #category : #accessing }
AllVariantsBuilder >> result [
	^ result
]

{ #category : #accessing }
AllVariantsBuilder >> result: anObject [
	result := anObject
]

{ #category : #accessing }
AllVariantsBuilder >> sourceColl [
	^ sourceColl
]

{ #category : #accessing }
AllVariantsBuilder >> sourceColl: anObject [
	sourceColl := anObject asOrderedCollection sort.
]
