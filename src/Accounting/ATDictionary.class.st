"
Словарь для перевода графического интерфейса

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.


    Implementation Points
"
Class {
	#name : #ATDictionary,
	#superclass : #Object,
	#category : #'Accounting-Config'
}

{ #category : #cleaning }
ATDictionary class >> cleanUp [
]

{ #category : #updating }
ATDictionary class >> dictionary [
	^ Smalltalk
		at: #ATranslatorDictionary
		ifAbsentPut: Dictionary new.
]

{ #category : #updating }
ATDictionary class >> disable [
	NaturalLanguageTranslator current: nil.
]

{ #category : #updating }
ATDictionary class >> enable [
	NaturalLanguageTranslator current: ATDictionary new.
]

{ #category : #updating }
ATDictionary class >> update [
	self new update
]

{ #category : #'accessing structure variables' }
ATDictionary >> a [
	^ { 
'Accounts List' -> { 'ru' -> 'Список счетов' } asDictionary.
'Accounting Launcher' -> { 'ru' -> 'Панель управления счетами' } asDictionary.
'Account' -> { 'ru' -> 'Счет' } asDictionary.
'Acquirer' -> { 'ru' -> 'Покупатель' } asDictionary.
'Acquirer Sum' -> { 'ru' -> 'Сумма покупателя' } asDictionary.
'Acquirer Account' -> { 'ru' -> 'Счет покупателя' } asDictionary.
'Accepted Document' -> { 'ru' -> 'Документ проведен' } asDictionary.
'Add' -> { 'ru' -> 'Добавить' } asDictionary.
'Additional' -> { 'ru' -> 'Дополнительно' } asDictionary.
'Additional Number' -> { 'ru' -> 'Номер дополнительного соглашения' } asDictionary.
'Add Account 1' -> { 'ru' -> 'Установить первый счет' } asDictionary.
'Add Account 2' -> { 'ru' -> 'Установить второй счет' } asDictionary.
'Added as' -> { 'ru' -> 'добавлен в качестве' } asDictionary.
'Accept' -> { 'ru' -> 'Провести' } asDictionary.
'Amount' -> { 'ru' -> 'Количество' } asDictionary.
'Add Barcode' -> { 'ru' -> 'Добавить штрихкод' } asDictionary.
		
	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> b [
	^ { 
'Base Currency' -> { 'ru' -> 'Базовая валюта' } asDictionary.
'Barcode' -> { 'ru' -> 'Штрихкод' } asDictionary.
	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> c [
	^ {
'Change' -> { 'ru' -> 'Сдача' } asDictionary.
'Check' -> { 'ru' -> 'Чек' } asDictionary.
'Check Document Journal' -> { 'ru' -> 'Журнал кассовых чеков' } asDictionary.
'Clone' -> { 'ru' -> 'Клонировать' } asDictionary.
'Contract' -> { 'ru' -> 'Договор' } asDictionary.
'Contract Changing' -> { 'ru' -> 'Изменения по контракту' } asDictionary.
'Contract Journal' -> { 'ru' -> 'Журнал контрактов' } asDictionary.
'Contract Number' -> { 'ru' -> 'Номер договора'} asDictionary.
'Contract Report' -> { 'ru' -> 'Отчет по контрактам' } asDictionary.
'Common Report' -> { 'ru' -> 'Общий отчет' } asDictionary.
'Complete Task' -> { 'ru' -> 'Завершить задачу' } asDictionary.
'Contracts' -> { 'ru' -> 'Контракты' } asDictionary.
'Contractor' -> { 'ru' -> 'Контрагент' } asDictionary.
'Contractor Account' -> { 'ru' -> 'Счет поставщика' } asDictionary.
'Copy to Clipboard' -> { 'ru' -> 'Скопировать в буфер обмена' } asDictionary.
'Copy Prices Document' -> { 'ru' -> 'Скопировать документ цен' } asDictionary.
'Count' -> { 'ru' -> 'Кол-во' } asDictionary.
'Currency' -> { 'ru' -> 'Валюта' } asDictionary.
'Currency Name' -> { 'ru' -> 'Название валюты'} asDictionary.
'Create Write-off Document' -> { 'ru' -> 'Создать документ списания' } asDictionary.
'Create Transfer Document' -> { 'ru' -> 'Создать документ перемещения' } asDictionary.
'Create Recoring of Document' -> { 'ru' -> 'Создать документ оприходывания' } asDictionary.
	 } asDictionary
]

{ #category : #cleaning }
ATDictionary >> cleanUp [
]

{ #category : #'accessing structure variables' }
ATDictionary >> d [
	^ { 
'Dictionary' -> { 'ru' -> 'Словарь' } asDictionary.
'Date' -> { 'ru' -> 'Дата' } asDictionary.
'Down' -> { 'ru' -> 'Вниз' } asDictionary.
'Document Journal' -> { 'ru' -> 'Журнал документов' } asDictionary.
'dd:mm:yyyy' -> { 'ru' -> 'дд:мм:гггг' } asDictionary.
'Day' -> { 'ru' -> 'День'} asDictionary.
'Destination' -> { 'ru' -> 'Место назначение' } asDictionary.
'Destination Account' -> { 'ru' -> 'Счет места назначения' } asDictionary.
	 } asDictionary
]

{ #category : #accessing }
ATDictionary >> dictionary [
	^ Smalltalk
		at: #ATranslatorDictionary
		ifAbsentPut: Dictionary new.
]

{ #category : #'accessing structure variables' }
ATDictionary >> e [
	^ { 
'Execute Task Journal' -> { 'ru' -> 'Журнал выполненных задач' } asDictionary.
'Execute Tasks' -> { 'ru' -> 'Выполненные задачи' } asDictionary.
'Execute Task Account' -> { 'ru' -> 'Счет выполненных задач' } asDictionary.
'Execute Task' -> { 'ru' -> 'Выполненная задача'} asDictionary.
'Percent' -> { 'ru' -> 'Процент'} asDictionary.
	 } asDictionary
"'' -> { 'ru' -> ''} asDictionary."
]

{ #category : #'accessing structure variables' }
ATDictionary >> f [
	^ { 

	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> g [
	^ { 
'Goodies' -> { 'ru' -> 'Товар' } asDictionary.
'Goodies or Currency' -> { 'ru' -> 'Товар или валюта' } asDictionary.
	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> h [
	^ { 

	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> i [
	^ { 
'Invoice Journal' -> { 'ru' -> 'Журнал накладных' } asDictionary.
'Items' -> { 'ru' -> 'Список элементов' } asDictionary.
'Invoices' -> { 'ru' -> 'Накладная' } asDictionary.
'Invoice' -> { 'ru' -> 'Накладная' } asDictionary.

	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> j [
	^ { 
'Journal' -> { 'ru' -> 'Журнал' } asDictionary.

	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> k [
	^ { 
'Kassa' -> { 'ru' -> 'Касса' } asDictionary.
'Kassa Checks' -> { 'ru' -> 'Кассовые чеки' } asDictionary.
'Kassa Settings' -> { 'ru' -> 'Настройки кассы' } asDictionary.
'Key' -> { 'ru' -> 'Ключ' } asDictionary.
	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> l [
	^ { 
'Login' -> { 'ru' -> 'Логин' } asDictionary.

	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> m [
	^ { 
'Move item up' -> { 'ru' -> 'Переместить элемент вверх' } asDictionary.
'Move item down' -> { 'ru' -> 'Переместить элемент вниз' } asDictionary.
'Make Report' -> { 'ru' -> 'Сделать отчет'} asDictionary.
'Month' -> { 'ru' -> 'Месяц'} asDictionary.
'Make Execute Task' -> { 'ru' -> 'Сделать задачу'} asDictionary.
	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> n [
	^ { 
'New' -> { 'ru' -> 'Новый' } asDictionary.
'New Contract' -> { 'ru' -> 'Новый контракт' } asDictionary.
'New Invoice' -> { 'ru' -> 'Новая накладная' } asDictionary.
'New Payment' -> { 'ru' -> 'Новая платежка' } asDictionary.
'New Prices' -> { 'ru' -> 'Новые цены' } asDictionary.
'New Recording of' -> { 'ru' -> 'Оприходывание' } asDictionary.
'New Write-off' -> { 'ru' -> 'Списание' } asDictionary.
'New Transfer' -> { 'ru' -> 'Новое перемещение' } asDictionary.
'Number' -> { 'ru' -> 'Номер' } asDictionary.
'New Execute Task' -> { 'ru' -> 'Новая выполненная задача' } asDictionary.

	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> o [
	^ {
'Opan All Changing of Document' -> { 'ru' -> 'Открыть все изменения контракта' } asDictionary.
'Open Kassa' -> { 'ru' -> 'Открыть кассу' } asDictionary.
'Obligation Contract Report' -> { 'ru' -> 'Отчет по обязательствам договора' } asDictionary.
'Organization' -> { 'ru' -> 'Организация' } asDictionary.
'Organization Account' -> { 'ru' -> 'Счет организации' } asDictionary.
'Organizer' -> { 'ru' -> 'Органайзер' } asDictionary.
	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> p [
	^ { 
'Payment' -> { 'ru' -> 'Платежка' } asDictionary.
'Payment Journal' -> { 'ru' -> 'Журнал платежек' } asDictionary.
'Price Account' -> { 'ru' -> 'Счет цен' } asDictionary.
'Price Document Journal' -> { 'ru' -> 'Журнал документов цен' } asDictionary.
'Payments' -> { 'ru' -> 'Платежки'} asDictionary.
'Price Document' -> { 'ru' -> 'Журнал цен' } asDictionary.
'Price' -> { 'ru' -> 'Цена' } asDictionary.
'Prices' -> { 'ru' -> 'Цены' } asDictionary.
	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> q [
	^ { 


	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> r [
	^ { 
'Receipt Name' -> { 'ru' -> 'Название расписки' } asDictionary.
'Request' -> { 'ru' -> 'Заявка' } asDictionary.
'Retail' -> { 'ru' -> 'Розница' } asDictionary.
'Report' -> { 'ru' -> 'Отчет' } asDictionary.
'Reports' -> { 'ru' -> 'Отчеты' } asDictionary.
'Request Journal' -> { 'ru' -> 'Журнал заявок' } asDictionary.
'Request Report' -> { 'ru' -> 'Отчет по заявкам' } asDictionary.
'Recording of Journal' -> { 'ru' -> 'Журнал оприходываний' } asDictionary.
'Remove' -> { 'ru' -> 'Удалить' } asDictionary.
'Request Account' -> { 'ru' -> 'Счет заявки'} asDictionary.
'Requests' -> { 'ru' -> 'Заявки'} asDictionary.
'Recording of' -> { 'ru' -> 'Оприходывание' } asDictionary.
	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> s [
	^ { 
'Select' -> { 'ru' -> 'Выбрать' } asDictionary.
'Select a Document from the List' -> { 'ru' -> 'Выберите документ из списка' } asDictionary. 
'Select a Task' -> { 'ru' -> 'Выберите задачу' } asDictionary.
'Select a Invoice' -> { 'ru' -> 'Выберите платежку' } asDictionary.
'Sum' -> { 'ru' -> 'Сумма' } asDictionary.
'Select a Contract' -> { 'ru' -> 'Выберите контракт в списке' } asDictionary.
'Swap Report' -> { 'ru' -> 'Отчет по обменам' } asDictionary.
'Swap Reports' -> { 'ru' -> 'Отчеты по обменам' } asDictionary.
'Swap' -> { 'ru' -> 'Обмен' } asDictionary.
'Swaps' -> { 'ru' -> 'Обмены' } asDictionary.
'Store' -> { 'ru' -> 'Склад' } asDictionary.
'Select an Item from Report List' -> { 'ru' -> 'Выберите элемент из списка отчета' } asDictionary.
'Selected Task' -> { 'ru' -> 'Выбранная задача'} asDictionary.
'Select a Request' -> { 'ru' -> 'Выберите заявку'} asDictionary.
'Selected Item' -> { 'ru' -> 'Выбранный элемент'} asDictionary.
'Select a Payment' -> { 'ru' -> 'Выберите платежку'} asDictionary.
'Additional Contract Number' -> { 'ru' -> 'Номер дополнительного соглашения' } asDictionary.
'Select a Transfer Document' -> { 'ru' -> 'Выберите документ перемещения' } asDictionary.
'Source Account' -> { 'ru' -> 'Счет источник' } asDictionary.
'Select a Recording of Document' -> { 'ru' -> 'Выберите документ оприходывания' } asDictionary.
'Swap Journal' -> { 'ru' -> 'Журнал бартера (обмена)' } asDictionary.
'Select a Swap' -> { 'ru' -> 'Выберить бартер (обмен)' } asDictionary.
'Swap Number' -> { 'ru' -> 'Номер бартера (обмена)' } asDictionary.
'Select a Price Document' -> { 'ru' -> 'Выберите документ цен' } asDictionary.
'Search' -> { 'ru' -> 'Поиск' } asDictionary.
'Selector' -> { 'ru' -> 'Выбор' } asDictionary.
	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> t [
	^ { 
'Task' -> { 'ru' -> 'Задача' } asDictionary.
'task' -> { 'ru' -> 'задача' } asDictionary.
'Task Journal' -> { 'ru' -> 'Журнал задач' } asDictionary.
'Task Report' -> { 'ru' -> 'Отчет по задачам' } asDictionary.
'Transfer Journal' -> { 'ru' -> 'Журнал перемещений' } asDictionary.
'Transfer' -> { 'ru' -> 'Перемещение' } asDictionary.
'Transfers' -> { 'ru' -> 'Перемещение' } asDictionary.
'Tasks' -> { 'ru' -> 'Задачи' } asDictionary.
'Task Account' -> { 'ru' -> 'Счет задачи' } asDictionary.

	 } asDictionary
]

{ #category : #translating }
ATDictionary >> translate: aString [
	^ self translate: aString toLocale: 'ru'. 
]

{ #category : #translating }
ATDictionary >> translate: aString toLocale: aLocale [
	| translates l |
	translates := self dictionary at: aString ifAbsent: [ nil ].
	translates
		ifNil: [ ^ aString ]
		ifNotNil: [ :a| 
				l := a at: aLocale ifAbsent: [ nil ].
				l ifNil: [^ aString ] ifNotNil: [ ^ l ] ]
]

{ #category : #'accessing structure variables' }
ATDictionary >> u [
	^ { 
'Unwire' -> { 'ru' -> 'Отменить проводку' } asDictionary.
'Up' -> { 'ru' -> 'Вверх' } asDictionary.
'Update' -> { 'ru' -> 'Обновить' } asDictionary.
'Unix Time' -> { 'ru' -> 'Юникс время' } asDictionary.

	 } asDictionary
]

{ #category : #updating }
ATDictionary >> update [
	| selectors dic langDic globalDic |
	globalDic := Smalltalk
		at: #ATranslatorDictionary
		ifAbsentPut: Dictionary new.
	selectors := #( a b c d e f g h i j k l m  n o p q r s t u v w x y z).
	selectors do: [ :sel|
		dic := self perform: sel asSymbol.
		dic keysAndValuesDo: [ :k :v|
		langDic := globalDic at: k ifAbsentPut: Dictionary new.
		langDic addAll: v.] ]
]

{ #category : #'accessing structure variables' }
ATDictionary >> v [
	^ { 
'Value' -> { 'ru' -> 'Значение' } asDictionary.
	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> w [
	^ { 
'Write-off Journal' -> { 'ru' -> 'Журнал списаний' } asDictionary.
'Select a Write-off Document' -> { 'ru' -> 'Выберите документ списания' } asDictionary.
'Write-off' -> { 'ru' -> 'Списание' } asDictionary.
	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> x [
	^ { 

	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> y [
	^ { 
'Year' -> { 'ru' -> 'Год'} asDictionary.
	 } asDictionary
]

{ #category : #'accessing structure variables' }
ATDictionary >> z [
	^ { 

	 } asDictionary
]
