@echo off
REM Restart print spooler and delete all print jobs
net stop Spooler
REM timeout 5
taskkill /f /im printfilterpipelinesvc.exe
del c:\windows\system32\spool\printers\*.*
net start Spooler
