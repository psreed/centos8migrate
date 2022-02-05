# costos8migrate

Puppet Helpers to Migrate from `CentOS 8` to `Alma Linux 8`, `Rocky Linux 8` or `CentOS 8 Stream`

## WARNING: Use at your own risk. There is NO Support for this module.

## IMPORTANT STEPS -- Seriously, read this first!!!

#### Update to latest CentOS 8.5 EOL pacakges

Testing of these tasks was performed with the latest updates of `CentOS 8.5` that are available as of EOL in the vault archive.
For this reason, I suggest starting with the `to_centos_vault` task for all `CentOS 8` systems to update to that point before migration.

Testing was performed starting with:
- `CentOS 8.3 (version 2011)` ISO.
- `Server with GUI installation`
- Updated to latest 8.5 using the vault repos (`to_centos_vault` task).

#### Disable any Desired State Puppet Repo Management first 
If you are managing the CentOS repos using Puppet, you will want to disable that before running these tasks. You will need to modify that setup after the conversion either way. 
If this is not disabled prior to running, you may create a much larger issue with trying to apply the wrong repos to your hosts.


#### Systems will need online access to repos
These scripts assume that the systems will have access to the internet in order to download the new OS images/packages/updates.

#### These tasks will take a very long time to run.

Be patient.

Be more patient.

If you're still not patient enough, login to your target host and watch things with `top`. You should see lots of activity with `yum` and `semodule` processes, but they may pop in and out of the process list regularly. There are a lot of things to update and these things take time. Also, things are dependant on download speed.

#### Make Snapshots if you can!

If you're using this no VM images, make sure to use snapshots before running the migration scripts as this may be an irreversable change.
And don't forget to remove your snapshots after everything us verified and running well afterward!



## PQL Query to identify all `CentOS 8` (excluding `CentOS 8 Stream`) hosts in your environment

```inventory[certname] { facts.os.name = "CentOS" and facts.os.release.major="8" and facts.os.distro.id!="CentOSStream"}```

## Tasks

### to_centos_vault

This task will modify your `yum repos` to point to the archived ("vault") version of the `CentOS 8` pacakges.
As part of this task, `yum update -y` will be run to make sure the latest available packages are installed.  

I would recommend starting with this task to make sure your release is as up to date as possible before conversion to other releases.
(This could probably be skipped for `CentOS Stream` conversions, but it's HIGHLY recommended for the other releases)

### to_centos_stream

This task will convert CentOS 8 hosts to CentOSSteam, performing a reboot on completion.

Estimated runtime for this task is ~17mins on a 2CPU, 2GB RAM minimal "Server with GUI installation" with access to a 1000MBit/s internet connection.


### to_alma_linux

This task will convert CentOS 8 hosts to Alma Linux 8, performing a reboot on completion.

Estimated runtime for this task is ~26mins on a 2CPU, 2GB RAM minimal "Server with GUI installation" with access to a 1000MBit/s internet connection.


### to_rocky

This task will convert CentOS 8 hosts to Rocky Linux 8, performing a reboot on completion.

Estimated runtime for this task is ~26mins on a 2CPU, 2GB RAM minimal "Server with GUI installation" with access to a 1000MBit/s internet connection.


