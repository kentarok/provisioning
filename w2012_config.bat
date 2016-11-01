@echo off

rem netsh advfirewall set allprofiles state on
powershell -Command "winrm quickconfig -q"
echo 10.122.221.160 sjchefs01.cent7.local >> %windir%\system32\drivers\etc\hosts

exit
