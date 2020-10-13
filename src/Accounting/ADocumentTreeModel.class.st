Class {
	#name : #ADocumentTreeModel,
	#superclass : #MorphTreeModel,
	#category : #'Accounting-Model'
}

{ #category : #'user interface' }
ADocumentTreeModel >> descriptionColumn [
	^ (MorphTreeColumn new
				rowMorphGetSelector: #description;
				headerButtonLabel: 'Description' translated
					font: nil
					icon: (self iconNamed: #smallOpenIcon)
					target: nil
					actionSelector: nil
					arguments: #()).
]

{ #category : #rendering }
ADocumentTreeModel >> morphController [
	^ FDirectController new
]

{ #category : #rendering }
ADocumentTreeModel >> morphRenderer [
	^ FExample1Renderer new selector: #yourself.
]

{ #category : #rendering }
ADocumentTreeModel >> morphView [
	^ self morphController updateModel: self.
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
				headerButtonLabel: 'Number' translated
					font: nil
					icon: (self iconNamed: #smallOpenIcon)
					target: nil
					actionSelector: nil
					arguments: #()).
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
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		rowInset: 5;
		columnInset: 5;
		resizerWidth: 4.
	^ treeMorph buildContents
]
