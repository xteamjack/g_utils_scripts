@echo off
:: Define variables
set appName=VSCode
set appPath="D:\bin\vscode\1.100.2\Code.exe"

:: Check if the app path exists
if not exist "%appPath%" (
    echo Error: Application not found at "%appPath%".
    pause
    exit /b 1
)

:: Add registry keys for the context menu
echo Adding context menu option...
:: reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\%appName%\Icon" /ve /t REG_SZ /d "Open with VS Code" /f
reg add "HKEY_CLASSES_ROOT\*\shell\%appName%" /ve /t REG_SZ /d "Open with VS Code" /f
reg add "HKEY_CLASSES_ROOT\*\shell\%appName%\command" /ve /t REG_SZ /d "\"%appPath%\" \"%%1\"" /f

echo Context menu option added successfully.

call RestartExplorer.bat
pause
