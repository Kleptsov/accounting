"
Графический интерфейс кассы

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AKassaCheckGlamour,
	#superclass : #AGlamour,
	#instVars : [
		'goodsItems',
		'rootBrowser'
	],
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
AKassaCheckGlamour >> glmItemsfor: aPresenter [	
	|t|
	t := aPresenter table.
	t title: 'Items' translated.
	t display: [ :m| model items sortByPostTime ].
	t column: 'Count' translated evaluated: [:m| m amount ] width: 100.
	t column: 'Goodies' translated evaluated: [:m| m printTags ] width: 300.
	t column: 'Price' translated evaluated: [ :m| ((m swapAmount amount) / (m amount)) asFloat  ] width: 100 .
	t column: 'Sum' translated evaluated: [ :m| m swapAmount amount ] width: 100.
	t column: 'Currency' translated evaluated: [ :m| m swapAmount printTags ].
	self itemsActionsIn: t.
]

{ #category : #initialization }
AKassaCheckGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
AKassaCheckGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserActions.
	browser title: [:m| m number, ' ', 'Check' translated].
	browser row: #morphEditor size: 64.
	browser row: #tmp size: 0.
	browser row: [ :r|
		r column: #sum.
		r column: #clientSum.
		r column: #change ] size: 68.
	browser row: #items.
]

{ #category : #initialization }
AKassaCheckGlamour >> initializeBrowserActions [

	browser 
		act: [ :p| p update; updateToolbar]
		icon: GLMUIThemeExtraIcons glamorousRefresh
		entitled: 'Refresh' translated.

	browser
		act: [ :p| AKassaSettingGlamour new model: self model; open  ]
		icon: (Smalltalk ui iconNamed: #smallCogState3)
		entitled: 'Open Settings' translated.
	
	browser
		act: [ :p| |m| model accept.
				m := model createNextCheck.
				browser close.
				m open]
		icon: GLMUIThemeExtraIcons glamorousAccept
		entitled: 'accept'
]

{ #category : #initialization }
AKassaCheckGlamour >> initializeChange [
	(browser transmit) to: #change;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  '* ', 'Change' translated)
						text: #change
						accept: #change:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AKassaCheckGlamour >> initializeClientSum [
	(browser transmit) to: #clientSum;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label: ( 'Acquirer Sum' translated)
						text: #clientSum
						accept: #clientSum:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AKassaCheckGlamour >> initializeItems [	
	"browser transmit to: #items; andShow: [ :composite|
		composite title: 'List' translated.
		composite morph morph: [ :morphPresentation| 
			self itemsFor: morphPresentation
		] ].
	browser transmit to: #items; from: #morphEditor; andShow: [ :composite|
		composite title: 'List' translated.
		composite morph morph: [ :morphPresentation|
			self itemsFor: morphPresentation
		] ]."
	
	(browser transmit) to: #items;
		andShow: [ :a| self glmItemsfor: a].
		
	(browser transmit) to: #items; from: #morphEditor;
		andShow: [ :a| self glmItemsfor: a ]
]

{ #category : #initialization }
AKassaCheckGlamour >> initializeMorphEditor [
	(browser transmit) to: #morphEditor;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  'Selector' translated)
						text: #editor
						accept: #editor:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AKassaCheckGlamour >> initializeSum [
	"display first"
	"(browser transmit) to: #sum;
		andShow: [ :a|
			a title: 'Sum' translated.
			a text 
				display: [ :m| m sum ]
		].	
	(browser transmit) to: #sum; from: #morphEditor;
		andShow: [ :a|
			a title: 'Sum' translated.
			a text
				display: [ :m| model sum ] ]."
	(browser transmit) to: #sum;
		andShow: [ :composite|
			composite morph morph: [ :morphPresentation|
					ALabeledText
						on: model
						label:(  'Sum' translated)
						text: #sum
						accept: #sum:
						acceptAction: [ :v| morphPresentation selection: v asString ].
		] ]
]

{ #category : #initialization }
AKassaCheckGlamour >> initializeTmp [
	(browser transmit) to: #tmp;
		andShow: [ :a|
			a text
				display: [ :m| '' ]
		].
	
	(browser transmit) to: #tmp; from: #items port: #selection;
		andShow: [ :a| a text display: [ :sel| model selection: sel. '' ] ]
]

{ #category : #initialization }
AKassaCheckGlamour >> initializeTransmit [
	self initializeItems.
	self initializeMorphEditor.
	self initializeSum.
	self initializeChange.
	self initializeClientSum.
	self initializeTmp
]

{ #category : #initialization }
AKassaCheckGlamour >> itemsActionsIn: aPresentation [
	aPresentation
		act: [ :p| self selectFromDictionary.
			p update; updateToolbar. browser update; updateToolbar.]
		icon: GLMUIThemeExtraIcons glamorousBrowse
		entitled: 'Browse' translated;
		
		act: [:p| model addItem.
				p update; updateToolbar. browser update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousAdd
		entitled: 'Add' translated;
		
		act: [:p| model minusItem.
				p update; updateToolbar. browser update; updateToolbar ]
		icon: (Smalltalk ui iconNamed: #partialCheckedBox)
		entitled: 'Difference' translated;
				
		act: [ :p| model removeItem. p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousRemove
		entitled: 'Remove' translated.
]

{ #category : #initialization }
AKassaCheckGlamour >> itemsFor: morphPresentation [
	|morph|
	morph := FTTableMorph new.
	morph
		addColumn: ((FTColumn id: 'Count' translated) width: 100);
		addColumn: ((FTColumn id: 'Goodies' translated ) width: 300);
		addColumn: ((FTColumn id: 'Price' translated ) width: 100);
		addColumn: ((FTColumn id: 'Sum' translated ) width: 100);
		addColumn: (FTColumn id: 'Currency' translated );
		dataSource: (AKassaTableDataSource for: model items sortByPostTime);
		onAnnouncement: FTSelectionChanged do: [ :ann|  ].
	^ morph
]

{ #category : #initialization }
AKassaCheckGlamour >> open [
	browser openOn: model.
]

{ #category : #accessing }
AKassaCheckGlamour >> rootBrowser [
	^ rootBrowser
]

{ #category : #accessing }
AKassaCheckGlamour >> rootBrowser: anObject [
	rootBrowser := anObject
]

{ #category : #initialization }
AKassaCheckGlamour >> selectFromDictionary [
	| a |
	a := AListDialogWindow selectItemFrom: (AConfig dictionary collect: [ :el| el value ] ) asOrderedCollection.
	a ifNotNil: [ ^ model priceFor: a asSwapAmount ].
	^ nil.
]
