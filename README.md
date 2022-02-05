# costos8migrate

Puppet Helpers to Migrate from `CentOS 8` to `Alma Linux 8`, `Rocky Linux 8` or `CentOS 8 Stream`

## WARNING: Use at your own risk. There is NO Support for this module.

## IMPORTANT STEPS -- Seriously, read this first!!!

#### Update to latest CentOS 8.5 EOL pacakges

Testing of these tasks was performed with the latest updates of `CentOS 8.5` that are available as of EOL in the vault archive.
For this reason, I suggest starting with the `toCentOSVault` task for all `CentOS 8` systems to update to that point before migration.

Testing was performed starting with:
- `CentOS 8.3 (version 2011)` ISO.
- `Server with GUI installation`
- Updated to latest 8.5 using the vault repos (`toCentOSVault` task).

#### Disable any Desired State Puppet Repo Management first 
If you are managing the CentOS repos using Puppet, you will want to disable that before running these tasks. You will need to modify that setup after the conversion either way. 
If this is not disabled prior to running, you may create a much larger issue with trying to apply the wrong repos to your hosts.



## PQL Query to identify all `CentOS 8` (excluding `CentOS 8 Steam`) hosts in your environment

```inventory[certname] { facts.os.name = "CentOS" and facts.os.release.major="8" and facts.os.distro.id!="CentOSStream"}```

## Tasks

### toCentOSVault

This task will modify your `yum repos` to point to the archived ("vault") version of the `CentOS 8` pacakges.
As part of this task, `yum update -y` will be run to make sure the latest available packages are installed.  

I would recommend starting with this task to make sure your release is as up to date as possible before conversion to other releases.
(This could probably be skipped for `CentOS Stream` conversions, but it's HIGHLY recommended for the other releases)

### toCentOSStream

This task will convert CentOS 8 hosts to CentOSSteam, performing a reboot on completion.

### toAlmaLinux

This task will convert CentOS 8 hosts to Alma Linux 8, performing a reboot on completion.

### toRocky

This task will convert CentOS 8 hosts to Rocky Linux 8, performing a reboot on completion.


