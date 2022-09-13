#!/bin/sh

# Check to make sure we are actually on a CentOS 8.5.2111 host
if [ -f /etc/redhat-release ]; then 

  RELEASE=`head -1 /etc/redhat-release`
  if [[ "${RELEASE}" == "CentOS Linux release 8.5.2111" ]]; then
    echo "Release: ${RELEASE}"

    if [[ "${PT_stop_puppet}" == true ]]; then 
        systemctl stop puppet
    fi


    cd /root
    curl -O https://raw.githubusercontent.com/EuroLinux/eurolinux-migration-scripts/master/migrate2eurolinux.sh
    curl -O https://raw.githubusercontent.com/EuroLinux/eurolinux-migration-scripts/master/remove_kernels.sh
    
    bash migrate2eurolinux.sh -f

    dnf distro-sync -y 

    if [[ "${PT_reboot}" == true ]]; then 
      echo "Scheduling system restart in 1 minute..."
      shutdown -r +1
    fi

  else 
    echo "System is not CentOS Version 8.5.2111, please update prior to migration."
  fi

fi 

