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
	#name : #AKassaGlamour,
	#superclass : #AGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
AKassaGlamour >> initialize [
	super initialize.
	self initializeBrowser.
	self initializeKassa.
]

{ #category : #initialization }
AKassaGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser transformation: [ :m| self model: m. m ].
	browser title: [:m| 'kassa'].

	browser row: #kassa .
]

{ #category : #initialization }
AKassaGlamour >> initializeKassa [
	(browser transmit) to: #kassa;
		andShow: [ :a|
			a custom: (AKassaCheckGlamour new rootBrowser: browser; browser).
			a custom: (AKassaSettingGlamour new rootBrowser: browser; browser) ].
]

{ #category : #initialization }
AKassaGlamour >> open [
	browser openOn: model.
]
