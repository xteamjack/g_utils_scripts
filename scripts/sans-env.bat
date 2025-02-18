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
set SANS_BASE_NODE=D:/wspc3/repo/node
set SANS_BASE_PYTHON=D:/wspc3/repo/python
set SANS_VAULT=D:/wspc3/repo/node/config.info/vault

echo -- done!