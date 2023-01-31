REM Write a Batch code that disables policies blocking the use of the Remote Shutdown dialogue.

REM Disable the policy that blocks the use of the Remote Shutdown dialogue.
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableCAD /t REG_DWORD /d 0 /f

REM Open the Remote Shutdown dialogue.
shutdown -i
