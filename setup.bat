@echo off

call environment.bat

REM Check whether the file path contains spaces or Chinese characters
for %%i in ("%~dp0") do (
    echo %%~fi | findstr /r /c:"[^\x20-\x7E]" >nul && (
        echo !!!The file path contains spaces or Chinese characters. Please move to a path without spaces or Chinese characters before executing.!!!
        exit /b 1
    )
)

python -mpip --help
if %ERRORLEVEL% == 0 goto :setup
if "%PIP_INSTALLER_LOCATION%" == "" goto :show_stdout_stderr
python "%PIP_INSTALLER_LOCATION%"
if %ERRORLEVEL% == 0 goto :setup
echo Couldn't install pip
python %PIP_INSTALLER_LOCATION%


:show_stdout_stderr

echo.
echo exit code: %errorlevel%

for /f %%i in ("tmp\stdout.txt") do set size=%%~zi
if %size% equ 0 goto :show_stderr
echo.
echo stdout:
type tmp\stdout.txt

:setup
python %GENERATE_PTH%

cd %~dp0kohya_ss

REM Check if the batch was started via double-click
IF /i "%comspec% /c %~0 " equ "%cmdcmdline:"=%" (
    REM echo This script was started by double clicking.
    cmd /k python .\setup\setup_windows.py
) ELSE (
    REM echo This script was started from a command prompt.
    python .\setup\setup_windows.py %*
)
