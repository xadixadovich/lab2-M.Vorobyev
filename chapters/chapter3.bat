@echo off
chcp 65001 >nul
title Модуль 3 - Сравнительный анализ (метод WSM)

rem ==================================================================
rem  ЛАБОРАТОРНАЯ РАБОТА N2, ЧАСТЬ 3
rem  Модуль сравнительного анализа альтернатив методом взвешенной
rem  суммы (Weighted Sum Model): S = сумма(Wi * Xi).
rem  Вариант 5: YouTrack / Redmine / Taiga
rem ==================================================================

:start
cls
echo ==================================================================
echo   МОДУЛЬ 3. СРАВНИТЕЛЬНЫЙ АНАЛИЗ АЛЬТЕРНАТИВ (WSM)
echo ------------------------------------------------------------------
echo   Альтернативы: YouTrack, Redmine, Taiga
echo   Метод: взвешенная сумма S = СУММА(W * X)
echo ==================================================================
echo.

rem ==================================================================
rem  ШАГ 1. Пользователь назначает веса критериям
rem ==================================================================
echo Шаг 1. Назначьте веса четырём критериям.
echo Сумма весов должна быть ровно 100.
echo.
echo   Критерий 1. Гибкость настройки под Scrum
echo   Критерий 2. Стоимость владения
echo   Критерий 3. Интеграции и API
echo   Критерий 4. Простота освоения командой
echo.
set /p w1="  Вес критерия 1: "
set /p w2="  Вес критерия 2: "
set /p w3="  Вес критерия 3: "
set /p w4="  Вес критерия 4: "

set /a total_weight=w1+w2+w3+w4
if %total_weight% neq 100 (
    echo.
    echo Ошибка: сумма весов равна %total_weight%, а должна быть 100.
    echo Попробуйте снова.
    echo.
    pause
    goto start
)

rem --- Проверка, что ни один вес не отрицательный -------------------
set "bad=0"
if %w1% lss 0 set "bad=1"
if %w2% lss 0 set "bad=1"
if %w3% lss 0 set "bad=1"
if %w4% lss 0 set "bad=1"
if "%bad%"=="1" (
    echo.
    echo Ошибка: вес не может быть отрицательным.
    echo.
    pause
    goto start
)

rem ==================================================================
rem  ШАГ 2. Оценка альтернатив по шкале 1-5
rem ==================================================================
cls
echo Шаг 2. Оцените каждую альтернативу по каждому критерию.
echo Шкала: 1 - очень плохо, 5 - отлично.
echo.
echo --- YouTrack ---
set "prompt=  YouTrack, критерий 1 - гибкость Scrum: "
call :read_rating
set "y1=%rv%"
set "prompt=  YouTrack, критерий 2 - стоимость владения: "
call :read_rating
set "y2=%rv%"
set "prompt=  YouTrack, критерий 3 - интеграции и API: "
call :read_rating
set "y3=%rv%"
set "prompt=  YouTrack, критерий 4 - простота освоения: "
call :read_rating
set "y4=%rv%"

echo.
echo --- Redmine ---
set "prompt=  Redmine, критерий 1 - гибкость Scrum: "
call :read_rating
set "r1=%rv%"
set "prompt=  Redmine, критерий 2 - стоимость владения: "
call :read_rating
set "r2=%rv%"
set "prompt=  Redmine, критерий 3 - интеграции и API: "
call :read_rating
set "r3=%rv%"
set "prompt=  Redmine, критерий 4 - простота освоения: "
call :read_rating
set "r4=%rv%"

echo.
echo --- Taiga ---
set "prompt=  Taiga, критерий 1 - гибкость Scrum: "
call :read_rating
set "t1=%rv%"
set "prompt=  Taiga, критерий 2 - стоимость владения: "
call :read_rating
set "t2=%rv%"
set "prompt=  Taiga, критерий 3 - интеграции и API: "
call :read_rating
set "t3=%rv%"
set "prompt=  Taiga, критерий 4 - простота освоения: "
call :read_rating
set "t4=%rv%"

rem ==================================================================
rem  ШАГ 3. Расчёт взвешенных сумм S = СУММА(W * X)
rem ==================================================================
set /a s_y=y1*w1+y2*w2+y3*w3+y4*w4
set /a s_r=r1*w1+r2*w2+r3*w3+r4*w4
set /a s_t=t1*w1+t2*w2+t3*w3+t4*w4

rem ==================================================================
rem  ШАГ 4. Вывод матрицы решений в табличном виде
rem ==================================================================
cls
call :pad30 "Критерий"
set "nh=%pad%"
call :pad30 "Гибкость настройки под Scrum"
set "n1=%pad%"
call :pad30 "Стоимость владения"
set "n2=%pad%"
call :pad30 "Интеграции и API"
set "n3=%pad%"
call :pad30 "Простота освоения"
set "n4=%pad%"
call :pad30 "ИТОГО"
set "nt=%pad%"

call :pad4 %w1%
set "cw1=%pad%"
call :pad4 %w2%
set "cw2=%pad%"
call :pad4 %w3%
set "cw3=%pad%"
call :pad4 %w4%
set "cw4=%pad%"
call :pad4 %total_weight%
set "cwt=%pad%"

call :pad9 %y1%
set "cy1=%pad%"
call :pad9 %y2%
set "cy2=%pad%"
call :pad9 %y3%
set "cy3=%pad%"
call :pad9 %y4%
set "cy4=%pad%"
call :pad9 %r1%
set "cr1=%pad%"
call :pad9 %r2%
set "cr2=%pad%"
call :pad9 %r3%
set "cr3=%pad%"
call :pad9 %r4%
set "cr4=%pad%"
call :pad9 %t1%
set "ct1=%pad%"
call :pad9 %t2%
set "ct2=%pad%"
call :pad9 %t3%
set "ct3=%pad%"
call :pad9 %t4%
set "ct4=%pad%"
call :pad9 %s_y%
set "csy=%pad%"
call :pad9 %s_r%
set "csr=%pad%"
call :pad9 %s_t%
set "cst=%pad%"

set "hh_w= Вес"
set "hh_y= YouTrack"
set "hh_r=  Redmine"
set "hh_t=    Taiga"
set "dl=-----------------------------------------------------------------------------"
set "sep=%dl:~0,30% %dl:~0,4% %dl:~0,9% %dl:~0,9% %dl:~0,9%"

echo ==================================================================
echo   МАТРИЦА РЕШЕНИЙ (метод взвешенной суммы)
echo ==================================================================
echo.
echo   %nh% %hh_w% %hh_y% %hh_r% %hh_t%
echo   %sep%
echo   %n1% %cw1% %cy1% %cr1% %ct1%
echo   %n2% %cw2% %cy2% %cr2% %ct2%
echo   %n3% %cw3% %cy3% %cr3% %ct3%
echo   %n4% %cw4% %cy4% %cr4% %ct4%
echo   %sep%
echo   %nt% %cwt% %csy% %csr% %cst%
echo.

rem --- Перевод взвешенных сумм в шкалу 0-5 --------------------------
set /a iy=s_y/100
set /a fy=s_y%%100
if %fy% lss 10 set "fy=0%fy%"
set /a ir=s_r/100
set /a fr=s_r%%100
if %fr% lss 10 set "fr=0%fr%"
set /a it=s_t/100
set /a ft=s_t%%100
if %ft% lss 10 set "ft=0%ft%"

echo   Нормированные оценки S/100:
echo     YouTrack: %iy%.%fy%     Redmine: %ir%.%fr%     Taiga: %it%.%ft%
echo.

rem ==================================================================
rem  ШАГ 5. Определение победителя
rem ==================================================================
set /a max3=%s_y%
if %s_r% gtr %max3% set /a max3=%s_r%
if %s_t% gtr %max3% set /a max3=%s_t%

set "p1="
set "p2="
set "p3="
if "%s_y%"=="%max3%" set "p1=YouTrack "
if "%s_r%"=="%max3%" set "p2=Redmine "
if "%s_t%"=="%max3%" set "p3=Taiga "
set "winners3=%p1%%p2%%p3%"
set /a cnt3=0
if defined p1 set /a cnt3+=1
if defined p2 set /a cnt3+=1
if defined p3 set /a cnt3+=1

if not "%cnt3%"=="1" goto w_tie
goto w_single

:w_single
echo ------------------------------------------------------------------
if "%winners3%"=="YouTrack " goto w_y
if "%winners3%"=="Redmine " goto w_r
goto w_t

:w_y
echo   ПОБЕДИТЕЛЬ: YouTrack  -  %s_y% баллов
echo.
echo   Вывод: для вашего набора весов YouTrack даёт лучший баланс.
echo   Гибкие workflow, готовые Agile-доски и интеграции с Git
echo   закрывают требования Scrum-команды с минимальными доработками.
set "RESULT_WINNER=YouTrack"
goto w_done

:w_r
echo   ПОБЕДИТЕЛЬ: Redmine  -  %s_r% баллов
echo.
echo   Вывод: для вашего набора весов Redmine выигрывает за счёт
echo   нулевой стоимости лицензий и полной кастомизации процессов.
echo   Платой за это станет администрирование собственного сервера.
set "RESULT_WINNER=Redmine"
goto w_done

:w_t
echo   ПОБЕДИТЕЛЬ: Taiga  -  %s_t% баллов
echo.
echo   Вывод: для вашего набора весов Taiga оптимальна: бесплатна,
echo   заточена под Scrum и осваивается командой без обучения.
set "RESULT_WINNER=Taiga"
goto w_done

:w_tie
echo ------------------------------------------------------------------
echo   Ничья: одинаковую максимальную оценку получили - %winners3%
echo.
echo   Рекомендация: Taiga (лучший баланс цены и удобства для Scrum).
set "RESULT_WINNER=Taiga"
goto w_done

:w_done
set "RESULT_WINNER_SCORE=Y=%s_y% R=%s_r% T=%s_t%"
echo.
echo ------------------------------------------------------------------
echo   Модуль 3 завершён. Результат передан в главную систему.
echo ------------------------------------------------------------------
pause
exit /b

rem ==================================================================
rem  ПОДПРОГРАММЫ
rem ==================================================================

rem --- Чтение оценки с проверкой диапазона 1-5 ----------------------
:read_rating
set "rv="
set /p rv=%prompt%
set /a rv=%rv%
if %rv% lss 1 goto read_bad
if %rv% gtr 5 goto read_bad
exit /b

:read_bad
echo   Ошибка: введите целое число от 1 до 5.
goto read_rating

rem --- Выравнивание текста по левому краю в поле шириной 30 ---------
:pad30
set "pad=%~1                                         "
set "pad=%pad:~0,30%"
exit /b

rem --- Выравнивание числа по правому краю в поле шириной 4 ----------
:pad4
set "pad=   %~1"
set "pad=%pad:~-4%"
exit /b

rem --- Выравнивание числа по правому краю в поле шириной 9 ----------
:pad9
set "pad=         %~1"
set "pad=%pad:~-9%"
exit /b
