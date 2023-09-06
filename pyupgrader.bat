@echo off

REM Set variables 
set py_oldversion=3.3.3
set py_newversion=

REM Find latest Python version
for /F "tokens=* skip=2" %%a in ('py -0p') do (
  set py_newversion=%%a
)

REM Check if already up-to-date
if "%py_oldversion%"=="%py_newversion%" (
  echo Python is already up-to-date at version %py_newversion%
  goto :EOF
)

REM Upgrade Python using pip
echo Upgrading Python to %py_newversion% using pip...
py -m pip install --upgrade python

REM Check Python version
python --version > new_version.txt

REM Compare versions
if %py_newversion%==$(type new_version.txt) (
  echo Python upgraded successfully to %py_newversion%  
) else (
  echo Failed to upgrade Python to %py_newversion%
)

REM Clean up 
del new_version.txt

echo Done!
