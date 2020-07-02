"
Сгрупированные отчеты по договорам

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	contractReport:		<Object>


    Implementation Points
"
Class {
	#name : #ACommonContractReportGlamour2,
	#superclass : #AGlamour,
	#instVars : [
		'contractReport'
	],
	#classInstVars : [
		'model',
		'browser'
	],
	#category : #'Accounting-GUI'
}

{ #category : #intialization }
ACommonContractReportGlamour2 >> initialize [
	super initialize.
	contractReport := AContractReportModel new.
	self initializeBrowser.
	self initializeTransmit.
]

{ #category : #intialization }
ACommonContractReportGlamour2 >> initializeBrowser [
	browser := GLMTabulator new.
	browser column: #reports.
]

{ #category : #intialization }
ACommonContractReportGlamour2 >> initializeReports [
	browser transmit to: #reports;
		andShow: [ :a|
			self obligationIn: a ] 
]

{ #category : #intialization }
ACommonContractReportGlamour2 >> initializeTransmit [
	self initializeReports.
]

{ #category : #intialization }
ACommonContractReportGlamour2 >> obligationIn: aComposer [
	aComposer dynamic 
				display: [ :d|
					AContractReportGlamour new browser
							entity: contractReport;
							yourself ].
]

{ #category : #opening }
ACommonContractReportGlamour2 >> open [
	browser openOn: model.
]
