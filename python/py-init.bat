@echo off
call py-env %1%

python -m virtualenv venv
.\venv\Scripts\activate