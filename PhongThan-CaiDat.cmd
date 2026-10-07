@echo off
rem Cai dat server Phong Than tren may moi: cai SQL LocalDB + khoi phuc database account.
title Phong Than - Cai dat server
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0AdminWeb\PhongThan-Setup.ps1" -Step all
pause
