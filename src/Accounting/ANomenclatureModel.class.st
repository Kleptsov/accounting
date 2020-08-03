Class {
	#name : #ANomenclatureModel,
	#superclass : #AModel,
	#category : #'Accounting-Model'
}

{ #category : #adding }
ANomenclatureModel class >> documents [
	^ AConfig nomenclatures
]

{ #category : #adding }
ANomenclatureModel class >> nextIndex [
	^ AConfig nextNomenclatureIndex
]
