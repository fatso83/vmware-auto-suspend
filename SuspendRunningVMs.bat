@echo off
echo SuspendRunningVMs Command (x64)...

SETLOCAL
REM Specify where vmrun.exe can be located
SET WSPath="C:\Program Files (x86)\VMware\VMware Workstation"

REM Get the list of currently running VMs
%WSPath%\vmrun.exe list | FIND /V "Total running VMs:" > %temp%\vmlist.txt

REM Suspend all running VMs
FOR /F "delims=*" %%v IN (%temp%\vmlist.txt) DO CALL :SuspendVM "%%v"

:WaitLoop
echo Waiting for the VMs to suspend...
REM Pause until no more VMs are running
%WSPath%\vmrun.exe list | FIND "Total running VMs: 0"
IF NOT ERRORLEVEL 1 GOTO End
timeout /t 10 /nobreak
GOTO WaitLoop
 
:End
echo End of script; all VMs suspended.
ENDLOCAL
GOTO :EOF
 
REM Suspend a VM
:SuspendVM
REM Suspend any running VM.  Workaround a "vmrun list" quirk that outputs
REM a blank line, by not trying to suspend a blank VM
IF %1x==x GOTO :EOF
echo Suspending VM %1
%WSPath%\vmrun.exe suspend %1
REM Allow some time after suspend call (allow disk to write vmem).
echo Wait a little bit for the VM to commit...
timeout /t 15 /nobreak
GOTO :EOF
 
REM Resume a VM (not used now, but may have use in future)
:ResumeVM
REM Resume any suspended VM.  Workaround a "vmrun list" quirk that outputs
REM a blank line, by not trying to start a blank VM
IF %1x==x GOTO :EOF
echo Starting VM %1
%WSPath%\vmrun.exe start %1
GOTO :EOF
 
:EOF
