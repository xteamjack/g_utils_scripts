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
set SANS_CODE_BASE=D:\wspc3\repo

:: Use this for the old modules using file based config.info
:: set SANS_CONFIG_BASE=D:\wspc3\repo\other\config.info
set SANS_CONFIG_BASE=D:\wspc3\repo\node\n_g_t_mw_api_config\server\vault
set SANS_LOG_BASE=D:\wspc3\logs
set SANS_STORE_BASE=D:\wspc3\store
set SANS_TEMP_BASE=D:\wspc3\temp

:: Server configuration - Reserved for key app servers
set SANS_SERVER_NS=https://localhost:3101

:: Server starting 3201 to be removed after the name server implementation
set SANS_SERVER_CDN=https://localhost:3201
set SANS_SERVER_CONFIG=https://localhost:3202

:: Application specific configuration
set DH_JWT_SECRET=s3cR3t!K3y@1234#AbCdEfGhIjKlMnOpQrStUvWxYz0987654321

set DH_SSL_KEY=D:/wspc3/repo/other/config.info/vault.1/internal/local/dev/keys/dh_main.key
set DH_SSL_CERT=D:/wspc3/repo/other/config.info/vault.1/internal/local/dev/keys/dh_main.crt

:: Node configuration
set NODE_ENV=%SANS_ENV%
set PATH=D:\bin\node\v22.15.0;%PATH%
    
:: Additional configurations
:: This is required to run python application in monorepo configuration
set PYTHONPATH=%SANS_CODE_BASE%\python
set PYTHONPATH=%PYTHONPATH%;%SANS_CODE_BASE%\python

:: Configure additional python tools

set PATH=D:\bin\pandoc\3.6.3;C:\Program Files\Tesseract-OCR;D:\bin\ffmpeg\bin;%PATH%



set PNPM_HOME=D:\bin\pnpm\10.6.4

set PATH=%PNPM_HOME%;%PATH%

:: Special config parameters


set | findstr "SANS"
echo.
set | findstr "DH"

echo.

