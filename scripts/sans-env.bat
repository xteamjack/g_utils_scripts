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
set SANS_CODE_BASE=D:/wspc3/repo/
set SANS_CONFIG_BASE=D:/wspc3/repo/other/config.info
set SANS_LOG_BASE=D:/wspc3/logs
set SANS_STORE_BASE=z:/
set SANS_TEMP_BASE=D:/wspc3/temp

:: Additional configurations
:: This is required to run python application in monorepo configuration
set PYTHONPATH=%SANS_CODE_BASE%\python

set PATH=D:\bin\pandoc\3.6.3;%PATH%

set | findstr "SANS"