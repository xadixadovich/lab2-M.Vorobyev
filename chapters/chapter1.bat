@echo off
chcp 65001 >nul
title Модуль 1 - Выбор системы отслеживания задач

rem ==================================================================
rem  ЛАБОРАТОРНАЯ РАБОТА N2, ЧАСТЬ 1
rem  Интерактивная система поддержки принятия решений:
rem  выбор системы отслеживания задач из трёх кандидатов.
rem  Вариант 5: YouTrack / Redmine / Taiga (команда 12 человек, Scrum)
rem ==================================================================

rem --- Профиль проекта: счётчики баллов для каждого кандидата --------
set score_youtrack=0
set score_redmine=0
set score_taiga=0

cls
echo ==================================================================
echo   МОДУЛЬ 1. МОДЕЛИРОВАНИЕ ПРОЦЕССА ВЫБОРА ТЕХНОЛОГИИ
echo ------------------------------------------------------------------
echo   Вариант 5. Выбор системы отслеживания задач
echo   Кандидаты: YouTrack, Redmine, Taiga
echo   Контекст: команда из 12 человек, работа по Scrum
echo ==================================================================
echo.
echo   Ответьте на 5 вопросов о характеристиках проекта.
echo   Для ответа нажмите нужную цифру на клавиатуре.
echo.

rem ==================================================================
rem  ВОПРОС 1. Масштаб команды и объём задач
rem ==================================================================
:q1
echo Вопрос 1 из 5. Сколько человек будет работать в трекере?
echo   1. До 5 человек
echo   2. От 6 до 15 человек
echo   3. Больше 15 человек
echo.
choice /c 123 /n /m "  Ваш выбор [1-3]: "
if errorlevel 3 goto q1c3
if errorlevel 2 goto q1c2
goto q1c1

:q1c1
set /a score_taiga+=10
set /a score_redmine+=5
goto q2

:q1c2
set /a score_youtrack+=10
set /a score_taiga+=10
set /a score_redmine+=5
goto q2

:q1c3
set /a score_youtrack+=15
set /a score_redmine+=10
goto q2

rem ==================================================================
rem  ВОПРОС 2. Бюджет на инструменты
rem ==================================================================
:q2
echo.
echo Вопрос 2 из 5. Какой бюджет выделен на систему трекинга?
echo   1. Только бесплатные решения с открытым кодом
echo   2. До 500 рублей в месяц за пользователя
echo   3. Бюджет есть, важнее удобство и поддержка
echo.
choice /c 123 /n /m "  Ваш выбор [1-3]: "
if errorlevel 3 goto q2c3
if errorlevel 2 goto q2c2
goto q2c1

:q2c1
set /a score_redmine+=15
set /a score_taiga+=10
set /a score_youtrack-=5
goto q3

:q2c2
set /a score_youtrack+=10
set /a score_taiga+=5
goto q3

:q2c3
set /a score_youtrack+=15
set /a score_redmine-=5
goto q3

rem ==================================================================
rem  ВОПРОС 3. Сроки внедрения и наличие администратора
rem ==================================================================
:q3
echo.
echo Вопрос 3 из 5. Как быстро нужно запустить трекер и есть ли админ?
echo   1. Запуск за один день, своего администратора нет
echo   2. Есть неделя на внедрение и один администратор
echo   3. Готовы развернуть на своём сервере, админ есть
echo.
choice /c 123 /n /m "  Ваш выбор [1-3]: "
if errorlevel 3 goto q3c3
if errorlevel 2 goto q3c2
goto q3c1

:q3c1
set /a score_youtrack+=15
set /a score_taiga+=10
goto q4

:q3c2
set /a score_redmine+=10
set /a score_taiga+=10
goto q4

:q3c3
set /a score_redmine+=15
set /a score_taiga+=15
set /a score_youtrack+=5
goto q4

rem ==================================================================
rem  ВОПРОС 4. Нужна ли доработка процессов под Scrum
rem ==================================================================
:q4
echo.
echo Вопрос 4 из 5. Насколько важна гибкая настройка рабочих процессов?
echo   1. Нужен готовый Scrum из коробки, настраивать некому
echo   2. Готовы настраивать workflow под себя
echo   3. Нужна глубокая кастомизация и открытый исходный код
echo.
choice /c 123 /n /m "  Ваш выбор [1-3]: "
if errorlevel 3 goto q4c3
if errorlevel 2 goto q4c2
goto q4c1

:q4c1
set /a score_taiga+=15
set /a score_youtrack+=10
goto q5

:q4c2
set /a score_youtrack+=15
set /a score_redmine+=5
goto q5

:q4c3
set /a score_redmine+=15
goto q5

rem ==================================================================
rem  ВОПРОС 5. Интеграции с Git, CI и мессенджерами
rem ==================================================================
:q5
echo.
echo Вопрос 5 из 5. Насколько важны готовые интеграции с Git и CI?
echo   1. Критичны готовые интеграции с Git, CI и мессенджерами
echo   2. Достаточно открытого REST API и вебхуков
echo   3. Интеграции не важны, работаем только в трекере
echo.
choice /c 123 /n /m "  Ваш выбор [1-3]: "
if errorlevel 3 goto q5c3
if errorlevel 2 goto q5c2
goto q5c1

:q5c1
set /a score_youtrack+=10
set /a score_taiga+=5
set /a score_redmine+=5
goto calc

:q5c2
set /a score_youtrack+=5
set /a score_redmine+=10
set /a score_taiga+=5
goto calc

:q5c3
set /a score_redmine+=5
goto calc

rem ==================================================================
rem  ПОДСЧЁТ РЕЗУЛЬТАТА: ищем максимальный балл и победителя
rem ==================================================================
:calc
cls
echo ==================================================================
echo   РЕЗУЛЬТАТ МОДУЛЯ 1
echo ==================================================================
echo.
echo   Таблица баллов:
echo.
echo     Кандидат      Баллы
echo     ------------  -----
echo     YouTrack      %score_youtrack%
echo     Redmine       %score_redmine%
echo     Taiga         %score_taiga%
echo.

set /a max_score=%score_youtrack%
if %score_redmine% gtr %max_score% set /a max_score=%score_redmine%
if %score_taiga% gtr %max_score% set /a max_score=%score_taiga%

rem --- Сколько кандидатов набрали максимальный балл ----------------
rem  Каждый if записан отдельной строкой, чтобы избежать проблем
rem  с раскрытием переменных внутри блоков ( ).
set "win1="
set "win2="
set "win3="
if "%score_youtrack%"=="%max_score%" set "win1=YouTrack "
if "%score_redmine%"=="%max_score%" set "win2=Redmine "
if "%score_taiga%"=="%max_score%" set "win3=Taiga "
set "winners=%win1%%win2%%win3%"
set /a cnt=0
if defined win1 set /a cnt+=1
if defined win2 set /a cnt+=1
if defined win3 set /a cnt+=1

if not "%cnt%"=="1" goto tie
goto single

:single
rem --- Ровно один лидер ---
if "%winners%"=="YouTrack " goto win_youtrack
if "%winners%"=="Redmine " goto win_redmine
goto win_taiga

:win_youtrack
echo   Рекомендация: YouTrack
echo.
echo   Почему: команде нужен готовый Agile-процесс, быстрый запуск без
echo   администратора и хорошая интеграция с Git. Облачная версия
echo   закрывает требования Scrum без доработок.
set "RESULT_TECH=YouTrack"
goto done

:win_redmine
echo   Рекомендация: Redmine
echo.
echo   Почему: бюджет минимальный, есть администратор и своя
echo   инфраструктура. Redmine бесплатен, ставится на свой сервер,
echo   а процессы и плагины настраиваются под любые правила команды.
set "RESULT_TECH=Redmine"
goto done

:win_taiga
echo   Рекомендация: Taiga
echo.
echo   Почему: команда работает по Scrum, нужен бесплатный инструмент
echo   с готовыми эпиками, спринтами и доской. Taiga даёт это сразу,
echo   без лишней настройки и без затрат на лицензии.
set "RESULT_TECH=Taiga"
goto done

:tie
echo   Ничья: одинаковый максимальный балл набрали -
echo   %winners%
echo.
echo   Рекомендация: Taiga (как наиболее сбалансированный вариант
echo   для Scrum-команды из 12 человек при ограниченном бюджете).
set "RESULT_TECH=Taiga"
goto done

:done
set "RESULT_TECH_SCORE=Y=%score_youtrack% R=%score_redmine% T=%score_taiga%"
echo.
echo ------------------------------------------------------------------
echo   Модуль 1 завершён. Результат передан в главную систему.
echo ------------------------------------------------------------------
pause
