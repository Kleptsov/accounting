Class {
	#name : #ACompletedTaskRenderer,
	#superclass : #ATaskMorphRenderer,
	#category : #'Accounting-GUI-Facing'
}

{ #category : #rendering }
ACompletedTaskRenderer >> render [
	self commandPanel.
	self renderAccepted.
	self renderNumber.
	self renderDate.
	self renderOrganization.
	self renderLogin.
	self renderAccount.
	self renderAdditional.
	self renderPercent.
	self renderTask.
	^ self owner.
]

{ #category : #rendering }
ACompletedTaskRenderer >> renderPercent [
	| m |
	m := FText
			on: model
			label: 'Percent' translated
			selector: #percent.
	m extent: 150@40.
	self owner addMorphBack: m.
]
