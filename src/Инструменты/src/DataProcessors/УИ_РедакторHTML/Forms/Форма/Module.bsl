#Область ОписаниеПеременных

&НаКлиенте
Перем ЗакрытиеФормыПодтверждено;

&НаКлиенте
Перем УИ_РедакторКодаКлиентскиеДанные Экспорт;

&НаКлиенте
Перем ИдетОбновлениеПоляРезультата;//Булево

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	УИ_РедакторКодаСервер.ФормаПриСозданииНаСервере(ЭтотОбъект,"Ace");
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект, "HTML", Элементы.РедакторРезультирующегоHTML,, "html");
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект, "СФОРМИРОВАН", Элементы.РедакторСобытияДокументСформирован);
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект, "НАЖАТИЕ", Элементы.РедакторСобытияПриНажатии);

	УИ_ОбщегоНазначения.ФормаИнструментаПриСозданииНаСервере(ЭтотОбъект, Отказ, СтандартнаяОбработка);
	
КонецПроцедуры
&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	Если Не ЗакрытиеФормыПодтверждено Тогда
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ЗакрытиеФормыПодтверждено=Ложь;
	ИдетОбновлениеПоляРезультата = Ложь;
	УИ_РедакторКодаКлиент.ФормаПриОткрытии(ЭтотОбъект);

КонецПроцедуры
#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура РезультирущийHTMLДокументСформирован(Элемент)
	Если ИдетОбновлениеПоляРезультата Тогда
		ВыполнитьОбновлениеПоляHTMLРезультирующегоДокумента();
		Возврат;
	КонецЕсли;
	ТекстАлготима=ТекстРедактораЭлемента(Элементы.РедакторСобытияДокументСформирован);
	УИ_РедакторКодаКлиентСервер.ВыполнитьАлгоритм(ТекстАлготима, Новый Структура);
КонецПроцедуры

&НаКлиенте
Процедура РезультирущийHTMLПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	ТекстАлготима=ТекстРедактораЭлемента(Элементы.РедакторСобытияПриНажатии);
	#Если не ВебКлиент Тогда
	Попытка
		Выполнить (ТекстАлготима);
	Исключение
		ОписаниеОшибки = ОписаниеОшибки();
		//@skip-check use-non-recommended-method
		Сообщить(ОписаниеОшибки);
	КонецПопытки;
	#КонецЕсли
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбновитьРезультирующийHTML(Команда)
	ВыполнитьОбновлениеПоляHTMLРезультирующегоДокумента();
	
КонецПроцедуры

&НаКлиенте
Процедура РазвернутьСвернутьПолеПросмотраНаВсюФорму(Команда)
	ПолеПросмотраРазвернутоНаВсюФорму=Не ПолеПросмотраРазвернутоНаВсюФорму;

	Элементы.ГруппаСтраницыРедактированияHTML.Видимость=Не ПолеПросмотраРазвернутоНаВсюФорму;

	УИ_РедакторКодаКлиент.ПереключитьВидимостьРедактораЭлементаФормы(ЭтотОбъект, Элементы.РедакторРезультирующегоHTML,
		Не ПолеПросмотраРазвернутоНаВсюФорму);
	УИ_РедакторКодаКлиент.ПереключитьВидимостьРедактораЭлементаФормы(ЭтотОбъект,
		Элементы.РедакторСобытияДокументСформирован, Не ПолеПросмотраРазвернутоНаВсюФорму);
	УИ_РедакторКодаКлиент.ПереключитьВидимостьРедактораЭлементаФормы(ЭтотОбъект, Элементы.РедакторСобытияПриНажатии,
		Не ПолеПросмотраРазвернутоНаВсюФорму);

КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_ВыполнитьОбщуюКомандуИнструментов(Команда) 
	УИ_ОбщегоНазначенияКлиент.Подключаемый_ВыполнитьОбщуюКомандуИнструментов(ЭтотОбъект, Команда);
КонецПроцедуры


&НаКлиенте
Процедура СохранитьФайл(Команда)
	СохранитьФайлНаДиск();
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайлКак(Команда)
	СохранитьФайлНаДиск(Истина);
КонецПроцедуры


&НаКлиенте
Процедура НовыйФайл(Команда)
	ИмяФайлаДанныхИнструмента="";

	УстановитьТекстРедактораЭлемента(Элементы.РедакторРезультирующегоHTML, "");

	УстановитьЗаголовок();
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьИнструмент(Команда)
	ПоказатьВопрос(Новый ОписаниеОповещения("ЗакрытьИнструментЗавершение", ЭтотОбъект), "Выйти из редактора?",
		РежимДиалогаВопрос.ДаНет);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайл(Команда)
	УИ_ОбщегоНазначенияКлиент.ПрочитатьДанныеКонсолиИзФайла("РедактовHTML", СтруктураОписанияСохраняемогоФайла(),
		Новый ОписаниеОповещения("ОткрытьФайлЗавершение", ЭтотОбъект));
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область РедакторКода

&НаКлиенте
Процедура Подключаемый_ПолеРедактораДокументСформирован(Элемент)
	УИ_РедакторКодаКлиент.ПолеРедактораHTMLДокументСформирован(ЭтотОбъект, Элемент);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ПолеРедактораПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	УИ_РедакторКодаКлиент.ПолеРедактораHTMLПриНажатии(ЭтотОбъект, Элемент, ДанныеСобытия, СтандартнаяОбработка);
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура Подключаемый_РедакторКодаОтложеннаяИнициализацияРедакторов()
	УИ_РедакторКодаКлиент.РедакторКодаОтложеннаяИнициализацияРедакторов(ЭтотОбъект);
КонецПроцедуры


// Подключаемый редактор кода завершение инициализации редактора.
// 
// Параметры:
//  ИдентификаторРедактора - Строка -Идентификатор редактора
//@skip-check module-empty-method
&НаКлиенте 
Процедура Подключаемый_РедакторКодаЗавершениеИнициализацииРедактора(ИдентификаторРедактора) Экспорт
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_РедакторКодаОтложеннаяОбработкаСобытийРедактора() Экспорт
	УИ_РедакторКодаКлиент.ОтложеннаяОбработкаСобытийРедактора(ЭтотОбъект);
КонецПроцедуры

#КонецОбласти

&НаКлиенте
Процедура ВыполнитьОбновлениеПоляHTMLРезультирующегоДокумента()
	ИдетОбновлениеПоляРезультата = Ложь;
	HTML=ТекстРедактораЭлемента(Элементы.РедакторРезультирующегоHTML);

	Если Не ЗначениеЗаполнено(HTML) И Не ЗначениеЗаполнено(РезультирущийHTML) Тогда
		Возврат;
	КонецЕсли;

	Если РезультирущийHTML = HTML Тогда
		РезультирущийHTML="";
		ИдетОбновлениеПоляРезультата = Истина;
	Иначе
		РезультирущийHTML=HTML;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ТекстРедактораЭлемента(ЭлементПоляРедактора)
	Возврат УИ_РедакторКодаКлиент.ТекстКодаРедактораЭлементаФормы(ЭтотОбъект,ЭлементПоляРедактора);
КонецФункции

&НаКлиенте
Процедура УстановитьТекстРедактораЭлемента(ЭлементПоляРедактора, ТекстУстановки)
	УИ_РедакторКодаКлиент.УстановитьТекстРедактораЭлементаФормы(ЭтотОбъект, ЭлементПоляРедактора, ТекстУстановки);
КонецПроцедуры

#Область СтандартныеПроцедурыИнструментов

&НаКлиенте
Функция СтруктураОписанияСохраняемогоФайла()
	Структура=УИ_ОбщегоНазначенияКлиент.ПустаяСтруктураОписанияВыбираемогоФайла();
	Структура.ИмяФайла=ИмяФайлаДанныхИнструмента;
	
//	УИ_ОбщегоНазначенияКлиент.ДобавитьФорматВОписаниеФайлаСохранения(Структура, "Данные редактора HTML(*.bslhtml)", "bslhtml");
	УИ_ОбщегоНазначенияКлиент.ДобавитьФорматВОписаниеФайлаСохранения(Структура, "Файл HTML(*.html)", "html");
	Возврат Структура;
КонецФункции

&НаКлиенте
Процедура ОткрытьФайлЗавершение(Результат, ДополнительныеПараметры) Экспорт
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Модифицированность=Ложь;
	ИмяФайлаДанныхИнструмента = Результат.ИмяФайла;

	ДанныеФайла=ПолучитьИзВременногоХранилища(Результат.Адрес);

	Текст=Новый ТекстовыйДокумент;
	Текст.НачатьЧтение(Новый ОписаниеОповещения("ОткрытьФайлЗавершениеЧтенияТекста", ЭтотОбъект,
		Новый Структура("Текст", Текст)), ДанныеФайла.ОткрытьПотокДляЧтения());
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьФайлЗавершениеЧтенияТекста(ДополнительныеПараметры1) Экспорт
	
	Текст = ДополнительныеПараметры1.Текст;
	
	УстановитьТекстРедактораЭлемента(Элементы.РедакторРезультирующегоHTML, Текст.ПолучитьТекст());
	
	УстановитьЗаголовок();
	
	Элементы.ГруппаСтраницыРедактированияHTML.ТекущаяСтраница = Элементы.ГруппаТекстРезультирующегоHTML; 
	ВыполнитьОбновлениеПоляHTMLРезультирующегоДокумента();

КонецПроцедуры


&НаКлиенте
Процедура СохранитьФайлНаДиск(СохранитьКак = Ложь)
	УИ_ОбщегоНазначенияКлиент.СохранитьДанныеКонсолиВФайл("РедактовHTML", СохранитьКак,
		СтруктураОписанияСохраняемогоФайла(), ТекстРедактораЭлемента(Элементы.РедакторРезультирующегоHTML),
		Новый ОписаниеОповещения("СохранитьФайлЗавершение", ЭтотОбъект));
КонецПроцедуры

&НаКлиенте
Процедура СохранитьФайлЗавершение(ИмяФайлаСохранения, ДополнительныеПараметры) Экспорт
	Если ИмяФайлаСохранения = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Если Не ЗначениеЗаполнено(ИмяФайлаСохранения) Тогда
		Возврат;
	КонецЕсли;

	Модифицированность=Ложь;
	ИмяФайлаДанныхИнструмента=ИмяФайлаСохранения;
	УстановитьЗаголовок();
КонецПроцедуры


&НаКлиенте
Процедура ЗакрытьИнструментЗавершение(Результат, ДополнительныеПараметры) Экспорт

	Если Результат = КодВозвратаДиалога.Да Тогда
		ЗакрытиеФормыПодтверждено = Истина;
		Закрыть();
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура УстановитьЗаголовок()
	Заголовок=ИмяФайлаДанныхИнструмента;
КонецПроцедуры

#КонецОбласти


#КонецОбласти

