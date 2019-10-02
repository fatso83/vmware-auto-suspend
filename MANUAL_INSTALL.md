# Manual installation
This section was [originally in the README](https://github.com/fatso83/vmware-auto-suspend/tree/027faf6c03fd3bd7b6c6d3dd028bbbb8315ef17b#installing), 
but I managed to find a way of [automating it](https://github.com/fatso83/vmware-auto-suspend/issues/3). Still left here for 
reference.

### Create a Scheduled Task in Windows Task Scheduler 
<img src="./events.png" alt="A sample task using Norwegian Windows 10">
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
Event ID:4647
```

#### Changes from original solution
The original solution also mentioned the following event, but I disabled that as it caused issues [#1](https://github.com/fatso83/vmware-auto-suspend/issues/1) and [#2](https://github.com/fatso83/vmware-auto-suspend/issues/2). I have seen no negative effects so far.
```
Log:Security
Source:Microsoft Windows security auditing.
Event ID:4634
```
