@echo off
C:\PostScript\wget.exe https://github.com/ansible/ansible/blob/devel/examples/scripts/ConfigureRemotingForAnsible.ps1 --no-check-certificate
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Unrestricted C:\PostScript\ConfigureRemotingForAnsible.ps1
