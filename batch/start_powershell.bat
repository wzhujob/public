@echo off
REM powershell.exe -executionpolicy bypass -windowstyle hidden -noninteractive -nologo -file "name_of_script.ps1"
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO Script has Administrator privileges. Starting Powershell script
    powershell.exe -executionpolicy RemoteSigned -file "helloworld.ps1"
) ELSE (
    ECHO This script must be run with Administrator privileges.
)
