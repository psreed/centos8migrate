# costos8migrate

Puppet Helpers to Migrate from `CentOS 8` to `Alma Linux 8`, `Rocky Linux 8` or `CentOS 8 Stream`

## WARNING: Use at your own risk. There is NO Support for this module.

### Note: Testing was done with the latest release of CentOS 8 Only. For this reason, I suggest starting with 


## PQL Query to identify all `CentOS 8` (excluding CentOSSteam) hosts in your environment

```inventory[certname,facts.os.distro.id,facts.os.release.major] { facts.os.name = "CentOS" and facts.os.release.major="8" and facts.os.distro.id!="CentOSStream"}```

## Tasks

### toCentOSVault

This task will modify yum to point to the archived version of CentOS 8. 
I would recommend starting with this and making sure your release is as up to date as possible before conversion to other releases.
This could probably be skipped for CentOS Stream conversions.

### toCentOSStream

This task will convert CentOS 8 hosts to CentOSSteam, performing a reboot on completion.

### toAlmaLinux

This task will convert CentOS 8 hosts to Alma Linux 8, performing a reboot on completion.

### toRocky

This task will convert CentOS 8 hosts to Rocky Linux 8, performing a reboot on completion.


