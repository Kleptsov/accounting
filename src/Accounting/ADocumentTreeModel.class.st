Class {
	#name : #ADocumentTreeModel,
	#superclass : #MorphTreeModel,
	#category : #'Accounting-Model'
}

{ #category : #'user interface' }
ADocumentTreeModel >> descriptionColumn [
	^ (MorphTreeColumn new
				rowMorphGetSelector: #description;
				headerButtonLabel: 'Description' translated font: nil).
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
ADocumentTreeModel >> rootNodeClassFromItem: anItem [
	^ ADocumentNodeModel
]

{ #category : #'user interface' }
ADocumentTreeModel >> treeMorph [
	| treeMorph |
	treeMorph := self treeMorphClass new.
	treeMorph
		model: self;
		columns: { self numberColumn. self descriptionColumn };
		makeLastColumnUnbounded;
		withHLines: true;
		allowColumnDrop;
		useSquareCorners;
		"hResizing: #spaceFill;"
		"vResizing: #spaceFill;"
		rowInset: 5;
		columnInset: 5;
		resizerWidth: 4.
	^ treeMorph buildContents
]
