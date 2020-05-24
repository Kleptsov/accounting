"
Графический интерфейс списания товаров

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AWriteOffGlamour,
	#superclass : #ARecordingOfGlamour,
	#category : #'Accounting-GUI'
}

{ #category : #initialization }
AWriteOffGlamour >> initializeBrowser [
	super initializeBrowser.
	browser title: [ :m| m number, ' ', 'Write-off' translated ].
]
