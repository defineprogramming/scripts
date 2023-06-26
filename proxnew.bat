@echo off
:: This batch file disables the proxy settings for the current user

:: Disable the proxy for the current user
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f

:: Clear the proxy address for the current user
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "" /f

echo Proxy settings for the current user have been disabled.
pause
