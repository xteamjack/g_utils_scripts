@echo off
:: Define variables
set appName=VSCode

:: Remove registry keys
echo Removing context menu option...
reg delete "HKEY_CLASSES_ROOT\*\shell\%appName%" /f

echo Context menu option removed successfully.
pause