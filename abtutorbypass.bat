@echo off
setlocal enabledelayedexpansion

REM Kill processes with 'Tutor' in their name
for /f "tokens=2" %%a in ('tasklist ^| findstr /i "Tutor"') do (
    echo Killing process %%a
    taskkill /F /PID %%a
)

REM Disable services with 'Tutor' in their name
for /f "tokens=1" %%a in ('sc query state^= all ^| findstr /i "SERVICE_NAME:.*Tutor"') do (
    set "serviceName=%%a"
    set "serviceName=!serviceName:~14!"
    echo Disabling service !serviceName!
    sc config "!serviceName!" start= disabled
)

endlocal
