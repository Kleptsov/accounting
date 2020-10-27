Class {
	#name : #AReturnAnswer,
	#superclass : #Object,
	#instVars : [
		'currentProcess',
		'result'
	],
	#category : #'Accounting-Core'
}

{ #category : #accessing }
AReturnAnswer >> return: aResult [.
	result := aResult.
	currentProcess resume.
]

{ #category : #accessing }
AReturnAnswer >> waitAnswer [
	currentProcess := Processor activeProcess.
	currentProcess suspend.
	^ result.
]
