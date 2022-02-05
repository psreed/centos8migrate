#!/bin/sh

echo "Run yum update: ${PT_run_yum}"
echo "Reboot afterward: ${PT_reboot}"

# Check to make sure we are actually on a CentOS 8 host
RELEASE_NAME=`grep "^NAME=" /etc/*release* | sed "s/\"//g"`
RELEASE_VERSION=`grep "^VERSION=" /etc/*release* | sed "s/\"//g"`
RELEASE="${RELEASE_NAME##*=} ${RELEASE_VERSION##*=}"

if [[ "${RELEASE}" == *"CentOS Linux"* && "${RELEASE}" == *"8"* ]]; then 
  echo "Release: ${RELEASE}"
  echo "Updating Repos..."

  sudo sed -i -e "s|mirrorlist=|#mirrorlist=|g" -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-Linux-*

  if [[ "${PT_run_yum}" == true ]]; then 
      echo "Running Yum Update..."
      yum update -y
  fi

  if [[ "${PT_reboot}" == true ]]; then 
      echo "Rebooting..."
      shutdown -r now
  fi
fi

