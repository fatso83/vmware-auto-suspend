SuspendRunningVMs.bat
--------------------------------------
Contains the solution to this question:
> How do I set up VMWare Workstation (running on a Windows host) to 
> automatically suspend all guest VM's when the host OS shuts down or restarts?

This repo essentially contains a solution to the annoying
issue of losing your virtual machine state if Windows decides to log off 
and/or reboot. It does this by running the script when it detects certain
events associated with a logout.

While this feature does exist in VMWare, you have to convert your VM into
a Shared VM, which involves losing a lot of features. This doesn't have 
that drawback. The original solution was published by [@drueter](https://github.com/DavidRueter) on the 
[VMWare Community forum][vmware].

## Installing

1. Download the [xml file][xml].
1. Open a `CMD` or `Powershell` terminal and navigate to where the file was downloaded 
1. Run `schtasks /create /TN "Auto Suspend VMWare instances" /XML vmware-auto-suspend.xml`
1. Download the [script][script] and put it in `C:/`.

If you choose to place the script somewhere else, you need to open the Windows Task Scheduler, edit the ""Auto Suspend VMWare instances" task and browse to where the script is located.

## Background
After a long and bumpy road through both [StackExchange][superuser] and the 
[VMWare Community Forums](https://communities.vmware.com/thread/618322) I 
finally was given a hint to [a useful thread][vmware] that contained
_exactly_ what I was interested in. 

But as that was kind of hidden and in a form that is hard to contribute to
if you find bugs in the solution, I decided to improve on this situation
by dumping the solution on GitHub. That fixes troublesome copy-paste
issues.

[vmware]: https://communities.vmware.com/thread/570079 "VMWare Community Post with original solution"
[superuser]: https://superuser.com/questions/1482205/auto-snapshot-or-suspend-on-host-power-off-or-log-off "My StackExchange question"
[script]: https://raw.githubusercontent.com/fatso83/vmware-auto-suspend/master/SuspendRunningVMs.bat
[xml]: https://raw.githubusercontent.com/fatso83/vmware-auto-suspend/master/vmware-auto-suspend.xml
