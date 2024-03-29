@echo off
set sdate1=20%date:~-2%%date:~4,2%%date:~7,2%
set sdate2=20231201
if %sdate1% GEQ %sdate2% (goto label1) else echo Script can not be run before Dec 01 11AM
goto endprogram
:label1
echo Checking time
set shour1=%time:~0,2%
set shour2=11
if %shour1% GEQ %shour2% (goto label2) else echo Script can not be run before Dec 01 11AM
goto endprogram
:label2
echo Remapping Network Drive
net use z: /delete
net use z: \\networkshare\path /persistent:yes
:endprogram
pause