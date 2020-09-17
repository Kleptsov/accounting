Class {
	#name : #AAccountEditor,
	#superclass : #Object,
	#instVars : [
		'amountItem',
		'accItem1',
		'accItem2',
		'sumItem',
		'currencyItem'
	],
	#category : #'Accounting-Model'
}

{ #category : #accessing }
AAccountEditor >> accItem1 [
	^ accItem1 ifNil: [ accItem1 := '' ]
]

{ #category : #accessing }
AAccountEditor >> accItem1: anObject [
	accItem1 := anObject.
	self changed: #accItem1
]

{ #category : #accessing }
AAccountEditor >> accItem2 [
	^ accItem2 ifNil: [ accItem2 := '' ]
]

{ #category : #accessing }
AAccountEditor >> accItem2: anObject [
	accItem2 := anObject.
	self changed: #accItem2.
]

{ #category : #accessing }
AAccountEditor >> amountItem [
	^ amountItem ifNil: [ amountItem := '' ]
]

{ #category : #accessing }
AAccountEditor >> amountItem: anObject [
	amountItem := anObject.
	self changed: #amountItem
]

{ #category : #accessing }
AAccountEditor >> currencyItem [
	^ currencyItem ifNil: [ currencyItem := '' ]
]

{ #category : #accessing }
AAccountEditor >> currencyItem: anObject [
	currencyItem := anObject.
	self changed: #currencyItem.
]

{ #category : #actions }
AAccountEditor >> makeSwap [
	| sw |
	(self amountItem = '' or:
		[ self sumItem = '' or:
			[ self currencyItem = '' ] ])
				ifTrue: [ Error signal: 'Empty field amount or sum or currency'. ^ nil ].
	(self accItem1 = '' and: [ self accItem2 = '' ] )
		ifTrue: [ Error signal: 'Empty unit or properties goods'. ^ nil].
	sw := ASwap new.
	sw amount: (self amountItem asNumber).
	self accItem1 = '' ifFalse: [ sw add: accItem1 asString ].
	self accItem2 = '' ifFalse: [ sw add: accItem2 asString ].
	sw swapAmount amount: (self sumItem asNumber);
			add: self currencyItem.
	^ sw
]

{ #category : #accessing }
AAccountEditor >> sumItem [
	^ sumItem ifNil: [ sumItem := '' ]
]

{ #category : #accessing }
AAccountEditor >> sumItem: anObject [
	sumItem := anObject.
	self changed: #sumItem.
]

{ #category : #actions }
AAccountEditor >> updateEditor: anSwap [
	| coll |
	anSwap ifNil: [ ^ self ].
	self amountItem: anSwap amount asString.
	coll := anSwap asOrderedCollection.
	coll isEmpty
		ifFalse: [ self accItem1: coll first asString ]
		ifTrue: [self accItem1: ''; accItem2: '' ].
	coll size > 1
		ifTrue: [ self accItem2: coll second asString ]
		ifFalse: [self accItem2: ''].
	self sumItem: anSwap swapAmount amount asString.
	self currencyItem: anSwap swapAmount asOrderedCollection first asString.
]
