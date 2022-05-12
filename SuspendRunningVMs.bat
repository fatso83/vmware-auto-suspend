@echo off
echo SuspendRunningVMs Command (x64)...
REM https://stackoverflow.com/questions/20691060/echo-a-blank-empty-line-to-the-console-from-a-windows-batch-file
echo(
echo Ideas for improving this? Visit https://github.com/fatso83/vmware-auto-suspend
echo(
echo(

SETLOCAL
REM Specify where vmrun.exe can be located
SET WSPath="C:\Program Files (x86)\VMware\VMware Workstation"

REM Get the list of currently running VMs
%WSPath%\vmrun.exe list > %temp%\vmlist.txt

REM Suspend all running VMs
FOR /F "delims=* skip=1" %%v IN (%temp%\vmlist.txt) DO CALL :SuspendVM "%%v"

:WaitLoop
echo Waiting for the VMs to suspend...
REM Pause until no more VMs are running
%WSPath%\vmrun.exe list | FIND "Total running VMs: 0"
IF NOT ERRORLEVEL 1 GOTO End
timeout /t 5/nobreak
GOTO WaitLoop
 
:End
echo End of script; all VMs suspended.
ENDLOCAL
GOTO :EOF
 
REM Suspend a VM
:SuspendVM
echo Suspending VM %1
%WSPath%\vmrun.exe suspend %1
REM Allow some time after suspend call (allow disk to write vmem).
echo Wait a little bit for the VM to commit...
timeout /t 10 /nobreak
GOTO :EOF
 
REM Resume a VM (not used now, but may have use in future)
:ResumeVM
echo Starting VM %1
%WSPath%\vmrun.exe start %1
GOTO :EOF
 
:EOF
