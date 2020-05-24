"
Графический интерфейс выбора счета

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AListDialogWindow,
	#superclass : #ListDialogWindow,
	#category : #'Accounting-GUI'
}

{ #category : #'as yet unclassified' }
AListDialogWindow class >> selectItemFrom: aCollection [
	^ self new
			title: 'Select item' translated;
			getList: [ :l| aCollection ];
			openModal;
			answer.
]

{ #category : #actions }
AListDialogWindow >> newButtons [
	"Answer new buttons as appropriate."

	^{self newOKButton isDefault: true. self newCancelButton}
]

{ #category : #'instance creation' }
AListDialogWindow >> newContentMorph [
	| panel  |
	panel := PanelMorph new.
	panel layoutPolicy: ProportionalLayout new;
		layoutInset: 0;
		hResizing: #spaceFill;
		vResizing: #spaceFill.					
	panel addMorph: self buildListMorph
			fullFrame: (LayoutFrame identity bottomOffset: 0 "-33").
	^ panel
]
