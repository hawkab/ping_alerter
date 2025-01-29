@echo off
setlocal enabledelayedexpansion

:: Используем переданный IP или значение по умолчанию
set IP_ADDRESS=%1
if "%IP_ADDRESS%"=="" set IP_ADDRESS=8.8.8.8

echo 📡 Мониторинг IP: %IP_ADDRESS%
echo Нажмите Ctrl+C для выхода.

set PINGED_ONCE=0

:loop
ping -n 1 -w 1000 %IP_ADDRESS% >nul
if %errorlevel%==0 (
    if %PINGED_ONCE%==0 (
        set FIRST_SUCCESS_TIME=%DATE% %TIME%
        echo.
        echo %DATE% %TIME% | 🟢 %IP_ADDRESS% стал доступен
        set PINGED_ONCE=1
    )
    echo             
    timeout /t 1 >nul
) else (
    echo %DATE% %TIME% | 🔴 %IP_ADDRESS% пока не доступен...   
    set PINGED_ONCE=0
    timeout /t 1 >nul
)
goto loop
