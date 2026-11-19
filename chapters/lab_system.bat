@echo off
chcp 65001 >nul
title Система моделирования процессов разработки ПО
cd /d "%~dp0"

rem ==================================================================
rem  ЛАБОРАТОРНАЯ РАБОТА N2, ЧАСТЬ 4
rem  Главный файл системы: объединяет три модуля в единый комплекс
rem  и формирует итоговый отчёт в файле report.txt.
rem  Вариант 5: YouTrack / Redmine / Taiga
rem ==================================================================

rem --- Очищаем результаты предыдущих запусков ------------------------
set "RESULT_TECH="
set "RESULT_TECH_SCORE="
set "RESULT_REVIEW="
set "RESULT_CORRECT="
set "RESULT_TOTAL="
set "RESULT_PERCENT="
set "RESULT_WINNER="
set "RESULT_WINNER_SCORE="

:menu
cls
echo ==========================================================
echo    СИСТЕМА МОДЕЛИРОВАНИЯ ПРОЦЕССОВ РАЗРАБОТКИ ПО
echo    Вариант 5. Выбор системы отслеживания задач
echo ==========================================================
echo.
echo    1. Модуль выбора технологий
echo    2. Модуль инспекции кода
echo    3. Модуль сравнительного анализа
echo    4. Запустить все модули последовательно
echo    5. Выход
echo.
echo ==========================================================
set "choice="
set /p choice="  Ваш выбор: "

if "%choice%"=="1" goto run1
if "%choice%"=="2" goto run2
if "%choice%"=="3" goto run3
if "%choice%"=="4" goto run_all
if "%choice%"=="5" goto exit_app
echo.
echo Неверный пункт меню. Нажмите любую клавишу и попробуйте снова.
pause >nul
goto menu

rem ==================================================================
rem  Запуск отдельного модуля
rem ==================================================================
:run1
call chapter1.bat
goto menu

:run2
call chapter2.bat
goto menu

:run3
call chapter3.bat
goto menu

rem ==================================================================
rem  Последовательный запуск всех трёх модулей
rem ==================================================================
:run_all
call chapter1.bat
call chapter2.bat
call chapter3.bat
goto report

rem ==================================================================
rem  Итоговый отчёт системы
rem ==================================================================
:report
cls
rem --- Подставляем заглушки для модулей, которые не запускались ----
set "d_tech=%RESULT_TECH%"
if not defined d_tech set "d_tech=не запускался"
set "d_review=%RESULT_REVIEW%"
if not defined d_review set "d_review=не запускался"
set "d_winner=%RESULT_WINNER%"
if not defined d_winner set "d_winner=не запускался"

echo ==========================================================
echo             ИТОГОВЫЙ ОТЧЁТ СИСТЕМЫ
echo ==========================================================
echo.
echo   Дата: %DATE% %TIME%
echo.
echo   Модуль 1. Рекомендация по технологии: %d_tech%
if defined RESULT_TECH_SCORE echo             Баллы: %RESULT_TECH_SCORE%
echo.
echo   Модуль 2. Уровень ревьюера: %d_review%
if defined RESULT_CORRECT echo             Правильных ответов: %RESULT_CORRECT% из %RESULT_TOTAL% (точность %RESULT_PERCENT%%%)
echo.
echo   Модуль 3. Победитель сравнительного анализа: %d_winner%
if defined RESULT_WINNER_SCORE echo             Взвешенные суммы: %RESULT_WINNER_SCORE%
echo.
echo ==========================================================

rem --- Сохранение отчёта в файл report.txt -------------------------
> report.txt echo ==========================================================
>> report.txt echo              ИТОГОВЫЙ ОТЧЁТ СИСТЕМЫ
>> report.txt echo ==========================================================
>> report.txt echo.
>> report.txt echo Дата: %DATE% %TIME%
>> report.txt echo Студент: Воробьёв М.И., группа 3525П1ИН1
>> report.txt echo Вариант 5. Выбор системы отслеживания задач
>> report.txt echo Кандидаты: YouTrack, Redmine, Taiga
>> report.txt echo Контекст: команда из 12 человек, работа по Scrum
>> report.txt echo.
>> report.txt echo ----------------------------------------------------------
>> report.txt echo 1. Модуль выбора технологий
>> report.txt echo    Рекомендация: %d_tech%
>> report.txt echo    Баллы кандидатов: %RESULT_TECH_SCORE%
>> report.txt echo.
>> report.txt echo 2. Модуль инспекции кода
>> report.txt echo    Уровень ревьюера: %d_review%
>> report.txt echo    Правильных ответов: %RESULT_CORRECT% из %RESULT_TOTAL%
>> report.txt echo    Точность: %RESULT_PERCENT%%%
>> report.txt echo.
>> report.txt echo 3. Модуль сравнительного анализа
>> report.txt echo    Победитель: %d_winner%
>> report.txt echo    Взвешенные суммы: %RESULT_WINNER_SCORE%
>> report.txt echo ----------------------------------------------------------
>> report.txt echo.
>> report.txt echo Система отработала все три модуля и сформировала
>> report.txt echo согласованную рекомендацию по выбору трекера задач.

echo.
echo   Отчёт сохранён в файл report.txt в папке программы.
echo.
pause
goto menu

:exit_app
cls
echo.
echo   Работа системы завершена.
echo   Файл с итоговым отчётом: report.txt
echo.
timeout /t 2 >nul 2>&1
exit
