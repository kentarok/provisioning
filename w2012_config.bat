@echo off

set IP=10.122.221.160
set FQDN=sjchefs01.cent7.local

rem netsh advfirewall set allprofiles state on
powershell -Command "winrm quickconfig -q"
echo %IP% %FQDN% >> %windir%\system32\drivers\etc\hosts

exit
