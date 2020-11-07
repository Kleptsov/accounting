Class {
	#name : #AAccountEditor,
	#superclass : #Object,
	#instVars : [
		'amountItem',
		'accItem1',
		'accItem2',
		'accItem3',
		'accItem4',
		'sumItem',
		'currencyItem',
		'currencyItem2',
		'currencyItem3',
		'currentSwap',
		'currencyItem4',
		'barcode',
		'announcer'
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
AAccountEditor >> accItem4 [
	^ accItem4 ifNil: [ accItem4 := '' ]
]

{ #category : #accessing }
AAccountEditor >> accItem4: anObject [
	accItem4 := anObject.
	self changed: accItem4.
]

{ #category : #actions }
AAccountEditor >> addBarcode [
	| acc am |
	acc := AAccount new add: self barcode; yourself.
	AConfig barcodes delete: acc.
	am := AAmount new.
	self accItem1 = '' ifFalse: [ am add: self accItem1 ].
	self accItem2 = '' ifFalse: [ am add: self accItem2 ].
	self accItem3 = '' ifFalse: [ am add: self accItem3 ].
	am isEmpty ifTrue: [ ^ self ].
	acc addAmount: am.
	AConfig barcodes add: acc.
	^ acc
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
AAccountEditor >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
AAccountEditor >> announcer: anObject [
	announcer := anObject
]

{ #category : #accessing }
AAccountEditor >> barcode [
	^ barcode ifNil: [ barcode := '' ]
]

{ #category : #accessing }
AAccountEditor >> barcode: aBarcode [
	barcode := aBarcode.
	self updateAccountItems.
	self changed: #barcode.
]

{ #category : #actions }
AAccountEditor >> clean [
	self amountItem: ''.
	self accItem1: ''.
	self accItem2: ''.
	self accItem3: ''.
	self accItem4: ''.
	self sumItem: ''.
	self currencyItem: ''.
	self currencyItem2: ''.
	self currencyItem3: ''.
	self currencyItem4. ''.
	currentSwap := nil.
]

{ #category : #accessing }
AAccountEditor >> currencyItem [
	^ currencyItem ifNil: [ currencyItem := '' ]
]

{ #category : #accessing }
AAccountEditor >> currencyItem2 [
	^ currencyItem2 ifNil: [ currencyItem2 := '' ]
]

{ #category : #accessing }
AAccountEditor >> currencyItem2: anObject [
	currencyItem2 := anObject.
	self changed: #currencyItem2.
]

{ #category : #accessing }
AAccountEditor >> currencyItem3 [
	^ currencyItem3 ifNil: [ currencyItem3 := '' ]
]

{ #category : #accessing }
AAccountEditor >> currencyItem3: anObject [
	currencyItem3 := anObject.
	self changed: #currencyItem3.
]

{ #category : #accessing }
AAccountEditor >> currencyItem4 [
	^ currencyItem4 ifNil: [ currencyItem4 := '' ].
]

{ #category : #accessing }
AAccountEditor >> currencyItem4: anObject [
	currencyItem4 := anObject.
	self changed: #currencyItem4.
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
AAccountEditor >> makeAccount [
	| a |
	a := AAmount new.
	self accItem1 = '' ifFalse: [ a add: self accItem1 ].
	self accItem2 = '' ifFalse: [ a add: self accItem2 ].
	self accItem3 = '' ifFalse: [ a add: self accItem3 ].
	self accItem4 = '' ifFalse: [ a add: self accItem4 ].
	self currencyItem = '' ifFalse: [ a add: self currencyItem ].
	self currencyItem2 = '' ifFalse: [ a add: self currencyItem2 ].
	self currencyItem3 = '' ifFalse: [ a add: self currencyItem3 ].
	self currencyItem4 = '' ifFalse: [ a add: self currencyItem4 ].
	^ a
]

{ #category : #actions }
AAccountEditor >> makeAmount [
	|am |
	am := AAmount new.
	self accItem1 = '' ifFalse: [ am add: self accItem1 ].
	self accItem2 = '' ifFalse: [ am add: self accItem2 ].
	self accItem3 = '' ifFalse: [ am add: self accItem3 ].
	self accItem4 = '' ifFalse: [ am add: self accItem4 ].
	self currencyItem = '' ifFalse: [ am add: self currencyItem ].
	self currencyItem2 = '' ifFalse: [ am add: self currencyItem2 ].
	self currencyItem3 = '' ifFalse: [ am add: self currencyItem3 ].
	self currencyItem4 = '' ifFalse: [ am add: self currencyItem4 ].
	^ am
]

{ #category : #actions }
AAccountEditor >> makeSwap [
	| sw sa |
	sw := ASwap new.
	sa := sw swapAmount.
	[ sw amount: (self amountItem asNumber) ] on: Error do: [ :ex| ].
	self accItem1 = '' ifFalse: [ sw add: self accItem1 ].
	self accItem2 = '' ifFalse: [ sw add: self accItem2 ].
	self accItem3 = '' ifFalse: [ sw add: self accItem3 ].
	self accItem4 = '' ifFalse: [ sw add: self accItem4 ].
	self currencyItem = '' ifFalse: [ sa add: self currencyItem ].
	self currencyItem2 = '' ifFalse: [ sa add: self currencyItem2 ].
	self currencyItem3 = '' ifFalse: [ sa add: self currencyItem3 ].
	self currencyItem4 = '' ifFalse: [ sa add: self currencyItem4 ].
	[ sw swapAmount amount: (self sumItem asNumber) ] on: Error do: [ :ex|  ].
	^ sw
]

{ #category : #accessing }
AAccountEditor >> menu [
	^ nil
]

{ #category : #rendering }
AAccountEditor >> morphController [
	^ FDirectController new
]

{ #category : #rendering }
AAccountEditor >> morphRenderer [
	^ AAccountEditorMorphRenderer new.
]

{ #category : #rendering }
AAccountEditor >> morphView [
	^ self morphController
			listen: #yourself from: self
]

{ #category : #rendering }
AAccountEditor >> morphViewInWindow [
	| m w |
	m := self morphView.
	w := StandardWindow new.
	w title: 'Account Editor' translated.
	w addMorph: m frame: LayoutFrame new.
	w open.
	^ m
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
AAccountEditor >> updateAccountItems [
	| resultAmount |
	resultAmount := AConfig barcodes
		select: (AAccount new add: self barcode; yourself) at: 1.
	self updateEditor: resultAmount.
	^ resultAmount
]

{ #category : #actions }
AAccountEditor >> updateEditor: anSwap [
	| coll sw |
	anSwap ifNil: [ ^ self ].
	self clean.
	sw := anSwap asSwap.
	self amountItem: sw amount.
	self sumItem: sw swapAmount amount.
	coll := sw asOrderedCollection.
	coll isEmpty ifFalse: [ self accItem1: coll first ].
	coll size > 1 ifTrue: [ self accItem2: coll second ].
	coll size > 2 ifTrue: [ self accItem3: (coll at: 3) ].
	coll size > 3 ifTrue: [ self accItem4: (coll at: 4) ].
	coll := sw swapAmount asOrderedCollection.
	coll isEmpty ifFalse: [ self currencyItem: coll first ].
	coll size > 1 ifTrue: [ self currencyItem2: coll second ].
	coll size > 2 ifTrue: [ self currencyItem3: coll third ].
	coll size > 3 ifTrue: [ self currencyItem4: (coll at: 4) ]
]

{ #category : #actions }
AAccountEditor >> updateEditorFromAccount: anAccount [
	| coll |
	self clean.
	coll := anAccount asOrderedCollection.
	coll isEmpty ifFalse: [ self accItem1: coll first ].
	coll size > 1 ifTrue: [ self accItem2: coll second ].
	coll size > 2 ifTrue: [ self accItem3: (coll at: 3) ].
	coll size > 3 ifTrue: [ self accItem4: (coll at: 4) ].
	coll size > 4 ifTrue: [ self currencyItem: (coll at: 5) ].
	coll size > 5 ifTrue: [ self currencyItem2: (coll at: 6) ].
	coll size > 6 ifTrue: [ self currencyItem3: (coll at: 7) ].
	coll size > 7 ifTrue: [ self currencyItem4: (coll at: 8) ].
]
