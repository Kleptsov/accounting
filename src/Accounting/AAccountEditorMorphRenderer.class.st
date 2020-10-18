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
	m := FText
			on: model
			label: 'Account' translated, ' 1'
			selector: #accItem1.
	m setProperty: #relativeExtent toValue: 0.3@1.0.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AAccountEditorMorphRenderer >> renderAccItem2 [
	| m |
	m := FText
			on: model
			label: 'Account' translated, ' 2'
			selector: #accItem2.
	m setProperty: #relativeExtent toValue: 0.3@1.0.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AAccountEditorMorphRenderer >> renderAmountItem [
	| m |
	m := FText
			on: model
			label: 'Count' translated
			selector: #amountItem.
	m setProperty: #relativeExtent toValue: 0.1@1.0.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AAccountEditorMorphRenderer >> renderCurrencyItem [
	| m |
	m := FText
			on: model
			label: 'Currency' translated
			selector: #currencyItem.
	m hResizing: #spaceFill.
	m vResizing: #spaceFill.
	self owner addMorphBack: m.
]

{ #category : #rendering }
AAccountEditorMorphRenderer >> renderSumItem [
	| m |
	m := FText
			on: model
			label: 'Sum' translated
			selector: #sumItem.
	m setProperty: #relativeExtent toValue: 0.1@1.0.
	self owner addMorphBack: m.
]
