Перем Перечисления;

&Желудь
Процедура ПриСозданииОбъекта(
							&Пластилин("Перечисления") _Перечисления
							)
	Перечисления = _Перечисления;
КонецПроцедуры

Функция ПараметрыИзТекста(ПараметрыТекстом, РазделительПараметров = "&") Экспорт

	Результат = Новый Соответствие();
	
	Если ЗначениеЗаполнено(ПараметрыТекстом) Тогда
		МассивПараметров = СтрРазделить(ПараметрыТекстом, РазделительПараметров, Ложь);
		Для Каждого ТекПараметрСтрокой из МассивПараметров Цикл
			ТекПараметр = РазделитьСтроку(ТекПараметрСтрокой, "=");
			Имя = РаскодироватьСтроку(ТекПараметр.Лево, СпособКодированияСтроки.КодировкаURL);
			Значение = РаскодироватьСтроку(ТекПараметр.Право, СпособКодированияСтроки.КодировкаURL);
			Результат.Вставить(Имя, Значение);
		КонецЦикла;
	КонецЕсли;

	Возврат Результат;
	
КонецФункции

Функция РазделитьСтроку(Строка, Разделитель) Экспорт
	Результат = Новый Структура("Лево, Право","","");
	ПозицияРазделителя = СтрНайти(Строка, Разделитель);

	Если ПозицияРазделителя = 0 Тогда
		Результат.Лево = Строка;
	Иначе
		Результат.Лево = Лев(Строка, ПозицияРазделителя - 1);
		Результат.Право = Сред(Строка, ПозицияРазделителя + СтрДлина(Разделитель));
	КонецЕсли;

	Возврат Результат;
КонецФункции

Функция РазделитьДвоичныеДанныеРазделителем(ДвоичныеДанные, Разделитель) Экспорт
	БуферДвоичныхДанных = ПолучитьБуферДвоичныхДанныхИзДвоичныхДанных(ДвоичныеДанные);

	Лево = Неопределено;
	Право = Неопределено;

	Массив = БуферДвоичныхДанных.Разделить(ПолучитьБуферДвоичныхДанныхИзДвоичныхДанных(Разделитель));

	Если Массив.Количество() > 0 Тогда

		Лево = ПолучитьДвоичныеДанныеИзБуфераДвоичныхДанных(Массив[0]);

		Если Массив.Количество() > 1 Тогда

			МассивПраво = Новый Массив();

			Для Счетчик = 1 По Массив.Количество() - 1 Цикл
				Если Счетчик > 1 Тогда
					МассивПраво.Добавить(Разделитель);
				КонецЕсли;
				МассивПраво.Добавить(ПолучитьДвоичныеДанныеИзБуфераДвоичныхДанных(Массив[Счетчик]));
			КонецЦикла;

			Право = СоединитьДвоичныеДанные(МассивПраво);

		КонецЕсли;
		
	КонецЕсли;

	Возврат Новый Структура("Лево, Право", Лево, Право);

КонецФункции

Функция РазделитьДвоичныеДанныеРазделителемВМассив(Знач ДвоичныеДанные, Разделитель, ВКлючатьПустые = Ложь) Экспорт

	БуферДвоичныхДанных = ПолучитьБуферДвоичныхДанныхИзДвоичныхДанных(ДвоичныеДанные);

	Массив = БуферДвоичныхДанных.Разделить(ПолучитьБуферДвоичныхДанныхИзДвоичныхДанных(Разделитель));
	
	Результат = Новый Массив();

	Для Каждого Элемент Из Массив Цикл
		Результат.Добавить(ПолучитьДвоичныеДанныеИзБуфераДвоичныхДанных(Элемент));
	КонецЦикла;

	Возврат Результат;

КонецФункции

Функция МассивыРавны(Массив1, Массив2) Экспорт

	Если не Массив1.Количество() = Массив2.Количество() Тогда
		Возврат Ложь;
	Иначе
		Для сч = 0 По Массив1.ВГраница() Цикл
			Если Не Массив1[сч] = Массив2[сч] Тогда
				Возврат Ложь;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;

	Возврат Истина;
	
КонецФункции

Процедура ДобавитьВМассивСоСмещением(Массив, ДобавляемыйЭлемент) Экспорт
	
	Если Массив.Количество() = 1 Тогда
		Массив[0] = ДобавляемыйЭлемент;
		Возврат;
	ИначеЕсли Массив.Количество() = 0 Тогда
		ВызватьИсключение "Пустой массив для смещения";
	КонецЕсли;

	Для сч = 0 по Массив.ВГраница() - 1 Цикл
		Массив[сч] = Массив[сч + 1];
	КонецЦикла;

	Массив[Массив.ВГраница()] = ДобавляемыйЭлемент;

КонецПроцедуры

Функция ПолучитьМассивБайт(ДвоичныеДанные) Экспорт

	Возврат РазделитьДвоичныеДанные(ДвоичныеДанные, 1);

КонецФункции

Функция СтруктураУзла(АдресУзла) Экспорт

	Результат = Новый Структура("Адрес, Порт", "", 0);

	Адрес = АдресУзла;
	ДлинаАдреса = СтрДлина(Адрес);

	ПозицияДвоеточия = СтрНайти(Адрес, ":", НаправлениеПоиска.СКонца);
	Если ПозицияДвоеточия > 0 Тогда
		ЭтоIPv6 = Сред(Адрес, ПозицияДвоеточия - 1, 1) = "]";
		ЭтоIPv4 = Не ЭтоIPv6 И СтрНайти(Сред(Адрес, 1, ПозицияДвоеточия - 1), ":") = 0;
	
		Если ЭтоIPv6 Или ЭтоIPv4 Тогда
			ДлинаАдреса = ПозицияДвоеточия - 1;
			Адрес = Сред(АдресУзла, 1, ДлинаАдреса);

			Результат.Порт = Новый ОписаниеТипов("Число").ПривестиЗначение(Сред(АдресУзла, ПозицияДвоеточия + 1));
		КонецЕсли;
	КонецЕсли;

	Если Лев(Адрес, 1) = "[" И Прав(Адрес, 1) = "]" Тогда
		Адрес = Сред(Адрес, 2, ДлинаАдреса - 2);
	КонецЕсли;

	Результат.Адрес = Адрес;

	Возврат Результат;
	
КонецФункции

Функция ПолучитьИзПотокаДД(Поток, Позиция, Количество)
	Поток.Перейти(Позиция);
	БуферДвоичныхДанных = Новый БуферДвоичныхДанных(Количество);
	Поток.Прочитать(БуферДвоичныхДанных, 0, Количество);

	Возврат ПолучитьДвоичныеДанныеИзБуфераДвоичныхДанных(БуферДвоичныхДанных);
КонецФункции