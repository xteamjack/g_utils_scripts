SET PYTHON_BASE_DIR=D:\bin\python\

set pyVer=%1%

if "%pyVer%"== "" (
    echo Expected python version as arg1
    exit /b 1
    echo Alternatively setting version 3.10.6 as default
    set pyVer=3.10.6
) 

echo Setting Python environment %pyVer%
set verDir=%PYTHON_BASE_DIR%%pyVer%
echo Python Dir %verDir%

set PATH=%verDir%\;%verDir%\Scripts;%PATH%
set PY_LIBS=%verDir%\Lib;%verDir%\Lib\site-packages
set PY_PIP=%verDir%\Scripts
set PIP_INSTALLER_LOCATION=%verDir%\get-pip.py