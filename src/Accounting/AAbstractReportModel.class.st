"
Суперкласс для всех моделей отчета

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #AAbstractReportModel,
	#superclass : #Object,
	#category : #'Accounting-Report'
}

{ #category : #configuration }
AAbstractReportModel >> accounts [
	^ self configClass accounts
]

{ #category : #configuration }
AAbstractReportModel >> additionalNumberPrefix [
	^ self configClass additionalNumberPrefix
]

{ #category : #configuration }
AAbstractReportModel >> configClass [
	^ AConfig
]

{ #category : #configuration }
AAbstractReportModel >> contractObligationName [
	^ self configClass contractObligationName
]

{ #category : #configuration }
AAbstractReportModel >> dayPrefix [
	^ self configClass dayPrefix
]

{ #category : #configuration }
AAbstractReportModel >> executeTaskName [
	^ self configClass executeTaskName
]

{ #category : #configuration }
AAbstractReportModel >> invoiceName [
	^ self configClass invoiceName
]

{ #category : #configuration }
AAbstractReportModel >> monthPrefix [
	^ self configClass monthPrefix
]

{ #category : #configuration }
AAbstractReportModel >> numberPrefix [
	^ self configClass numberPrefix
]

{ #category : #configuration }
AAbstractReportModel >> paymentName [
	^ self configClass paymentName
]

{ #category : #configuration }
AAbstractReportModel >> swapName [
	^ self configClass swapName
]

{ #category : #configuration }
AAbstractReportModel >> taskName [
	^ self configClass taskName
]

{ #category : #configuration }
AAbstractReportModel >> today [
	^ (Date today printFormat: #(1 2 3 $. 1 1 2) )
]

{ #category : #configuration }
AAbstractReportModel >> yearPrefix [
	^ self configClass yearPrefix
]
