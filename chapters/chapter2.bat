@echo off
chcp 65001 >nul
title Модуль 2 - Инспекция кода (ревью)

rem ==================================================================
rem  ЛАБОРАТОРНАЯ РАБОТА N2, ЧАСТЬ 2
rem  Модуль формализации процесса ревьюирования: поиск дефектов
rem  в фрагментах кода системы отслеживания задач.
rem  Вариант 5: YouTrack / Redmine / Taiga
rem ==================================================================

rem --- Счётчики ------------------------------------------------------
set correct=0
set total=5
set score=0

cls
echo ==================================================================
echo   МОДУЛЬ 2. ИНСПЕКЦИЯ КОДА СИСТЕМЫ ОТСЛЕЖИВАНИЯ ЗАДАЧ
echo ------------------------------------------------------------------
echo   Вам будет показано 5 фрагментов кода интеграции с трекером.
echo   В каждом фрагменте спрятан один дефект.
echo   Правильный ответ: +1 балл.  Неправильный ответ: -1 балл.
echo ==================================================================
echo.
echo   Типы дефектов:
echo     - неинициализированная переменная
echo     - мёртвое присваивание
echo     - утечка ресурса
echo     - магическое число
echo     - отсутствие обработки ошибок
echo.
pause

rem ==================================================================
rem  ФРАГМЕНТ 1. Неинициализированная переменная
rem ==================================================================
:f1
cls
echo Фрагмент 1 из 5 (фильтр задач для YouTrack):
echo.
echo    10: def build_filter(project):
echo    11:     if project.is_agile:
echo    12:         query = "Board: " + project.name
echo    13:     return "Query: " + query
echo.
echo Какой дефект здесь скрыт?
echo   1. Мёртвое присваивание
echo   2. Неинициализированная переменная
echo   3. Магическое число
echo   4. Утечка ресурса
echo.
choice /c 1234 /n /m "  Ваш выбор [1-4]: "
if errorlevel 4 goto f1c4
if errorlevel 3 goto f1c3
if errorlevel 2 goto f1c2
goto f1c1

:f1c1
set /a score-=1
echo.
echo Неверно. Правильный ответ: 2.
goto f1_ok
:f1c3
set /a score-=1
echo.
echo Неверно. Правильный ответ: 2.
goto f1_ok
:f1c4
set /a score-=1
echo.
echo Неверно. Правильный ответ: 2.
goto f1_ok

:f1c2
set /a correct+=1
set /a score+=1
echo.
echo Верно! Если project.is_agile ложно, переменная query
echo не будет создана, и строка 13 вызовет UnboundLocalError.
goto f2

:f1_ok
echo Ветка if не покрывает все случаи, поэтому query может быть
echo не инициализирована до использования.

rem ==================================================================
rem  ФРАГМЕНТ 2. Магическое число
rem ==================================================================
:f2
echo.
pause
cls
echo Фрагмент 2 из 5 (проверка просроченных задач в Redmine):
echo.
echo    20: def is_overdue(issue):
echo    21:     days_left = (issue.due_date - today()).days
echo    22:     return days_left ^< 3 and issue.priority_id == 2
echo.
echo Какой дефект здесь скрыт?
echo   1. Магическое число
echo   2. Утечка ресурса
echo   3. Отсутствие обработки ошибок
echo   4. Неинициализированная переменная
echo.
choice /c 1234 /n /m "  Ваш выбор [1-4]: "
if errorlevel 4 goto f2c4
if errorlevel 3 goto f2c3
if errorlevel 2 goto f2c2
goto f2c1

:f2c1
set /a correct+=1
set /a score+=1
echo.
echo Верно! Числа 3 и 2 не объяснены: их нужно вынести
echo в именованные константы OVERDUE_DAYS и HIGH_PRIORITY_ID.
goto f3
:f2c2
set /a score-=1
echo.
echo Неверно. Правильный ответ: 1.
goto f2_ok
:f2c3
set /a score-=1
echo.
echo Неверно. Правильный ответ: 1.
goto f2_ok
:f2c4
set /a score-=1
echo.
echo Неверно. Правильный ответ: 1.
goto f2_ok

:f2_ok
echo В коде используются числа 3 и 2 без пояснения их смысла.

rem ==================================================================
rem  ФРАГМЕНТ 3. Утечка ресурса
rem ==================================================================
:f3
echo.
pause
cls
echo Фрагмент 3 из 5 ( чтение конфигурации Taiga ):
echo.
echo    30: def load_config(path):
echo    31:     f = open(path, "r", encoding="utf-8")
echo    32:     data = json.load(f)
echo    33:     return data
echo.
echo Какой дефект здесь скрыт?
echo   1. Отсутствие обработки ошибок
echo   2. Мёртвое присваивание
echo   3. Утечка ресурса
echo   4. Магическое число
echo.
choice /c 1234 /n /m "  Ваш выбор [1-4]: "
if errorlevel 4 goto f3c4
if errorlevel 3 goto f3c3
if errorlevel 2 goto f3c2
goto f3c1

:f3c1
set /a score-=1
echo.
echo Неверно. Правильный ответ: 3.
goto f3_ok
:f3c2
set /a score-=1
echo.
echo Неверно. Правильный ответ: 3.
goto f3_ok
:f3c4
set /a score-=1
echo.
echo Неверно. Правильный ответ: 3.
goto f3_ok

:f3c3
set /a correct+=1
set /a score+=1
echo.
echo Верно! Файл открыт, но нигде не закрыт: нужен with open(...)
echo или блок try/finally с вызовом f.close().
goto f4

:f3_ok
echo Дескриптор файла остаётся открытым до сборки мусора.

rem ==================================================================
rem  ФРАГМЕНТ 4. Мёртвое присваивание
rem ==================================================================
:f4
echo.
pause
cls
echo Фрагмент 4 из 5 (синхронизация задачи в Taiga):
echo.
echo    40: def sync_issue(issue):
echo    41:     status = "open"
echo    42:     status = issue.status
echo    43:     return status
echo.
echo Какой дефект здесь скрыт?
echo   1. Утечка ресурса
echo   2. Отсутствие обработки ошибок
echo   3. Неинициализированная переменная
echo   4. Мёртвое присваивание
echo.
choice /c 1234 /n /m "  Ваш выбор [1-4]: "
if errorlevel 4 goto f4c4
if errorlevel 3 goto f4c3
if errorlevel 2 goto f4c2
goto f4c1

:f4c1
set /a score-=1
echo.
echo Неверно. Правильный ответ: 4.
goto f4_ok
:f4c2
set /a score-=1
echo.
echo Неверно. Правильный ответ: 4.
goto f4_ok
:f4c3
set /a score-=1
echo.
echo Неверно. Правильный ответ: 4.
goto f4_ok

:f4c4
set /a correct+=1
set /a score+=1
echo.
echo Верно! Строка 41 присваивает status, но результат нигде
echo не читается: значение сразу перезаписано на строке 42.
goto f5

:f4_ok
echo Значение переменной status из строки 41 ни разу не используется.

rem ==================================================================
rem  ФРАГМЕНТ 5. Отсутствие обработки ошибок
rem ==================================================================
:f5
echo.
pause
cls
echo Фрагмент 5 из 5 (создание задачи через REST API YouTrack):
echo.
echo    50: def create_issue(payload):
echo    51:     resp = requests.post(API + "/issues", json=payload)
echo    52:     return resp.json()["id"]
echo.
echo Какой дефект здесь скрыт?
echo   1. Отсутствие обработки ошибок
echo   2. Магическое число
echo   3. Мёртвое присваивание
echo   4. Утечка ресурса
echo.
choice /c 1234 /n /m "  Ваш выбор [1-4]: "
if errorlevel 4 goto f5c4
if errorlevel 3 goto f5c3
if errorlevel 2 goto f5c2
goto f5c1

:f5c1
set /a correct+=1
set /a score+=1
echo.
echo Верно! Нет try/except и нет проверки resp.status_code:
echo сетевой сбой или ответ 500 уронят весь процесс синхронизации.
goto report
:f5c2
set /a score-=1
echo.
echo Неверно. Правильный ответ: 1.
goto f5_ok
:f5c3
set /a score-=1
echo.
echo Неверно. Правильный ответ: 1.
goto f5_ok
:f5c4
set /a score-=1
echo.
echo Неверно. Правильный ответ: 1.
goto f5_ok

:f5_ok
echo Любая ошибка сети или ответ сервера с кодом 4xx/5xx
echo не обрабатывается и приводит к аварийному завершению.

rem ==================================================================
rem  ИТОГОВЫЙ ОТЧЁТ МОДУЛЯ
rem ==================================================================
:report
set /a percentage=correct*100/total
if %percentage% lss 0 set /a percentage=0
if %percentage% gtr 100 set /a percentage=100

echo.
echo ==================================================================
echo   ИТОГОВЫЙ ОТЧЁТ МОДУЛЯ 2
echo ------------------------------------------------------------------
echo   Просмотрено фрагментов: %total%
echo   Правильных ответов:    %correct% из %total%
echo   Итоговый балл:         %score%
echo   Точность:              %percentage%%%

if %percentage% geq 80 goto lvl_senior
if %percentage% geq 50 goto lvl_middle
goto lvl_junior

:lvl_senior
echo.
echo   Уровень ревьюера: Senior Reviewer
echo   Отличный результат: дефекты находятся уверенно.
set "RESULT_REVIEW=Senior Reviewer"
goto report_done

:lvl_middle
echo.
echo   Уровень ревьюера: Middle Reviewer
echo   Хороший результат: базовые дефекты находятся, но есть пробелы.
set "RESULT_REVIEW=Middle Reviewer"
goto report_done

:lvl_junior
echo.
echo   Уровень ревьюера: Junior Reviewer
echo   Стоит повторить типовые дефекты кода: ресурсы, магические
echo   числа, обработка ошибок.
set "RESULT_REVIEW=Junior Reviewer"

:report_done
set "RESULT_CORRECT=%correct%"
set "RESULT_TOTAL=%total%"
set "RESULT_PERCENT=%percentage%"
echo.
echo ------------------------------------------------------------------
echo   Модуль 2 завершён. Результат передан в главную систему.
echo ------------------------------------------------------------------
pause
