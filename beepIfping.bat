@ECHO OFF

SETLOCAL EnableDelayedExpansion

SET IP[1]=127.0.0.1

SET TimeBetweenPings=1
SET RetryBeforeBeep=1


REM SETTING FLAGS
FOR /F "tokens=2 delims==" %%A IN ('SET IP[') DO (
   SET AlertFlag[%%A]=0
)
 
:Home
CLS
REM PINGING DESTINATIONS

ECHO ERR EML TARGET IP ADDRESS
ECHO -------------------------

FOR /F "tokens=2,3 delims==" %%A IN ('SET IP[') DO (
   ECHO [!AlertFlag[%%A]!] [!AlertSentGood[%%A]!] [%%A]
   PING -n 1 %%A >NUL

   IF !errorlevel! == 0 (
		CALL :BEEP
   ) ELSE (
      SET AlertFlag[%%A]=0
      SET /a AlertFlag[%%A]+=1        
   )
)
PING -n %TimeBetweenPings% -w 1000 10.0.0.0>NUL
Goto Home

:BEEP
echo Server is up!
echo 
EXIT /b