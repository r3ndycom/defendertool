@echo off
setlocal enabledelayedexpansion

:: ==========================================================
:: DEFENDERTOOL AUTO INSTALLER (BAT VERSION)
:: INSTALL CERT + RUN DEFENDERTOOL.EXE
:: ==========================================================

:: ----- Lokasi script -----
set "BasePath=%~dp0"
cd /d "%BasePath%"

set "CertFile=DefenderTool.cer"
set "ExeFile=DefenderTool.exe"

:: ==========================================================
:: ADMIN CHECK
:: ==========================================================
:: Cek apakah script berjalan sebagai Administrator
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [!] Membutuhkan hak Administrator, mencoba elevasi...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: ==========================================================
:: VALIDASI FILE
:: ==========================================================
if not exist "%CertFile%" (
    echo.
    echo ERROR: File "%CertFile%" TIDAK DITEMUKAN!
    pause
    exit /b
)

if not exist "%ExeFile%" (
    echo.
    echo ERROR: File "%ExeFile%" TIDAK DITEMUKAN!
    pause
    exit /b
)

echo.
echo Installing certificate...

:: ==========================================================
:: INSTALL CERTIFICATE
:: ==========================================================
certutil -addstore Root "%CertFile%" >nul 2>&1
certutil -addstore TrustedPublisher "%CertFile%" >nul 2>&1

echo Certificate installed successfully!

echo.
echo ======================================
echo   INSTALLATION COMPLETE!
echo   DefenderTool is now TRUSTED & RUNNING
echo ======================================
echo.

timeout /t 2 >nul
exit /b
