REM Write a batch script that installs the latest version of Python (3.11) and cirumvents any permission issues:

@echo off
setlocal
set "py=python-3.11.0-amd64.exe"
set "pyurl=https://www.python.org/ftp/python/3.11.0/%py%"
set "pydir=C:\Python311"
set "pyexe=%pydir%\python.exe"
set "pyget=%temp%\%py%"

echo Downloading Python...
powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%pyurl%', '%pyget%')"


