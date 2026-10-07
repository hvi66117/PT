@echo off
rem Mo client Phong Than truc tiep (may nay khong co VC6 DUMPBIN nen khong dung nut "Mo client")
rem Truoc khi mo: ap cac ban va byte cho client (AdminWeb\PhongThan-ClientPatch.ps1), vd dung thuoc trong tui.
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0AdminWeb\PhongThan-ClientPatch.ps1"
set "__COMPAT_LAYER=HIGHDPIAWARE"
start "" /D "%~dp0PhongThanRuntime-Staging\Client" "%~dp0PhongThanRuntime-Staging\Client\Game.exe"
