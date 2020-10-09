Class {
	#name : #ATaskMorphRenderer,
	#superclass : #FMorphRenderer,
	#instVars : [
		'commandMorph'
	],
	#category : #'Accounting-GUI'
}

{ #category : #accessing }
ATaskMorphRenderer >> commandMorph [
	^ commandMorph 	ifNil: [
			commandMorph := Morph new
				layoutPolicy: (FAbsoluteRelativeLayout new direction: #leftDown) ;
				color: Smalltalk ui theme baseColor;
				extent: 10@20;
				hResizing: #spaceFill.
			self owner addMorphBack: commandMorph.
			commandMorph ]
]

{ #category : #rendering }
ATaskMorphRenderer >> render: aModel selector: aSelector [
	self model: aModel.
	self commandMorph.
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
	m label: 'Accept' translated.
	m extent: 100@20.
	self commandMorph addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderAccount [
	| m |
	m := FLabeledText
			on: model
			label: 'Account' translated
			selector: #account.
	m height: 40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderAdditional [
		| m |
	m := FLabeledText
			on: model
			label: 'Additional' translated
			selector: #additional.
	m height: 40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderCompleteTaskButton [
	| m |
	m := PluggableButtonMorph
				on: model
				getState: nil 
				action: #createExecuteTask
				label: #completeTaskButtonName.
	self commandMorph addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderDate [
	| m |
	m := FLabeledText
			on: model
			label: 'Date' translated
			selector: #date.
	m height: 40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderLogin [
	| m |
	m := FLabeledText
			on: model
			label: 'Login' translated
			selector: #login.
	m height: 40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderNumber [
	| m |
	m := FLabeledText
			on: model
			label: 'Number' translated
			selector: #number.
	m height: 40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderOrganization [
	| m |
	m := FLabeledText
			on: model
			label: 'Organization' translated
			selector: #organization.
	m height: 40.
	self owner addMorphBack: m.
]

{ #category : #rendering }
ATaskMorphRenderer >> renderTask [
	| m |
	m := FLabeledText
			on: model
			label: 'Task' translated
			selector: #task.
	m setProperty: #relativeExtent toValue: 1.0@0.01.
	m vResizing: #spaceFill.
	self owner addMorphBack: m.
]
