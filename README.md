SuspendRunningVMs.bat
--------------------------------------
Contains the solution to this question:
> How do I set up VMWare Workstation (running on a Windows host) to 
> automatically suspend all guest VM's when the host OS shuts down or restarts?

This repo essentially just contains a single script that fixes the annoying
issue of losing your virtual machine state if Windows decides to log off 
and/or reboot. It does this by running the script when it detects certain
events associated with a logout.

While this feature does exist in VMWare, you have to convert your VM into
a shared vm, which involves losing a lot of features. This doesn't have 
that drawback.

## Installing

### Create a Scheduled Task in Windows Task Scheduler 
The heart of this work-around is to create a scheduled task using the Windows Task Scheduler.  The scheduled task should be triggered by certain system events (not by a specific time-of-day schedule).

There are several different events that must trigger this task, as some events apply to only certain shutdown sequences (i.e. command line-initiated, Windows UI initiated, power button, system updates, etc.)

#### Create a task
1. Launch "Task Scheduler"
1. Click on "Task Scheduler Library" treeview (left side of screen)
1. Click on "Create Task" in the Actions window (right side of screen)

#### General tab
1. Under "General" tab, provide an appropriate name
1. Under "General" tab, check:  "Run only when the user is logged on"
1. Under "General" tab, check:  "Run with highest privileges"

#### Triggers tab
Under "Triggers", you will click "New" to add a new trigger, and will repeat this and the following settings 6 times (6 individual triggering events should be set).  

For each:
1. "Begin the task:" should be set to "On an event"
1. Select the Log, and the Source, and type in the Event ID for each of the 6 events.  

The rest of the settings on the screen can be left at their defaults.

```
Log:System
Source:User32
Event ID:1074
```
 
```
Log:  Microsoft-Windows-Winlogon/Operational
Source:Winlogon
Event ID:7002
```
 
```
Log:  Microsoft-Windows-Eventlog-ForwardingPlugin/Operational
Source:Eventlog-ForwardingPlugin
Event ID:6005
```
 
```
Log:  Microsoft-Windows-Eventlog-ForwardingPlugin/Operational
Source:Eventlog-ForwardingPlugin
Event ID:6006
```

```
Log:Security
Source:Microsoft Windows security auditing.
Event ID:4634
```

```
Log:Security
Source:Microsoft Windows security auditing.
Event ID:4647
```

#### Actions tab
1. Click "New" 
2. Use the default Action of "Start a program"
3. Click Browse or type in the path to the batch file ([which you have downloaded][script])

By using a scheduled task that is triggered by these events, it seems like Windows 10 does reliably launch the batch file at shutdown (or more technically correct, at user logoff).


## Background
After a long and bumpy road through both [StackExchange][superuser] and the 
[VMWare Community Forums](https://communities.vmware.com/thread/618322) I 
finally was given a hint to [a useful thread][vmware] that contained
_exactly_ what I was interested in. 

But as that was kind of hidden and in a form that is hard to contribute to
if you find bugs in the solutin, I decided to improve on this situation
by dumping the solution on GitHub. That fixes troublesome copy-paste
issues and makes it possible for some clever individual to perhaps contribute
a script that automates the manual steps involved in making the event
triggered script.

[vmware]: https://communities.vmware.com/thread/570079 "VMWare Community Post with original solution"
[superuser]: https://superuser.com/questions/1482205/auto-snapshot-or-suspend-on-host-power-off-or-log-off "My StackExchange question"
[script]: https://raw.githubusercontent.com/fatso83/vmware-auto-suspend/master/SuspendRunningVMs.bat
