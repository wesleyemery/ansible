#!/bin/bash 

DATE=`date +%m-%d-%y`

if [ -f /etc/redhat-release ]; then
  #Adding Nitro drivers. Dracut is loaded during the installation phase of dracut. 
  sudo echo 'add_drivers+=" ena nvme xen-netfront xen-blkfront' >> /etc/dracut.conf
  
  #Analyze kernel modules and create list dependencies 
  sudo depmod -a 
  
  #Creates an initial image for kernel preloading
  sudo dracut -v -f
  
  #Update GRUB menu
  sudo cp /etc/default/grub /etc/default/grub.{$DATE}
  sudo sed -i '/^GRUB\_CMDLINE\_LINUX/s/\"$/\ net\.ifnames\=0\"/' /etc/default/grub
fi 
