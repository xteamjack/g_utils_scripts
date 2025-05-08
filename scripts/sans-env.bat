@echo off
echo Setting environment variables for app development
echo.

:: App parameters
set SANS_APP_VER=0.0.2 

:: Multi-tier parameters
set SANS_INSTANCE=internal
set SANS_TARGET=local
set SANS_ENV=dev

:: Key path variables
:: Make sure folder donot end with /
set SANS_CODE_BASE=D:/wspc3/repo
set SANS_CONFIG_BASE=D:/wspc3/repo/other/config.info
set SANS_LOG_BASE=D:/wspc3/logs
set SANS_STORE_BASE=D:/wspc3/store
set SANS_TEMP_BASE=D:/wspc3/temp

:: Additional configurations
:: This is required to run python application in monorepo configuration
set PYTHONPATH=%SANS_CODE_BASE%\python

:: Application specific configuration
set DH_JWT_SECRET=s3cR3t!K3y@1234#AbCdEfGhIjKlMnOpQrStUvWxYz0987654321

set PATH=D:\bin\pandoc\3.6.3;C:\Program Files\Tesseract-OCR;D:\bin\ffmpeg\bin;%PATH%

set | findstr "SANS"
set | findstr "DH"


set PNPM_HOME=D:\bin\pnpm\10.6.4

set PATH=%PNPM_HOME%;%PATH%
