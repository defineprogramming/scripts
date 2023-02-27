@echo off
rem Download Python installer from official website
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.python.org/ftp/python/3.10.1/python-3.10.1-amd64.exe', 'C:\Temp\python-3.10.1-amd64.exe')"
rem Run installer silently with default options
C:\Temp\python-3.10.1-amd64.exe /quiet InstallAllUsers=0 PrependPath=1 Include_test=0
rem Delete installer file
del C:\Temp\python-3.10.1-amd64.exe
