:: Script to install submodule npms without having to leave the main module
:: Eg., if you are in app and a module is required in the sub library libs, that needs to be installed in that directory
::   which is often enoying as you need to move to the sub module,install and come back. This is useful there


:: ToDo:: Not working, you can see that installation in working but the installed lib is not found in node_modules and [package.json
::   not sure what isthe issue. To be fixed

@REM @echo off
setlocal

:: Check if first argument (folder name) is provided
if "%~1"=="" (
    echo [ERROR] You must provide the subfolder name as the first argument.
    echo Usage: %~nx0 folderName [npm args...]
    exit /b 1
)

:: Extract first argument as folder name
set "FOLDER_NAME=%~1"

:: Build the remaining arguments
set "NPM_ARGS="
set /a index=0
for %%A in (%*) do (
    set /a index+=1
    if !index! gtr 1 (
        set "NPM_ARGS=!NPM_ARGS! %%A"
    )
)

:: Save original directory
set "ORIG_DIR=%CD%"

:: Set target dir using first argument
set "TARGET_DIR=D:\wspc3\repo\node\%FOLDER_NAME%"

:: Change to target directory
cd /d "%TARGET_DIR%" || (
    echo [ERROR] Could not change to folder: %TARGET_DIR%
    exit /b 1
)

:: Run npm install with remaining arguments
if not defined NPM_ARGS (
    npm install
) else (
    npm install %NPM_ARGS%
)

:: Go back to original directory
cd /d "%ORIG_DIR%"

endlocal
