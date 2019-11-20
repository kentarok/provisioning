@echo off
bitsadmin.exe /TRANSFER htmlget https://github.com/ansible/ansible/blob/devel/examples/scripts/ConfigureRemotingForAnsible.ps1 c:\ConfigureRemotingForAnsible.ps1
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Unrestricted C:\ConfigureRemotingForAnsible.ps1
