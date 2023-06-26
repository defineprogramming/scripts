@echo off
:: This batch file disables the proxy settings for the current user

:: Launch PowerShell to disable the proxy
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -name ProxyEnable -value 0"
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -name ProxyServer -value ''"

echo Proxy settings for the current user have been disabled.
pause
