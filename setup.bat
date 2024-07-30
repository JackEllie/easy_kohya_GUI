@echo off

call environment.bat

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

REM Check if ffmpy is installed
python -c "import ffmpy" 2>NUL
IF %ERRORLEVEL% NEQ 0 (
    echo ffmpy is not installed. Installing...
    cd %~dp0system\python\ffmpy-0.3.2
    pip install .
)


cd %~dp0kohya_ss

REM Check if the batch was started via double-click
IF /i "%comspec% /c %~0 " equ "%cmdcmdline:"=%" (
    REM echo This script was started by double clicking.
    cmd /k python .\setup\setup_windows.py
) ELSE (
    REM echo This script was started from a command prompt.
    python .\setup\setup_windows.py %*
)
