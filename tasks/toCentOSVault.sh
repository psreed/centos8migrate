$PT_run_yum=true
$PT_reboot=true

echo "Run Yum: ${PT_run_yum}"
echo "Reboot: ${PT_reboot}"

# sudo sed -i -e "s|mirrorlist=|#mirrorlist=|g" -e "s|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g" /etc/yum.repos.d/CentOS-Linux-*