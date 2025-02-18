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
set SANS_STORE_BASE=D:/wspc3/store
set SANS_TEMP_BASE=D:/wspc3/temp

echo -- done!