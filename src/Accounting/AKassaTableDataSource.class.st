Class {
	#name : #AKassaTableDataSource,
	#superclass : #FTSimpleDataSource,
	#instVars : [
		'iconBlock'
	],
	#category : #'Accounting-Model'
}

{ #category : #'instance creation' }
AKassaTableDataSource class >> for: anObject [
	^ self new
		elements: anObject;
		yourself.
]

{ #category : #accessing }
AKassaTableDataSource >> cellColumn: column row: rowIndex [ 
	^ self nameColumn: column row: rowIndex.
]

{ #category : #accessing }
AKassaTableDataSource >> colorFor: index [
	index odd ifTrue: [ ^ Smalltalk ui theme lightBackgroundColor ].
	^ Smalltalk ui theme backgroundColor
]

{ #category : #accessing }
AKassaTableDataSource >> headerColumn: column [
	column id ifNil: [ ^ nil ]. 
	^ FTCellMorph new 
		listCentering: #left;
		addMorph: column id asMorph;
		yourself
]

{ #category : #accessing }
AKassaTableDataSource >> iconFor: rowIndex [
	iconBlock ifNil: [ ^ nil ].
	^ iconBlock value: (self elementAt: rowIndex)
]

{ #category : #accessing }
AKassaTableDataSource >> nameColumn: column row: rowIndex [
	| cell |
	cell := FTCellMorph new.
	cell color: (self colorFor: rowIndex); cellInset: 10.
		"addMorphBack: (self iconFor: rowIndex) asMorph;"
	(column id = 'Count' translated) ifTrue: [ cell addMorphBack: (self elementAt: rowIndex) amount asStringMorph ].
	(column id = 'Goodies' translated) ifTrue: [ cell addMorphBack: (self elementAt: rowIndex) printTags asStringMorph ].
	(column id = 'Price' translated) ifTrue: [ cell addMorphBack: ((self elementAt: rowIndex) swapAmount amount / (self elementAt: rowIndex) amount) asFloat asStringMorph ].
	(column id = 'Sum' translated) ifTrue: [ cell addMorphBack: (self elementAt: rowIndex) swapAmount amount asStringMorph ].
	(column id = 'Currency' translated) ifTrue: [ cell addMorphBack: (self elementAt: rowIndex) swapAmount printTags asStringMorph ].
	^ cell
]
