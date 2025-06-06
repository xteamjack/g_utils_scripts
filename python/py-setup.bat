rem echo off
echo Python environment setup tool
echo -------------------------------
echo.

set pyVer=%1

if "%pyVer%"== "" (
    echo Expected python version as arg1
    echo Alternatively setting version 3.10.6 as default
    set pyVer=3.10.6
) 

echo Setting Python environment %pyVer%
set verDir=%~dp0%pyVer%
echo Python Dir %verDir%

set PATH=%verDir%\;%verDir%\Scripts;%PATH%
set PY_LIBS=%verDir%\Lib;%verDir%\Lib\site-packages
set PY_PIP=%verDir%\Scripts
set PIP_INSTALLER_LOCATION=%verDir%\get-pip.py

rem uncomment import site line in pythonxxx.pth file

copy get-pip.py %PIP_INSTALLER_LOCATION%
python --version
python %PIP_INSTALLER_LOCATION%
python -m pip install --upgrade pip
pip --version

pip install virtualenv

echo.
echo Checking key applications
python --version
pip --version
jupyter --version

echo.
echo Configure additional utilities
echo ...poppler
set PATH=D:\bin\poppler\24.08.0\Library\bin;%PATH%