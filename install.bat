REM @ECHO off

REM Check if admin and exit if not
NET SESSION >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo This script requires admin priviledges
    exit 1
)

REM https://stackoverflow.com/questions/17063947/get-current-batchfile-directory
SET CWD=%0\..
SET INSTALL_DIR=C:\vmware-auto-suspend

REM Clean up before copying
REM https://www.ghacks.net/2017/07/18/how-to-delete-large-folders-in-windows-super-fast/
DEL /f /q /s %INSTALL_DIR%\*.* > NUL
RMDIR /Q/S %INSTALL_DIR%

MKDIR %INSTALL_DIR%
COPY %CWD%\SuspendRunningVMs.bat %INSTALL_DIR%

SCHTASKS /create /TN "Auto Suspend VMWare instances" /XML %CWD%\vmware-auto-suspend.xml

