"
Проверка методов класса AbstractAccountTest

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AbstractAccountTest,
	#superclass : #TestCase,
	#category : #'Accounting-Tests'
}

{ #category : #tests }
AbstractAccountTest >> testAdd [
	| a |
	
	a := AbstractAccount new.
	a add: 'acc1'.
	
	self assert: (a like: 'acc1') equals: 'acc1'.
	self assert: (a like: 'acc2') equals: nil.
	self assert: (a symbolHash) equals: #'==>acc1'.
	
	a add: 'acc2'.
	
	self assert: (a like: 'acc2') equals: 'acc2'.
	self assert: (a symbolHash) equals: #'==>acc1==>acc2'
]

{ #category : #tests }
AbstractAccountTest >> testEqual [
	| a b |
	a := AbstractAccount new.
	a add: 'acc1'; add: 'acc2'; add: 'acc3'.
	
	b := AbstractAccount new.
	b add: 'acc1'; add: 'acc2'; add: 'acc3'.
	
	self assert: (a = b) equals: true.
	
	b add: 'acc4'.
	
	self assert: (a = b) equals: false.
]
