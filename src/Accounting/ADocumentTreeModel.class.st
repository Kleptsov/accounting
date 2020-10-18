Class {
	#name : #ADocumentTreeModel,
	#superclass : #FMorphTreeModel,
	#category : #'Accounting-Model'
}

{ #category : #'user interface' }
ADocumentTreeModel >> descriptionColumn [
	^ (MorphTreeColumn new
				rowMorphGetSelector: #description;
				headerButtonLabel: 'Description' translated font: nil).
]

{ #category : #'user interface' }
ADocumentTreeModel >> firstColumn [
	^ (MorphTreeColumn new
				startWidth: 30;
				rowMorphGetSelector: #firstName;
				headerButtonLabel: '№' translated font: nil).
]

{ #category : #initialization }
ADocumentTreeModel >> initialize [
	super initialize.
	self  columnLabel: '#' selector: #firstName  morph: [ :v :c| c startWidth: 30. v asString asMorph  ]. 
	self columnLabel: '' selector: #secondName.
]

{ #category : #rendering }
ADocumentTreeModel >> morphController [
	^ FDirectController new
]

{ #category : #rendering }
ADocumentTreeModel >> morphRenderer [
	^ ADocumentTreeRenderer new.
]

{ #category : #rendering }
ADocumentTreeModel >> morphView [
	^ self morphController listen: #yourself from: self.
]

{ #category : #rendering }
ADocumentTreeModel >> morphViewInWindow [
	| m w |
	m := self morphView.
	w := StandardWindow new.
	w addMorph: m frame: LayoutFrame new.
	w open.
	^ m
]

{ #category : #'user interface' }
ADocumentTreeModel >> numberColumn [
	^ (MorphTreeColumn new
				startWidth: 30;
				rowMorphGetSelector: #number;
				headerButtonLabel: '№' translated font: nil).
]

{ #category : #'user interface' }
ADocumentTreeModel >> secondColumn [
	^ (MorphTreeColumn new
				rowMorphGetSelector: #secondName;
				headerButtonLabel: '' translated font: nil).
]
