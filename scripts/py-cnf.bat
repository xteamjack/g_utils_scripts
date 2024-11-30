@echo off

call py-base

REM Flag -r is to deactivate venv
SET FOUND_R=false

REM Loop through all command-line arguments
FOR %%A IN (%*) DO (
    IF "%%A"=="-r" (
        SET FOUND_R=true
    )
)

REM You can use this check after the loop to determine if -r was found
IF "%FOUND_R%"=="true" (
    .\venv\Scripts\deactivate
    goto :EOF
)

REM Read the first line from the file
FOR /F "usebackq delims=" %%A IN ("config.cnf") DO (
    SET FIRST_LINE=%%A
    echo The first line is: %%A
    GOTO :PROC
)

:PROC

call py-env %FIRST_LINE%
cd
echo Activating venv
.\venv\Scripts\activate.bat

:EOF
