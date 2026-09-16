@echo off
:: Antivirus Ancaman — 1-Click Installer
title Ancaman Antivirus Installer
cd /d "%~dp0"

:: Auto-elevate to Administrator if not already running as admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Meminta hak akses Administrator...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo.
echo  =========================================
echo   ANTIVIRUS ANCAMAN - Memulai Instalasi...
echo  =========================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0data\install.ps1"

echo.
pause
