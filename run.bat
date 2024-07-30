@echo off
set COMMANDLINE_ARGS=--inbrowser --server_port 7865
call environment.bat

if exist %DIR%\python\python310._pth (
    del %DIR%\python\python310._pth
)



cd %~dp0kohya_ss
::call pip list
python.exe .\setup\validate_requirements.py
if %errorlevel% neq 0 exit /b %errorlevel%

:: If the exit code is 0, run the kohya_gui.py script with the command-line arguments
if %errorlevel% equ 0 (
    REM Check if the batch was started via double-click
    IF /i "%comspec% /c %~0 " equ "%cmdcmdline:"=%" (
        REM echo This script was started by double clicking.
        cmd /k python.exe kohya_gui.py %COMMANDLINE_ARGS%
    ) ELSE (
        REM echo This script was started from a command prompt.
        python.exe kohya_gui.py %COMMANDLINE_ARGS%
    )
)
