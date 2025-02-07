echo Restarting Windows Explorer...

:: Step 1: Kill explorer.exe process
taskkill /f /im explorer.exe

:: Step 2: Wait for a moment
timeout /t 2 >nul

:: Step 3: Restart explorer.exe process
start explorer.exe