#!/bin/sh

# Check to make sure we are actually on a CentOS 8.5.2111 host
if [ -f /etc/redhat-release ]; then 

  RELEASE=`head -1 /etc/redhat-release`
  if [[ "${RELEASE}" == "CentOS Linux release 8.5.2111" ]]; then
    echo "Release: ${RELEASE}"

    # From https://github.com/rocky-linux/rocky-tools/tree/main/migrate2rocky
    yum install -y git-core
    cd /root
    git clone https://github.com/rocky-linux/rocky-tools.git
    if [ -f /root/rocky-tools/migrate2rocky/migrate2rocky.sh ]; then
      cd /root/rocky-tools/migrate2rocky

      chmod u+x migrate2rocky.sh
      ./migrate2rocky.sh -r

      # Dump the log into standard out
      cat /var/log/migrate2rocky.log

      if [[ "${PT_reboot}" == true ]]; then 
        echo "Scheduling system restart in 1 minute..."
        shutdown -r +1
      fi
    fi

  else 
    echo "System is not CentOS Version 8.5.2111, please update prior to migration."
  fi

fi 

