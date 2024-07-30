@echo off

call environment.bat

git -C "%~dp0kohya_ss" pull 2>NUL
if %ERRORLEVEL% == 0 goto :done

git -C "%~dp0kohya_ss" reset --hard
git -C "%~dp0kohya_ss" pull

:done
pause
