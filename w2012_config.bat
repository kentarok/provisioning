@echo off

rem set IP=xx.xx.xx.xx
rem set FQDN=xx.cent7.local

rem netsh advfirewall set allprofiles state on
powershell -Command "winrm quickconfig -q"
rem echo %IP% %FQDN% >> %windir%\system32\drivers\etc\hosts

exit
