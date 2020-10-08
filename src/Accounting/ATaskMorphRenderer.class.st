Class {
	#name : #ATaskMorphRenderer,
	#superclass : #FMorphRenderer,
	#category : #'Accounting-GUI'
}

{ #category : #rendering }
ATaskMorphRenderer >> render: aModel selector: aSelector [
	self model: aModel.
	self renderAccepted.
	self renderExecuteTask.
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
	m extent: 300@20.
	m hResizing: #spaceFill.
	self owner addMorphBack: m.
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
ATaskMorphRenderer >> renderExecuteTask [
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
