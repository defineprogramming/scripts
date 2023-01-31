REM Write a Batch script that disables the policy to block Chrome settings.
@echo off
REM Disable the policy to block Chrome settings.
REG ADD "HKLM\SOFTWARE\Policies\Google\Chrome" /v ExtensionInstallForcelist /t REG_SZ /d "" /f
