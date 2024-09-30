#Область ОписаниеПеременных

&НаКлиенте
Перем ЗакрытиеФормыПодтверждено;

&НаКлиенте
Перем УИ_РедакторКодаКлиентскиеДанные Экспорт;

&НаКлиенте
Перем ИдетОбновлениеПоляРезультата;//Булево

&НаКлиенте
Перем УИ_ИдентификаторТекущейСтрокиАлгоритмов; //Число

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	УИ_РедакторКодаСервер.ФормаПриСозданииНаСервере(ЭтотОбъект, "Ace");
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект,
													   "HTML",
													   Элементы.РедакторРезультирующегоHTML,
													   ,
													   "html");
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект,
													   "СФОРМИРОВАН",
													   Элементы.РедакторСобытияДокументСформирован);
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект, "НАЖАТИЕ", Элементы.РедакторСобытияПриНажатии);
	УИ_РедакторКодаСервер.СоздатьЭлементыРедактораКода(ЭтотОбъект,
													   "АЛГОРИТМ",
													   Элементы.РедакторАлгоритма,
													   ,
													   ,
													   Элементы.ГруппаРедакторАлгоритмаКоманднаяПанель);

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
		ПодключитьОбработчикОжидания("ВыполнитьОбновлениеПоляHTMLРезультирующегоДокумента", 0.1, Истина);
		Возврат;
	КонецЕсли;
	ВыполнитьОбработчикДокументСформированРезультирующегоHTML(Элемент);
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

#Область ОбработчикиСобытийЭлементовТаблицыФормыАлгоритмы

&НаКлиенте
Процедура АлгоритмыПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	
	ТекДанные = Элементы.Алгоритмы.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура АлгоритмыПриАктивизацииСтроки(Элемент)
	СохранитьДанныеРедактораВТаблицуАлгоритмов();
	
	ТекДанные = Элементы.Алгоритмы.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	УИ_ИдентификаторТекущейСтрокиАлгоритмов = ТекДанные.ПолучитьИдентификатор();

	УИ_РедакторКодаКлиент.УстановитьТекстРедактора(ЭтотОбъект, "АЛГОРИТМ", ТекДанные.Текст);
	УИ_РедакторКодаКлиент.УстановитьОригинальныйТекстРедактора(ЭтотОбъект, "АЛГОРИТМ", ТекДанные.ОригинальныйТекст);
	УИ_РедакторКодаКлиент.УстановитьРежимИспользованияОбработкиДляВыполненияКодаРедактора(ЭтотОбъект,
																						  "АЛГОРИТМ",
																						  ТекДанные.ИспользоватьОбработкуДляВыполненияКода);

	ДобавитьДополнительныйКонтекстВРедакторКодаАлгоритма();
КонецПроцедуры


&НаКлиенте
Процедура АлгоритмыПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	ТекДанные = Элементы.Алгоритмы.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		ВозвраТ;
	КонецЕсли;
	
	Если НоваяСтрока Тогда
		ТекДанные.Имя = "Алгоритм"+Формат(ТекДанные.ПолучитьИдентификатор(), "ЧГ=0;");
	КонецЕсли;
КонецПроцедуры


#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыАлгоритмыПеременные

&НаКлиенте
Процедура АлгоритмыПеременныеПриОкончанииРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования)
	ДобавитьДополнительныйКонтекстВРедакторКодаАлгоритма();
КонецПроцедуры

&НаКлиенте
Процедура АлгоритмыПеременныеПередОкончаниемРедактирования(Элемент, НоваяСтрока, ОтменаРедактирования, Отказ)
	Если ОтменаРедактирования Тогда
		Возврат;
	КонецЕсли;
	
	ТекДанные = Элементы.АлгоритмыПеременные.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если Не УИ_ОбщегоНазначенияКлиентСервер.ИмяПеременнойКорректно(ТекДанные.Имя) Тогда
		Отказ = Истина;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура АлгоритмыПеременныеЗначениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	ТекДанные = Элементы.АлгоритмыПеременные.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		ВозвраТ;
	КонецЕсли;
	
	ПараметрыОбработчика = УИ_ОбщегоНазначенияКлиент.НовыйПараметрыОбработчикаСобытияНачалоВыбораЗначения(ЭтотОбъект,
																										  Элемент,
																										  "Значение");
	ПараметрыОбработчика.ДоступенКонтейнер = Истина;
	ПараметрыОбработчика.Значение = ТекДанные.Значение;
	ПараметрыОбработчика.СтруктураХраненияЗначения = ТекДанные;
	ПараметрыОбработчика.НаборТипов = УИ_ОбщегоНазначенияКлиентСервер.ВсеНаборыТиповДляРедактирования();

	УИ_ОбщегоНазначенияКлиент.ПолеФормыОбработчикНачалоВыбораЗначения(ПараметрыОбработчика, СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура АлгоритмыПеременныеЗначениеПриИзменении(Элемент)
	ТекДанные = Элементы.АлгоритмыПеременные.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ПараметрыОбработчика = УИ_ОбщегоНазначенияКлиент.НовыйПараметрыОбработчикаСобытияПриИзменении(ЭтотОбъект,
																								  Элемент,
																								  "Значение");
	ПараметрыОбработчика.ДоступенКонтейнер = Истина;
	ПараметрыОбработчика.СтруктураХраненияЗначения = ТекДанные;

	УИ_ОбщегоНазначенияКлиент.ПолеФормыОбработчикПриИзменении(ПараметрыОбработчика);
КонецПроцедуры

&НаКлиенте
Процедура АлгоритмыПеременныеЗначениеОчистка(Элемент, СтандартнаяОбработка)
	ТекДанные = Элементы.АлгоритмыПеременные.ТекущиеДанные;
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПараметрыОбработчика = УИ_ОбщегоНазначенияКлиент.НовыйПараметрыОбработчикаСобытияОчистка(ЭтотОбъект,
																							 Элемент,
																							 "Значение");
	ПараметрыОбработчика.ДоступенКонтейнер = Истина;
	ПараметрыОбработчика.СтруктураХраненияЗначения = ТекДанные;

	УИ_ОбщегоНазначенияКлиент.ПолеФормыОбработчикОчистка(ПараметрыОбработчика, СтандартнаяОбработка);

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
Процедура Подключаемый_ВыполнитьКомандуРедактораКода(Команда)
	УИ_РедакторКодаКлиент.ВыполнитьКомандуРедактораКода(ЭтотОбъект, Команда);
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


&НаКлиенте
Процедура ВыполнитьОбработчикСобытияДокументСформирован(Команда)
	ВыполнитьОбработчикДокументСформированРезультирующегоHTML(Элементы.РезультирущийHTML);
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьАлгоритм(Команда)
	Если УИ_ИдентификаторТекущейСтрокиАлгоритмов = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СохранитьДанныеРедактораВТаблицуАлгоритмов();
	
	СтрокаАлгоритма = Алгоритмы.НайтиПоИдентификатору(УИ_ИдентификаторТекущейСтрокиАлгоритмов);
	
	КлиентскиеРедакторы = Новый Массив;
	КлиентскиеРедакторы.Добавить("АЛГОРИТМ");
	
	СтруктураИменПеременныхРедакторов = Новый Структура;
	
	МассивИмен = Новый Массив;
	Для Каждого Стр Из СтрокаАлгоритма.Переменные Цикл
		МассивИмен.Добавить(стр.Имя);
	КонецЦикла;
	МассивИмен.Добавить("Элемент");
	МассивИмен.Добавить("ДокументView");
	СтруктураИменПеременныхРедакторов.Вставить("АЛГОРИТМ", МассивИмен);
	
	ПараметрыОповещения = Новый Структура;
	ПараметрыОповещения.Вставить("Начало", ТекущаяУниверсальнаяДатаВМиллисекундах());
	ПараметрыОповещения.Вставить("СтрокаАлгоритма", СтрокаАлгоритма);

	УИ_РедакторКодаКлиент.НачатьСборкуОбработокДляИсполненияКода(ЭтотОбъект,
																 Новый ОписаниеОповещения("ВыполнитьАлгоритмдЗавершениеСборкиОбработок",
		ЭтотОбъект, ПараметрыОповещения),
																 СтруктураИменПеременныхРедакторов,
																 КлиентскиеРедакторы);
	
	
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
Процедура ВыполнитьАлгоритмдЗавершениеСборкиОбработок(Результат, ДополнительныеПараметры) Экспорт
		
	СтрокаАлгоритма = ДополнительныеПараметры.СтрокаАлгоритма;	
	Если Не ЗначениеЗаполнено(СокрЛП(СтрокаАлгоритма.Текст)) Тогда
		Возврат;
	КонецЕсли;

	
	КонтекстВыполнения = КонтекстВыполненияАлгоритма(СтрокаАлгоритма.Переменные);
	КонтекстВыполнения.Вставить("Элемент", Элементы.РезультирущийHTML);
	КонтекстВыполнения.Вставить("ДокументView", Элементы.РезультирущийHTML.Документ.defaultView);

	РезультатВыполнения = УИ_РедакторКодаКлиентСервер.ВыполнитьАлгоритм(СтрокаАлгоритма.Текст,
																		КонтекстВыполнения,
																		Истина,
																		ЭтотОбъект,
																		"АЛГОРИТМ");

	СтрокаАлгоритма.Инфо = Строка((РезультатВыполнения.ВремяВыполнения) / 1000) + " сек.";

	
КонецПроцедуры 

&НаКлиентеНаСервереБезКонтекста
Функция КонтекстВыполненияАлгоритма(Переменные)
	КонтекстВыполнения = Новый Структура;

	Для Каждого СтрокаТЧ Из Переменные Цикл
		СтруктураХраненияПоля = УИ_ОбщегоНазначенияКлиентСервер.НовыйСтруктураХраненияРеквизитаНаФормеСКонейнером("Значение");

		КонтекстВыполнения.Вставить(СтрокаТЧ.Имя,
									УИ_ОбщегоНазначенияКлиентСервер.ЗначениеПоляСКонтейнеромЗначения(СтрокаТЧ,
																									 СтруктураХраненияПоля));
	КонецЦикла;

	Возврат КонтекстВыполнения;
КонецФункции

&НаКлиенте
Процедура ВыполнитьОбработчикДокументСформированРезультирующегоHTML(Элемент)
	ТекстАлготима=ТекстРедактораЭлемента(Элементы.РедакторСобытияДокументСформирован);
	УИ_РедакторКодаКлиентСервер.ВыполнитьАлгоритм(ТекстАлготима, Новый Структура);
КонецПроцедуры

&НаКлиенте
Процедура СохранитьДанныеРедактораВТаблицуАлгоритмов()
	Если УИ_ИдентификаторТекущейСтрокиАлгоритмов = Неопределено Тогда
		Возврат;
	КонецЕсли;
	ТекДанные = Алгоритмы.НайтиПоИдентификатору(УИ_ИдентификаторТекущейСтрокиАлгоритмов);
	Если ТекДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;

	ТекДанные.Текст = УИ_РедакторКодаКлиент.ТекстКодаРедактора(ЭтотОбъект, "АЛГОРИТМ");
	ТекДанные.ИспользоватьОбработкуДляВыполненияКода = УИ_РедакторКодаКлиент.РежимИспользованияОбработкиДляВыполненияКодаРедактора(ЭтотОбъект,
																																   "АЛГОРИТМ");
КонецПроцедуры

&НаКлиенте
Функция ПеременныеКонтекстаАлгоритма(ТЧПеременных)
	МассивПеременных=Новый Массив;
	Для Каждого ТекПеременная Из ТЧПеременных Цикл
		СтруктураПеременной=Новый Структура;
		СтруктураПеременной.Вставить("Имя", ТекПеременная.Имя);
		СтруктураПеременной.Вставить("Тип", ТипЗнч(ТекПеременная.Значение));

		МассивПеременных.Добавить(СтруктураПеременной);
	КонецЦикла;
	
	Возврат МассивПеременных;
КонецФункции

&НаКлиенте
Процедура ДобавитьДополнительныйКонтекстВРедакторКодаАлгоритма()
	Если УИ_ИдентификаторТекущейСтрокиАлгоритмов = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	СтрокаАлгоритма = Алгоритмы.НайтиПоИдентификатору(УИ_ИдентификаторТекущейСтрокиАлгоритмов);
	
	СтруктураДополнительногоКонтекста = Новый Структура;

	ПеременныеКонтекста =ПеременныеКонтекстаАлгоритма(СтрокаАлгоритма.Переменные); 
	Для Каждого Пер Из ПеременныеКонтекста Цикл
		Если Не УИ_ОбщегоНазначенияКлиентСервер.ИмяПеременнойКорректно(Пер.Имя) Тогда
			Продолжить;
		КонецЕсли;
		
		СтруктураДополнительногоКонтекста.Вставить(Пер.Имя, Пер.Тип);
	КонецЦикла;
	
	УИ_РедакторКодаКлиент.ДобавитьКонтекстРедактораКода(ЭтотОбъект, "АЛГОРИТМ", СтруктураДополнительногоКонтекста);
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОбновлениеПоляHTMLРезультирующегоДокумента()
	ИдетОбновлениеПоляРезультата = Ложь;
	HTML=ТекстРедактораЭлемента(Элементы.РедакторРезультирующегоHTML);

	Если Не ЗначениеЗаполнено(HTML) И Не ЗначениеЗаполнено(РезультирущийHTML) Тогда
		Возврат;
	КонецЕсли;

	Если РезультирущийHTML = HTML Тогда
		ДокументHTML = Элементы.РезультирущийHTML.Документ.defaultView;
		Если ДокументHTML.location.href <> РезультирущийHTML Тогда
			РезультирущийHTML="<html></html>";
			ИдетОбновлениеПоляРезультата = Истина;
		Иначе
			Попытка
				ДокументHTML.location.reload(Истина);
			Исключение
				ДокументHTML.document.innerHTML = "";
				ДокументHTML.location.href = HTML;
			КонецПопытки;
		КонецЕсли;		
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

