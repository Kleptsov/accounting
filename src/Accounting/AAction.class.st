"
Действия в графическом интерфейсе

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AAction,
	#superclass : #Object,
	#category : #'Accounting-GUI'
}

{ #category : #visiting }
AAction class >> accept: aBlock [
	^ GLMGenericAction new
		action: aBlock;
		icon: GLMUIThemeExtraIcons glamorousAccept;
		title: 'Accept' translated
]

{ #category : #enumerating }
AAction class >> accumulate: aBlock [
	^ GLMGenericAction new
		action: aBlock;
		icon: ' accumulate ' asMorph imageForm;
		title: 'accumulate'
]

{ #category : #'ui requests' }
AAction class >> edit: aBlock [
	^ GLMGenericAction new
		action: aBlock;
		icon: GLMUIThemeExtraIcons glamorousEdit;
		title: 'plus'.
]

{ #category : #'as yet unclassified' }
AAction class >> minus: aBlock [
	^ GLMGenericAction new
		action: aBlock;
		icon: GLMUIThemeExtraIcons glamorousRemove;
		title: 'minus'
]

{ #category : #visiting }
AAction class >> newExecuteTask: aBlock [
	^ GLMGenericAction new
		action: aBlock;
		icon: GLMUIThemeExtraIcons glamorousBrowse;
		title: 'New Execute Task' translated
]

{ #category : #enumerating }
AAction class >> openReport: aBlock [
	^ GLMGenericAction new
		action: aBlock;
		"icon: ' open report ' asMorph imageForm;"
		icon: GLMUIThemeExtraIcons glamorousBookmark;
		title: 'Open Report' translated
]

{ #category : #'as yet unclassified' }
AAction class >> plus: aBlock [
	^ GLMGenericAction new
		action: aBlock;
		icon: GLMUIThemeExtraIcons glamorousAdd;
		title: 'plus'.
]

{ #category : #enumerating }
AAction class >> select: aBlock [
	^ GLMGenericAction new
		action: aBlock;
		icon: (' ', 'Select' translated,' ') asMorph imageForm;
		title: 'Select' translated
]

{ #category : #enumerating }
AAction class >> strongAccumulate: aBlock [
	^ GLMGenericAction new
		action: aBlock;
		icon: ' strong accumulate ' asMorph imageForm;
		title: 'strong accumulate'
]

{ #category : #enumerating }
AAction class >> sum: aBlock [
	^ GLMGenericAction new
		action: aBlock;
		icon: ' sum ' asMorph imageForm;
		title: 'sum'
]
