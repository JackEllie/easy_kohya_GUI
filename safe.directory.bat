@echo off

call environment.bat

set "dir=%~dp0kohya_ss"
set "dir=%dir:\=/%"

:: Check if %dir% is already a safe directory
git config --global --get-all safe.directory | findstr /c:"%dir%" >nul
if %errorlevel% equ 0 (
    echo The directory "%dir%" is already in the safe directory list.
) else (
    git config --global --add safe.directory "%dir%"
    echo The directory "%dir%" has been successfully added to the safe directory list.
)

:done
pause
