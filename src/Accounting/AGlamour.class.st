"
Абстрактный метод содержащий общее поведение графического интерфейса

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AGlamour,
	#superclass : #Object,
	#instVars : [
		'browser',
		'model'
	],
	#category : #'Accounting-GUI'
}

{ #category : #'instance creation' }
AGlamour class >> openOn: aModel [
	| n |
	n := self new.
	n model: aModel.
	n open.
	^ n.
]

{ #category : #accessing }
AGlamour >> browser [
	^ browser
]

{ #category : #accessing }
AGlamour >> browser: anObject [
	browser := anObject
]

{ #category : #accessing }
AGlamour >> model [
	^ model
]

{ #category : #accessing }
AGlamour >> model: anObject [
	model := anObject
]

{ #category : #opening }
AGlamour >> open [
	browser openOn: model
]
