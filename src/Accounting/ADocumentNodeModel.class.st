Class {
	#name : #ADocumentNodeModel,
	#superclass : #MorphTreeNodeModel,
	#category : #'Accounting-Model'
}

{ #category : #morphs }
ADocumentNodeModel >> description [
	^ ( self theme
			newTextIn: self currentWorld
			text: self item description)
					"unlock; wrapFlag: true;" yourself
]

{ #category : #morphs }
ADocumentNodeModel >> firstName [
	^ self item firstName asMorph
]

{ #category : #morphs }
ADocumentNodeModel >> number [
	^ ( self theme
			newTextIn: self currentWorld
			text: self item number)
					unlock; wrapFlag: true; yourself
]

{ #category : #morphs }
ADocumentNodeModel >> secondName [
	^ self item secondName asMorph
]
