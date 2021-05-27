Class {
	#name : #AAccountEditorMorphRenderer,
	#superclass : #FMorphRenderer,
	#category : #'Accounting-GUI-Facing'
}

{ #category : #rendering }
AAccountEditorMorphRenderer >> owner [
	^ owner ifNil: [ 
		owner := Morph new
			extent: 1@40;
			color: Color transparent;
			layoutPolicy: (FAbsoluteRelativeLayout new direction: #rightDown);
			hResizing: #spaceFill;
			yourself ].
]

{ #category : #rendering }
AAccountEditorMorphRenderer >> render [
	self renderAmountItem.
	self renderAccItem1.
	self renderAccItem2.
	self renderSumItem.
	self renderCurrencyItem.
	^ self owner
]

{ #category : #rendering }
AAccountEditorMorphRenderer >> renderAccItem1 [
	| m |
	m := AText2
			model: model
			event: #accItem1
			callbackEvent: #updateText
			label: 'Account' translated, ' 1'.
	m setProperty: #relativeExtent toValue: 0.3@1.0.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AAccountEditorMorphRenderer >> renderAccItem2 [
	| m |
	m := AText2
			model: model
			event: #accItem2
			callbackEvent: #updateText
			label: 'Account' translated, ' 2'.
	m setProperty: #relativeExtent toValue: 0.3@1.0.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AAccountEditorMorphRenderer >> renderAmountItem [
	| m |
	m := AText2
			model: model
			event: #amountItem
			callbackEvent: #updateText
			label: 'Count' translated.
	m setProperty: #relativeExtent toValue: 0.1@1.0.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AAccountEditorMorphRenderer >> renderCurrencyItem [
	| m |
	m := AText2
			model: model
			event: #currencyItem
			callbackEvent: #updateText
			label: 'Currency' translated.
	m hResizing: #spaceFill.
	m vResizing: #spaceFill.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AAccountEditorMorphRenderer >> renderSumItem [
	| m |
	m := AText2
			model: model
			event: #sumItem
			callbackEvent: #updateText
			label: 'Sum' translated.
	m setProperty: #relativeExtent toValue: 0.1@1.0.
	self owner addMorphBack: m.
]
