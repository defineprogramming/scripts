@echo off
rem This script will trigger a BSoD on Windows 10.
rem Do not run this script unless you know what you are doing.

rem Create a new file called "BSoD.bat" and copy the following code into it:

:loop
rem This loop will run forever, causing the system to run out of memory and crash.

rem Allocate 1MB of memory.

mem 1048576

rem Sleep for 1 second.

ping 127.0.0.1 -n 1 > nul

goto loop

rem Run the script by double-clicking on it.
