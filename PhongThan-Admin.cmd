@echo off
rem Web quan tri Phong Than: http://localhost:8765/ (chi may nay). Dong cua so de tat web.
title Phong Than Admin
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0AdminWeb\PhongThan-Admin.ps1"
pause
