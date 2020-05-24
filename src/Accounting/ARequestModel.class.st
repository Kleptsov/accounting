"
Модель заявки

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ARequestModel,
	#superclass : #AModel,
	#instVars : [
		'number',
		'login',
		'organization',
		'requests',
		'selectionRequest',
		'editor',
		'date'
	],
	#category : #'Accounting-Model'
}

{ #category : #adding }
ARequestModel class >> documents [
	^ AConfig requests2
]

{ #category : #adding }
ARequestModel class >> nextIndex [
	^ AConfig nextRequestIndex2 asString
]

{ #category : #actions }
ARequestModel >> accept [
	| swaps t |
	t := Time millisecondsToRun: 
	[self removeAccounts.
	swaps := self createSwaps.
	self accounts addAll: swaps].
	self log: self number asString, ' request is saved. Milliseconds to run: ', t asString, String cr.
	^ swaps.
]

{ #category : #actions }
ARequestModel >> addAccount1: anArray [
	anArray ifNil: [ ^ self ].
	anArray size < 1 ifTrue: [ ^ self ].
	self organization: (anArray at: 1).
	anArray size < 2 ifTrue: [
		self login: ''.
		^ self ].
	self login: (anArray at: 2).
]

{ #category : #actions }
ARequestModel >> addAccount2: anArray [
]

{ #category : #actions }
ARequestModel >> addRequest [
	self requests
		updateOrAddAmount: (AAmountSwapBuilder new string: self editor; build)
]

{ #category : #accessing }
ARequestModel >> additional [
	^ additional ifNil: [ additional := '' ]
]

{ #category : #accessing }
ARequestModel >> additional: anObject [
	additional := anObject.
	self changed: #additional.
]

{ #category : #configuration }
ARequestModel >> anyOrganization [
	^ self configClass anyOrganization.
]

{ #category : #actions }
ARequestModel >> createContract [
	| cnt |
	cnt := AContractModel addNew.
	cnt organization: self organization.
	cnt additionalNumber: '0'.
	cnt items addAccount: self requests.
	^ cnt
]

{ #category : #actions }
ARequestModel >> createFirsts [
	|firsts|
	firsts := Set new.
	firsts add: (login asString).
	firsts add: (organization asString).
	firsts addAll: (ADateTagsBuilder new date: self date; build).
	^ firsts.
]

{ #category : #actions }
ARequestModel >> createSeconds [
	|seconds|
	seconds := Set new.
	seconds add: self anyOrganization.
	seconds addAll: (ADateTagsBuilder new date: self date; build).
	^ seconds
]

{ #category : #actions }
ARequestModel >> createSwaps [
	| s acc |
	
	s := AVirtualSwapBuilder new.
	s common add: self numberPrefix, self number.
	s right add: self requestName.
	s left add: self requestObligationName.
	s first addAll: self createFirsts.
	s second addAll: self createSeconds.
	s swaps: requests.
	acc := s build.
	^ acc
]

{ #category : #accessing }
ARequestModel >> date [
	^ date ifNil: [ date := self today ]
]

{ #category : #accessing }
ARequestModel >> date: anObject [
	date := anObject.
	self changed: #date.
]

{ #category : #actions }
ARequestModel >> downItem: aSwap [
	self requests downAmount: aSwap.
]

{ #category : #accessing }
ARequestModel >> editor [
	^ editor ifNil: [ editor := '' ]
]

{ #category : #accessing }
ARequestModel >> editor: anObject [
	editor := anObject.
	self changed: #editor.
]

{ #category : #actions }
ARequestModel >> keyAccounts [

	^ { AAccount new
			addAll: { self requestName. self numberPrefix, self number };
			yourself.
	AAccount new
			addAll: { self requestObligationName. self numberPrefix, self number };
			yourself. }
]

{ #category : #accessing }
ARequestModel >> login [
	^ login ifNil: [ login := '' ]
]

{ #category : #accessing }
ARequestModel >> login: anObject [
	login := anObject.
	self changed: #login.
]

{ #category : #accessing }
ARequestModel >> number [
	^ number ifNil: [ number := '' ]
]

{ #category : #accessing }
ARequestModel >> number: anObject [
	number := anObject.
	self changed: #number.
]

{ #category : #configuration }
ARequestModel >> numberPrefix [
	^ self configClass numberPrefix.
]

{ #category : #actions }
ARequestModel >> open [
	^ ARequestGlamour openOn: self
]

{ #category : #accessing }
ARequestModel >> organization [
	^ organization ifNil: [ organization := '' ]
]

{ #category : #accessing }
ARequestModel >> organization: anObject [
	organization := anObject.
	self changed: #organization.
]

{ #category : #actions }
ARequestModel >> removeAccounts [
	self keyAccounts do: [ :el| 
		self accounts remove: el.	
	].
]

{ #category : #actions }
ARequestModel >> removeRequest [
	self requests removeAmount: self selectionRequest
]

{ #category : #configuration }
ARequestModel >> requestName [
	^ self configClass requestName.
]

{ #category : #configuration }
ARequestModel >> requestObligationName [
	^ self configClass requestObligationName.
]

{ #category : #accessing }
ARequestModel >> requests [
	^ requests ifNil: [ requests := AAccount new ]
]

{ #category : #accessing }
ARequestModel >> requests: anObject [
	requests := anObject.
]

{ #category : #accessing }
ARequestModel >> selectionRequest [
	^ selectionRequest
]

{ #category : #accessing }
ARequestModel >> selectionRequest: anObject [
	selectionRequest := anObject.
	self changed: #selectionRequest.
]

{ #category : #actions }
ARequestModel >> upItem: aSwap [
	self requests upAmount: aSwap.
]
