#!/bin/bash

live_machines="$(VBoxManage list runningvms)"

#echo $live_machines
if [[ $live_machines =~ .*Centos7_Minimal.* ]]
then
    echo "###### Taking down vm for restoration process ######"
    VBoxManage controlvm Centos7_Minimal poweroff
fi

sleep 3s

echo -e "\n###### Restoring VM to base snapshot ######"
VBoxManage snapshot Centos7_Minimal restore "Base_image"

echo -e "\n###### Starting VM ######"
VBoxManage startvm --type headless Centos7_Minimal

echo -e "\n###### Waiting for the machine to start up SSH process (this may take upto a minute) ######"

ssh -p 2222 viking@127.0.0.1 "echo -e '\n###### SSH is ready ######'"


echo -e "\n###### Uploading packages.txt to the guest machine ######"
scp -P 2222 packages.txt viking@127.0.0.1:/home/viking/download/npm/packages.txt

echo -e "\n###### Downloading packages ######"

ssh -p 2222 viking@127.0.0.1 "python /home/viking/download/npm/download.py /home/viking/download/npm/packages.txt"


echo -e "\n###### Zipping up packages ######"

ssh -p 2222 viking@127.0.0.1 "zip -r npm_packages.zip packages"
#ssh -p 2222 viking@127.0.0.1 "zip -r node_modules.zip node_modules"


if [ ! -d "download"  ]
then
    echo -e "\n###### Creating downloads folder on host machine"
    mkdir download
fi

echo -e "\n###### downloading zip files #######"

scp -P 2222 viking@127.0.0.1:/home/viking/npm_packages.zip download/
#scp -P 2222 viking@127.0.0.1:/home/viking/node_modules.zip download/


echo -e "\n###### Powering down the VM ######"

VBoxManage controlvm Centos7_Minimal poweroff

echo -e "\n###### scanning packages ######"

savscan -f -c -all -dn -archive download/ && clamscan -r download/
