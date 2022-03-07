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

    # Following RHEL Conversion process as described: 
    # https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/converting_from_an_rpm-based_linux_distribution_to_rhel/index?extIdCarryOver=true&sc_cid=701f2000001OH6fAAG

    # Additional Info: https://access.redhat.com/articles/2360841
    
    curl -o /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-release https://www.redhat.com/security/data/fd431d51.txt

    curl --create-dirs -o /etc/rhsm/ca/redhat-uep.pem https://ftp.redhat.com/redhat/convert2rhel/redhat-uep.pem

    curl -o /etc/yum.repos.d/convert2rhel.repo https://ftp.redhat.com/redhat/convert2rhel/8/convert2rhel.repo

    yum -y install convert2rhel

    convert2rhel -y --username $PT_rhn_user --password $PT_rhn_pass --pool $PT_rhn_pool_id--debug


    if [[ "${PT_reboot}" == true ]]; then 
      echo "Scheduling system restart in 1 minute..."
      shutdown -r +1
    fi

  else 
    echo "System is not CentOS Version 8.5.2111, please update prior to migration."
  fi

fi 

