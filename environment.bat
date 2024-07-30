@echo off

set DIR=%~dp0system

set PATH=%DIR%\git\bin;%DIR%\python;%DIR%\python\Scripts;%PATH%;%DIR%\python\Lib\site-packages\torch\lib
set PY_LIBS=%DIR%\python\Scripts\Lib;%DIR%\python\Scripts\Lib\site-packages
set PY_PIP=%DIR%\python\Scripts
set PIP_INSTALLER_LOCATION=%DIR%\python\get-pip.py
set GENERATE_PTH=%DIR%\python\generate_pth.py
set HF_HOME=%DIR%\hf-home
