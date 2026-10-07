@echo off
rem Chay tat ca: kiem tra/cai database -> bat server -> mo web admin.
rem Them tham so "game" de mo luon client:  PhongThan-ChayTatCa.cmd game
title Phong Than - Chay tat ca
if /I "%~1"=="game" (
  powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0AdminWeb\PhongThan-RunAll.ps1" -WithClient
) else (
  powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0AdminWeb\PhongThan-RunAll.ps1"
)
pause
