@echo off
echo ManualStep: Uncomment "import site"  line in python312._pth
pause

SET PYTHON_BASE_DIR=D:\bin\python\

set pyVer=%1%

if "%pyVer%"== "" (
    echo Expected python version as arg1
    exit /b 1
) 

echo Setting Python environment %pyVer%
set verDir=%PYTHON_BASE_DIR%%pyVer%
echo Python Dir %verDir%

set PATH=%verDir%\;%verDir%\Scripts;%PATH%
set PY_LIBS=%verDir%\Lib;%verDir%\Lib\site-packages
set PY_PIP=%verDir%\Scripts
set PIP_INSTALLER_LOCATION=%verDir%\get-pip.py

echo Setting up python %pyVer%
echo -------------------------------
echo.


@REM set DIR=D:\bin\python\3.12.9

@REM set PATH=%DIR%\;%DIR%\Scripts;%PATH%
@REM set PY_LIBS=%DIR%\Lib;%DIR%\Lib\site-packages
@REM set PY_PIP=%DIR%\Scripts
@REM set SKIP_VENV=1
@REM set PIP_INSTALLER_LOCATION=%DIR%\get-pip.py
@REM set TRANSFORMERS_CACHE=%DIR%\transformers-cache

python --version
copy %PYTHON_BASE_DIR%\get-pip.py  %verDir%
python %PIP_INSTALLER_LOCATION%
python -m pip install --upgrade pip

pip --version

pip install virtualenv