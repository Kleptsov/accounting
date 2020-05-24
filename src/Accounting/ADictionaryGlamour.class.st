"
Графический интерфейс словаря

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ADictionaryGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
ADictionaryGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
ADictionaryGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: [ :m| 'Dictionary' translated ] .
	browser transformation: [ :m| self model: m. m ].
	browser row: [ :r|
		r column: #items.
		r column: #search].
	browser row: [ :r|
		r column: #key.
		r column: #value.
	] size: 68.
	browser row: #tmp size: 0.
]

{ #category : #initialization }
ADictionaryGlamour >> initializeItems [
	(browser transmit) to: #items;
		andShow: [ :a|
			a list
				title: 'Items' translated;
				
				act: [ :p| (p pane port: #entity) value addItem. "model addItem"
								p update ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :p| (p pane port: #entity) value removeItem. "model removeItem"
								p update ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;

				display: [ :m| m items ] ]
]

{ #category : #initialization }
ADictionaryGlamour >> initializeKey [
	(browser transmit) to: #key;
		andShow: [ :a|
			a text
				title: 'Key' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model keyTags: textPresentation text asString ];
				display: [ :m| m keyTags ] ].
]

{ #category : #initialization }
ADictionaryGlamour >> initializeSearch [
	(browser transmit) to: #search;
		andShow: [ :a|
			a list
				title: 'Search' translated;
				display: [ :m| m search ] ].
]

{ #category : #initialization }
ADictionaryGlamour >> initializeTmp [
	(browser transmit) to: #tmp; from: #items port: #selection;
		andShow: [ :a|
			a text display: [ :sel| model selectionItem: sel. browser update. ] ].
		
	(browser transmit) to: #tmp; from: #search port: #selection;
		andShow: [ :a|
			a text display: [ :sel| model selectionItem: sel. browser update. ] ]
]

{ #category : #initialization }
ADictionaryGlamour >> initializeTransmit [
	self initializeKey.
	self initializeValue.
	self initializeItems.
	self initializeSearch.
	self initializeTmp.
	
]

{ #category : #initialization }
ADictionaryGlamour >> initializeValue [
	(browser transmit) to: #value;
		andShow: [ :a|
			a text
				title: 'Value' translated;
				onChangeOfPort: #text act: [ :textPresentation|
					model valueTags: textPresentation text asString ];
				display: [ :m| m valueTags ] ].
]

{ #category : #initialization }
ADictionaryGlamour >> open [
	browser openOn: model.
]
