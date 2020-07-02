"
Сгрупированные отчеты по обменным операциям

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	swapReport:		<Object>


    Implementation Points
"
Class {
	#name : #ACommonSwapReportGlamour,
	#superclass : #AGlamour,
	#instVars : [
		'swapReport'
	],
	#classInstVars : [
		'model',
		'browser'
	],
	#category : #'Accounting-GUI'
}

{ #category : #intialization }
ACommonSwapReportGlamour >> initialize [
	super initialize.
	swapReport := ASwapReportModel new.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
ACommonSwapReportGlamour >> initializeBrowser [
	browser := GLMTabulator new.
	browser title: 'Swap Reports' translated.
	browser column: #reports
]

{ #category : #intialization }
ACommonSwapReportGlamour >> initializeReports [
	browser transmit to: #reports;
		andShow: [ :a|
			self obligationIn: a ] 
]

{ #category : #intialization }
ACommonSwapReportGlamour >> initializeTransmit [
	self initializeReports.
]

{ #category : #intialization }
ACommonSwapReportGlamour >> obligationIn: aComposer [
	aComposer dynamic 
				display: [ :d|
					ASwapReportGlamour new browser
							entity: swapReport;
							yourself ].
]

{ #category : #opening }
ACommonSwapReportGlamour >> open [
	browser openOn: model.
]
