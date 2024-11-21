@echo off

call py-base

REM Check if at least one argument is passed
IF "%~1"=="" (
    echo Python version not specified
    echo Pick from the below list
    dir %PYTHON_BASE_DIR% /ad /b /on
    exit /b 1
)

REM Check if the config file exists
IF EXIST config.cnf (
    echo Python version already configured
    type config.cnf
    exit /b 1
)

call py-env %1%

echo %1% > config.cnf

python -m virtualenv venv
.\venv\Scripts\activate