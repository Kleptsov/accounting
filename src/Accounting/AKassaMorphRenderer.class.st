Class {
	#name : #AKassaMorphRenderer,
	#superclass : #FMorphRenderer,
	#instVars : [
		'commandPanel'
	],
	#category : #'Accounting-GUI-Facing'
}

{ #category : #rendering }
AKassaMorphRenderer >> commandPanel [
	^ commandPanel 	ifNil: [
			commandPanel := Morph new
				layoutPolicy: (FAbsoluteRelativeLayout new direction: #rightDown) ;
				color: Color transparent;
				extent: 10@30;
				hResizing: #spaceFill.
			self owner addMorphBack: commandPanel.
			commandPanel ]
]

{ #category : #rendering }
AKassaMorphRenderer >> nextLine [
	| m |
	m := Morph new extent: 0@0; setProperty: #cr toValue: true.
	self owner addMorphBack: m
]

{ #category : #rendering }
AKassaMorphRenderer >> render [
	self commandPanel.
	self renderAddBarcodeButton.
	self renderSelectItemButton.
	self nextLine.
	self renderBarcode.
	self nextLine.
	self render: #accountEditor
		with: [ :m| m extent: 1@40; hResizing: #spaceFill ].
	self nextLine.
	self renderSum.
	self renderClientSum.
	self renderChange.
	self nextLine.
	self render: #itemsList
		with: [ :m| m extent: 1@10; hResizing: #spaceFill; vResizing: #spaceFill ].
	^ self owner
]

{ #category : #rendering }
AKassaMorphRenderer >> renderAddBarcodeButton [
	self commandPanel addMorphBack:
			((FButton
				model: model accountEditor
				label: (self iconNamed: #add) asMorph 
				action: #addBarcode
				help: 'Add Barcode' translated) color: Color transparent; yourself).
]

{ #category : #rendering }
AKassaMorphRenderer >> renderBarcode [
	| m |
	m := FText
			on: model
			label: 'Select' translated
			selector: #barcode.
	m extent: 150@40;
		hResizing: #spaceFill.
	self owner addMorphBack: m
]

{ #category : #rendering }
AKassaMorphRenderer >> renderChange [
	| m |
	m := FText
			on: model
			label: 'Change' translated
			selector: #change.
	m extent: 150@40.
	self owner addMorphBack: m
]

{ #category : #rendering }
AKassaMorphRenderer >> renderClientSum [
	| m |
	m := FText
			on: model
			label: 'Client Sum' translated
			selector: #clientSum.
	m extent: 150@40.
	self owner addMorphBack: m
]

{ #category : #rendering }
AKassaMorphRenderer >> renderSelectItemButton [
	self commandPanel addMorphBack:
			((FButton
				model: model
				label: (self iconNamed: #smallFind) asMorph 
				action: #searchItem
				help: 'Search Item' translated) color: Color transparent; yourself).
]

{ #category : #rendering }
AKassaMorphRenderer >> renderSum [
	| m |
	m := FText
			on: model
			label: 'Sum' translated
			selector: #sum.
	m extent: 150@40.
	self owner addMorphBack: m
]
