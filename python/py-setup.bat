@echo off

set DIR=D:\bin\python\3.9.13

set PATH=%DIR%\;%DIR%\Scripts;%PATH%
set PY_LIBS=%DIR%\Lib;%DIR%\Lib\site-packages
set PY_PIP=%DIR%\Scripts
set SKIP_VENV=1
set PIP_INSTALLER_LOCATION=%DIR%\get-pip.py
set TRANSFORMERS_CACHE=%DIR%\transformers-cache

python --version
python %PIP_INSTALLER_LOCATION%
python -m pip install --upgrade pip
pip --version

pip install virtualenv