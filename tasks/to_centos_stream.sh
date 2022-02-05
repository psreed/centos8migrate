#!/bin/sh

# Check to make sure we are actually on a CentOS 8.5.2111 host
if [ -f /etc/redhat-release ]; then 

  RELEASE=`head -1 /etc/redhat-release`
  if [[ "${RELEASE}" == *"8.5.2111" ]]; then
    echo "Release: ${RELEASE}"

    yum --disablerepo '*' --enablerepo extras swap centos-linux-repos centos-stream-repos
    yum clean all
    yum makecache

    if [[ "${PT_allow_erasing}" == true ]]; then
      yum distro-sync --allowerasing
    else
      yum distro-sync
    fi

    if [[ "${PT_reboot}" == true ]]; then 
      echo "Scheduling system restart in 1 minute..."
      shutdown -r +1
    fi

  else 
    echo "System is not CentOS Version 8.5.2111, please update prior to migration."
  fi

fi 

