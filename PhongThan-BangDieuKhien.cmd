@echo off
rem Mo bang dieu khien Phong Than: Bat server / Dung server / Tao tai khoan / Trang thai
start "Phong Than Control" powershell.exe -NoProfile -STA -ExecutionPolicy Bypass -WindowStyle Hidden -File "%~dp0PhongThanSource\Deploy\PhongThan-Control.ps1"
