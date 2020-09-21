Class {
	#name : #AAccountEditor,
	#superclass : #Object,
	#instVars : [
		'amountItem',
		'accItem1',
		'accItem2',
		'accItem3',
		'sumItem',
		'currencyItem',
		'currentSwap'
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
AAccountEditor >> accItem3 [
	^ accItem3 ifNil: [ accItem3 := '' ]
]

{ #category : #accessing }
AAccountEditor >> accItem3: anObject [
	accItem3 := anObject.
	self changed: #accItem3.
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

{ #category : #actions }
AAccountEditor >> clean [
	self amountItem: ''.
	self accItem1: ''.
	self accItem2: ''.
	self accItem3: ''.
	self sumItem: ''.
	self currencyItem: ''.
	currentSwap := nil.
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

{ #category : #accessing }
AAccountEditor >> currentSwap [
	^ currentSwap ifNil: [ currentSwap := ASwap new ]
]

{ #category : #accessing }
AAccountEditor >> currentSwap: aCurrentSwap [
	currentSwap := aCurrentSwap
]

{ #category : #actions }
AAccountEditor >> makeSwap [
	| sw |
	sw := ASwap new.
	[ sw amount: (self amountItem asNumber) ] on: Error do: [ :ex| ].
	self accItem1 = '' ifFalse: [ sw add: accItem1 asString ].
	self accItem2 = '' ifFalse: [ sw add: accItem2 asString ].
	self accItem3 = '' ifFalse: [ sw add: accItem3 asString ].
	[ sw swapAmount amount: (self sumItem asNumber);
			add: self currencyItem ] on: Error do: [ :ex| ].
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
	| coll sw |
	anSwap ifNil: [ ^ self ].
	sw := anSwap asSwap.
	self amountItem: sw amount.
	self sumItem: sw swapAmount amount.
	coll := sw asOrderedCollection.
	coll isEmpty ifFalse: [ self accItem1: coll first ].
	coll size > 1 ifTrue: [ self accItem2: coll second ].
	coll := sw swapAmount asOrderedCollection.
	coll isEmpty ifFalse: [ self currencyItem: coll first ] 
]
