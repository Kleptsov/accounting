"
Графический интерфейс заявки

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ARequestGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #actions }
ARequestGlamour >> downSelectionFrom: aPresentation [
	| aSwap |
	aSwap := (aPresentation pane port: #selection) value.
	model downItem: aSwap.
]

{ #category : #initialization }
ARequestGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #initialization }
ARequestGlamour >> initializeAdditianal [
	(browser transmit) to: #additional;
		andShow: [ :a|
			a text
				title: 'Additional' translated;
				onChangeOfPort: #text act: [ :tp| model additional: tp text asString ];
				display: [ :m| m additional ] ].

]

{ #category : #initialization }
ARequestGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser transformation: [ :m| self model: m. m ].
	self initializeBrowserActions.
	browser title: [:m| m number, ' ', 'Request' translated].
	browser row: #tmp size: 0.
	browser row: [ :r|
		r column: #accepted.
		r column: #number.
		r column: #organization ] size: 68.
	browser row: [ :r|
		r column: #login.
		r column: #date.
	] size: 68.
	browser row: #exchange size: 0.
	browser row: [ :r| 
		r column: #additional.] size: 68.
	browser row: #editor size: 35.
	browser row: #requests.
]

{ #category : #initialization }
ARequestGlamour >> initializeBrowserActions [	
	browser act: [ :p|
		Clipboard clipboardText: model requests printCSV. self inform: 'copy to clipboard' ]
		icon: GLMUIThemeExtraIcons glamorousSave
		entitled: 'Copy to Clipboard' translated.
		
	browser act: [ :p|
		model addAccount1:(AListDialogWindow selectItemFrom: AConfig accountsList).
						p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousInto
		entitled: 'Add Account 1' translated.
		
	browser act: [ :p|
			model removeAccounts.
			p update; updateToolbar ]
		icon: GLMUIThemeExtraIcons glamorousUndo
		entitled: 'Unwire' translated.
		
	browser
		act: [ :p| model createContract open ]
		icon: GLMUIThemeExtraIcons glamorousBrowse
		entitled: 'New Contract' translated.
		
	browser
		act: [ :p| (p pane port: #entity) value accept]
		icon: GLMUIThemeExtraIcons glamorousAccept
		entitled: 'Accept' translated.
]

{ #category : #initialization }
ARequestGlamour >> initializeDate [
	(browser transmit) to: #date;
		andShow: [ :a|
			a text
				title: '* ', 'Date' translated;
				onChangeOfPort: #text act: [ :tp| model date: tp text asString ];
				display: [ :m| m date ] ].
]

{ #category : #initialization }
ARequestGlamour >> initializeEditor [
	"display first"
	(browser transmit) to: #editor;
		andShow: [ :a|
			a text
				onChangeOfPort: #text act: [ :textPresentation | 
					model editor: textPresentation text asString ];
				display: [ :m| m editor ]
		].
	
	"display when select an item"
	(browser transmit) to: #editor; from: #requests; from: #tmp;
		andShow: [ :a|
			a text
				onChangeOfPort: #text act: [ :tp | model editor: tp text asString ];
				display: [ :t :t1| t ]; allowNil.
				
			a text
				onChangeOfPort: #text act: [ :tp | model editor: tp text asString ];
				display: [ :t :t1| '' ]; allowAllNil ].
]

{ #category : #initialization }
ARequestGlamour >> initializeLogin [
	(browser transmit) to: #login;
		andShow: [ :a|
			a text
				title: '* ', 'Login' translated;
				onChangeOfPort: #text act: [ :tp| model login: tp text asString ];
				display: [ :m| m login ] ]
]

{ #category : #initialization }
ARequestGlamour >> initializeNumber [
	(browser transmit) to: #number;
		andShow: [ :a|
			a text
				title: '* ', 'Number' translated;
				onChangeOfPort: #text act: [ :tp| model number: tp text asString ];
				display: [ :m| m number ] ].
]

{ #category : #initialization }
ARequestGlamour >> initializeOrganization [
	(browser transmit) to: #organization;
		andShow: [ :a|
			a text
				title: '* ', 'Organization' translated;
				onChangeOfPort: #text act: [ :tp| model organization: tp text asString ];
				display: [ :m| m organization ] ]
]

{ #category : #initialization }
ARequestGlamour >> initializeRequests [
	(browser transmit) to: #requests;
		andShow: [ :a|
			a fastTable
			
				title: '* ', 'Requests' translated;
				
				act: [ :p| self upSelectionFrom: p. p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousUp
				entitled: 'Up' translated;
				
				act: [ :p| self downSelectionFrom: p. p update; updateToolbar ]
				icon: GLMUIThemeExtraIcons glamorousDown
				entitled: 'Down' translated;
				
				act: [:p| (p pane port: #entity) value addRequest.
							p update ]
				icon: GLMUIThemeExtraIcons glamorousAdd
				entitled: 'Add' translated;
				
				act: [ :p| (p pane port: #entity) value removeRequest. "model removeRequest"
							p update ]
				icon: GLMUIThemeExtraIcons glamorousRemove
				entitled: 'Remove' translated;

				display: [ :m| m requests sortByPostTime ];
				column: 'Count' translated evaluated: [ :each| each amount ] width: 100;
				column: 'Goodies' translated evaluated: [ :each| each printTags ] width: 200;
				column: 'Sum' translated evaluated: [ :each| each swapAmount amount ] width: 100;
				column: 'Currency' translated evaluated: [ :each| each swapAmount printTags ] width: 100;
				column: 'Unix Time' translated evaluated: [ :each| each unixTime ] width: 50 ].
]

{ #category : #initialization }
ARequestGlamour >> initializeTmp [
	"(browser transmit) to: #tmp;
		andShow: [ :a|
			a text
				display: [ :m| '' ]
		]."
	
	(browser transmit) to: #tmp; from: #requests port: #selection;
		andShow: [ :a| a text display: [ :sel| model selectionRequest: sel. '' ] ]
]

{ #category : #initialization }
ARequestGlamour >> initializeTransmit [
	self initializeAccepted.
	self initializeNumber.
	self initializeOrganization.
	self initializeLogin.
	self initializeEditor.
	self initializeRequests.
	self initializeAdditianal.
	self initializeDate.
	self initializeTmp
]

{ #category : #initialization }
ARequestGlamour >> open [
	browser openOn: model.
]

{ #category : #actions }
ARequestGlamour >> upSelectionFrom: aPresentation [
	| aSwap |
	aSwap := (aPresentation pane port: #selection) value.
	model upItem: aSwap.
]
