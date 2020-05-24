"
Список счетов для быстрого ввода в графические формы

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	acc1:		<Object>
	acc2:		<Object>
	acc3:		<Object>
	acc4:		<Object>
	accountsList:		<Object>
	first:		<Object>
	fourth:		<Object>
	second:		<Object>
	selection:		<Object>
	third:		<Object>


    Implementation Points
"
Class {
	#name : #AAccountsModel,
	#superclass : #AModel,
	#instVars : [
		'accountsList',
		'acc1',
		'acc2',
		'acc3',
		'acc4',
		'first',
		'second',
		'third',
		'fourth',
		'selection'
	],
	#category : #'Accounting-Model'
}

{ #category : #accessing }
AAccountsModel >> acc1 [
	^ acc1 ifNil: [ acc1 := '' ]
]

{ #category : #accessing }
AAccountsModel >> acc1: anObject [
	acc1 := anObject
]

{ #category : #accessing }
AAccountsModel >> acc2 [
	^ acc2 ifNil: [ acc2 := '' ]
]

{ #category : #accessing }
AAccountsModel >> acc2: anObject [
	acc2 := anObject
]

{ #category : #accessing }
AAccountsModel >> acc3 [
	^ acc3 ifNil: [ acc3 := '' ]
]

{ #category : #accessing }
AAccountsModel >> acc3: anObject [
	acc3 := anObject
]

{ #category : #accessing }
AAccountsModel >> acc4 [
	^ acc4 ifNil: [ acc4 := '' ]
]

{ #category : #accessing }
AAccountsModel >> acc4: anObject [
	acc4 := anObject
]

{ #category : #accessing }
AAccountsModel >> accountsList [
	^ accountsList ifNil: [ accountsList := self configClass accountsList ]
]

{ #category : #accessing }
AAccountsModel >> accountsList: anObject [
	accountsList := anObject
]

{ #category : #actions }
AAccountsModel >> addItem [
	| array |
	array := AOrderedCollection new.
	(self acc1 = '') ifTrue: [ ^ self ].
	array add: acc1.
	self acc2 = '' ifFalse: [ array add: acc2 ].
	self acc3 = '' ifFalse: [ array add: acc3 ].
	self acc4 = '' ifFalse: [ array add: acc4 ].
	self accountsList addFirst: array.
]

{ #category : #opening }
AAccountsModel >> open [
	^ AAccountsGlamour openOn: self
]

{ #category : #actions }
AAccountsModel >> removeItem [
	self accountsList remove: self selection ifAbsent: [  ]
]

{ #category : #accessing }
AAccountsModel >> selection [
	^ selection
]

{ #category : #accessing }
AAccountsModel >> selection: anObject [
	selection := anObject
]
