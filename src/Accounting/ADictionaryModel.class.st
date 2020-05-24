"
Модель словаря

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	keyTags:		<Object>
	selectionItem:		<Object>
	valueTags:		<Object>


    Implementation Points
"
Class {
	#name : #ADictionaryModel,
	#superclass : #AModel,
	#instVars : [
		'keyTags',
		'valueTags',
		'search',
		'selection'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
ADictionaryModel class >> documents [
	^ nil
]

{ #category : #adding }
ADictionaryModel class >> nextIndex [
	^ nil
]

{ #category : #actions }
ADictionaryModel >> addItem [
	| ast |
	(self keyTags = '' or: [ self valueTags = '' ])
		ifTrue: [ ^ self ].
	ast := AAssociationTags
					key: self keyTags
					value: self valueTags.
	(self items like: ast)
		ifNil: [ self items add: ast ]
		ifNotNil: [ :assoc| self items remove: assoc ifAbsent: [  ].
						self items add: ast ].
]

{ #category : #accessing }
ADictionaryModel >> items [
	^ self configClass dictionary
]

{ #category : #accessing }
ADictionaryModel >> keyTags [
	^ keyTags ifNil: [ keyTags := '' ]
]

{ #category : #accessing }
ADictionaryModel >> keyTags: anObject [
	keyTags := anObject
]

{ #category : #actions }
ADictionaryModel >> open [
	^ ADictionaryGlamour openOn: self
]

{ #category : #actions }
ADictionaryModel >> removeItem [
	self items remove: selection ifAbsent: [  ]
]

{ #category : #accessing }
ADictionaryModel >> search [
	^ search ifNil: [ search := Set new ]
]

{ #category : #accessing }
ADictionaryModel >> search: anObject [
	search := anObject
]

{ #category : #actions }
ADictionaryModel >> selectionItem: anItem [
	anItem ifNil: [ ^ self ].
	self keyTags: anItem printKey.
	self valueTags: anItem printValue.
	self search: (self items sequenceLike: anItem).
	selection := anItem.
]

{ #category : #accessing }
ADictionaryModel >> valueTags [
	^ valueTags ifNil: [ valueTags := '' ]
]

{ #category : #accessing }
ADictionaryModel >> valueTags: anObject [
	valueTags := anObject
]
