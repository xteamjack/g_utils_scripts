:: Batch script for unix like touch command

@echo off
for %%f in (%*) do (
    echo Creating file: %%f
    type nul > %%f
    copy /b %%f% +,,
)
@REM echo Touch file %1
@REM type nul >>%1
@REM copy /b %1 +,,