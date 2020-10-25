Class {
	#name : #ATaskMorphRenderer,
	#superclass : #FMorphRenderer,
	#instVars : [
		'commandPanel'
	],
	#category : #'Accounting-GUI-Facing'
}

{ #category : #accessing }
ATaskMorphRenderer >> commandPanel [
	^ commandPanel 	ifNil: [
			commandPanel := Morph new
				layoutPolicy: (FAbsoluteRelativeLayout new direction: #rightDown) ;
				color: Smalltalk ui theme baseColor;
				extent: 10@20;
				hResizing: #spaceFill.
			self owner addMorphBack: commandPanel.
			commandPanel ]
]

{ #category : #rendering }
ATaskMorphRenderer >> render [
	self commandPanel.
	self renderAccepted.
	self renderCompleteTaskButton.
	self renderNumber.
	self renderDate.
	self renderOrganization.
	self renderLogin.
	self renderAccount.
	self renderAdditional.
	self renderTask.
	^ self owner.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderAccepted [
	| m |
	m := CheckboxMorph
				on: model
				selected: #accepted
				changeSelected: #accepted:.
	m extent: 20@20.
	self commandPanel addMorphBack: m.
	self commandPanel addMorphBack: (model class baseTitle translated asMorph).
]

{ #category : #rendering }
ATaskMorphRenderer >> renderAccount [
	| m |
	m := FText
			on: model
			label: 'Account' translated
			selector: #account.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderAdditional [
		| m |
	m := FText
			on: model
			label: 'Additional' translated
			selector: #additional.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderCompleteTaskButton [
	| m |
	m := PluggableButtonMorph
				on: model
				getState: nil 
				action: #createAndOpenExecuteTask
				label: #completeTaskButtonName.
	self commandPanel addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderDate [
	| m |
	m := FText
			on: model
			label: 'Date' translated
			selector: #date.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderLogin [
	| m |
	m := FText
			on: model
			label: 'Login' translated
			selector: #login.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderNumber [
	| m |
	m := FText
			on: model
			label: 'Number' translated
			selector: #number.
	m extent: 150@40.
	self owner addMorphBack: m.	
]

{ #category : #rendering }
ATaskMorphRenderer >> renderOrganization [
	| m |
	m := FText
			on: model
			label: 'Organization' translated
			selector: #organization.
	m extent: 150@40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderTask [
	| m |
	m := FText
			on: model
			label: 'Task' translated
			selector: #task.
	m setProperty: #relativeExtent toValue: 1.0@0.01.
	m vResizing: #spaceFill.
	self owner addMorphBack: m.
]
