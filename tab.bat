@echo off
setlocal enabledelayedexpansion

:: Set the duration for the loop in seconds (5 minutes * 60 seconds)
set /a "duration=5*60"
:: Set the interval in seconds between opening new tabs
set /a "interval=1"
set /a "count=0"

:: Get the timestamp at which to stop the loop
for /f "delims=" %%a in ('powershell -Command "Get-Date -Date ((Get-Date).AddSeconds(%duration%)) -UFormat '%%s'"') do set "endtime=%%a"

:LoopStart
:: Get the current timestamp
for /f "delims=" %%a in ('powershell -Command "Get-Date -UFormat '%%s'"') do set "currenttime=%%a"

:: Check if the current time is less than the end time
if %currenttime% lss %endtime% (
    :: Open a new Edge tab
    start microsoft-edge:http://www.bing.com
    
    :: Increment the tab count
    set /a "count+=1"
    
    :: Output the count to the console
    echo Tab count: !count!
    
    :: Wait for the specified interval
    timeout /t %interval% /nobreak >nul
    
    :: Go back to the start of the loop
    goto :LoopStart
)

:: End of the script
echo Finished opening tabs for 5 minutes.
endlocal
