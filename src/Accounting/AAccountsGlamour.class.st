"
Графический интерфейс списка счетов 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AAccountsGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #actions }
AAccountsGlamour >> accountsList [
	^ self model accountsList.
]

{ #category : #initialization }
AAccountsGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
AAccountsGlamour >> initializeAcc1 [
	(browser transmit) to: #acc1;
		andShow: [ :a|
			a text
				title: 'Account' translated, ' 1';
				onChangeOfPort: #text act: [ :tp| model acc1: tp text asString ];
				display: [ :m| model acc1 ] ]
]

{ #category : #initialization }
AAccountsGlamour >> initializeAcc2 [
	(browser transmit) to: #acc2;
		andShow: [ :a|
			a text
				title: 'Account' translated, ' 2';
				onChangeOfPort: #text act: [ :tp| model acc2: tp text asString ];
				display: [ :m| model acc2 ] ]
]

{ #category : #initialization }
AAccountsGlamour >> initializeAcc3 [
	(browser transmit) to: #acc3;
		andShow: [ :a|
			a text
				title: 'Account' translated, ' 3';
				onChangeOfPort: #text act: [ :tp| model acc3: tp text asString ];
				display: [ :m| model acc3 ] ]
]

{ #category : #initialization }
AAccountsGlamour >> initializeAcc4 [
	(browser transmit) to: #acc4;
		andShow: [ :a|
			a text
				title: 'Account' translated, ' 4';
				onChangeOfPort: #text act: [ :tp| model acc4: tp text asString ];
				display: [ :m| model acc4 ] ]
]

{ #category : #initialization }
AAccountsGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	self initializeBrowserTitle.
	browser transformation: [ :m| self model: m. m ].
	browser row: [ :r|
		r column: #acc1.
		r column: #acc2.
	] size: 68.
	browser row: [ :r|
		r column: #acc3.
		r column: #acc4.
	] size: 68.
	browser row: #tmp size: 3.
	browser row: #items.
	
]

{ #category : #initialization }
AAccountsGlamour >> initializeBrowserTitle [
	browser title: [:m| 'Accounts List' translated ].
]

{ #category : #initialization }
AAccountsGlamour >> initializeItems [
	(browser transmit) to: #items;
		andShow: [ :a|
			a list
				title: 'Items' translated;
			
				act: [ :pr| self moveUp: (pr pane port: #selection) value. pr update ]
				icon: GLMUIThemeExtraIcons glamorousUp
				entitled: 'Move item up' translated;
				
				act: [ :pr| self moveDown: (pr pane port: #selection) value. pr update]
				icon: GLMUIThemeExtraIcons glamorousDown
				entitled: 'Move item down' translated;
				
				act: [:p| model addItem.
						p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :p| model removeItem.
							p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;
				
				format: [ :m| (m inject: (WriteStream on: '') into: [ :acc :str | acc nextPutAll: str; nextPutAll: ' '; yourself ]) contents ];			
				
				display: [ :m| m accountsList ]  ]
]

{ #category : #initialization }
AAccountsGlamour >> initializeTmp [
	(browser transmit) to: #tmp; from: #items port: #selection;
		andShow: [ :a|
			a text
				display: [ :m| model selection: m. '' ] ]
]

{ #category : #initialization }
AAccountsGlamour >> initializeTransmit [
	self initializeAcc1.
	self initializeAcc2.
	self initializeAcc3.
	self initializeAcc4.
	self initializeItems.
	self initializeTmp.
	
]

{ #category : #actions }
AAccountsGlamour >> moveDown: anElement [
	| index |
	index := self accountsList indexOf: anElement.
	(index = (self accountsList size) or: [ index = 0 ])
		ifFalse: [ self accountsList at: index put: (self accountsList at: index + 1).
						self accountsList at: (index + 1) put: anElement ]
]

{ #category : #actions }
AAccountsGlamour >> moveUp: anElement [
	| index |
	index := self accountsList indexOf: anElement.
	(index = 1 or: [ index = 0 ])
		ifFalse: [ self accountsList at: index put: (self accountsList at: index - 1).
						self accountsList at: (index - 1) put: anElement ]
]

{ #category : #initialization }
AAccountsGlamour >> open [
	browser openOn: model.
]
