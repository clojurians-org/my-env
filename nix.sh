set -e
help_message="$0 <create-vm|export :package_name|create-user :ip|(import|install) :ip :package_name|start :ip :package_name [--:arg-name :arg-value]+>"

my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P); cd $my
my_rhome=${my_rhome:-my-env}
my_user=${my_user:-op}

mkdir -p nix.sh.out nix.sh.build


nix_name=nix-2.0.4
nix_sys=${nix_name}-x86_64-linux
nix_tar=${nix_sys}.tar.bz2

if [ ! -e nix.sh.out/key ]; then
  echo "--> ssh-keygen to nix.sh.out/key"
  ssh-keygen -t ed25519 -f nix.sh.out/key -N '' -C "my-env auto-generated key"
fi
if nix-channel --list | grep nixos-unstable > /dev/null ; then
  : 
else
  echo "--> add <nixos-unstable> to nix-channel, nix-channel --update..."
  nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
  nix-channel --update
fi
ssh_opt="-i nix.sh.out/key"

if [ "$1" == "create-vm" ]; then
  vm_name=$2
  echo "[action] createvm ${vm_name}"
  if [ ! -e nix.sh.out/virtualbox-nixops-18.03pre131587.b6ddb9913f2.vmdk ]; then
    vbox_url=http://nixos.org/releases/nixos/virtualbox-nixops-images/virtualbox-nixops-18.03pre131587.b6ddb9913f2.vmdk.xz
    echo "--> download ${vbox_url}"
    wget -c -O nix.sh.out/virtualbox-nixops-18.03pre131587.b6ddb9913f2.vmdk.xz.tmp ${vbox_url}
    mv nix.sh.out/virtualbox-nixops-18.03pre131587.b6ddb9913f2.vmdk.xz.tmp nix.sh.out/virtualbox-nixops-18.03pre131587.b6ddb9913f2.vmdk.xz
    unxz nix.sh.out/virtualbox-nixops-18.03pre131587.b6ddb9913f2.vmdk.xz
  fi
  if VBoxManage list vms | grep "${vm_name}" > /dev/null 2>&1; then
    echo "----> vm ${vm_name} exist already!"
  else
    VBoxManage createvm --name "${vm_name}" --ostype Linux26_64 --register
    VBoxManage guestproperty set "${vm_name}" /VirtualBox/GuestInfo/Charon/ClientPublicKey "$(cat nix.sh.out/key.pub)"
    VBoxManage guestproperty set "${vm_name}" /VirtualBox/GuestInfo/NixOps/PrivateHostEd25519Key "$(cat nix.sh.out/key)"
    VBoxManage storagectl "${vm_name}" --name SATA --add sata --portcount 8 --bootable on --hostiocache on
    VBoxManage clonehd nix.sh.out/virtualbox-nixops-18.03pre131587.b6ddb9913f2.vmdk ~/"VirtualBox VMs"/"${vm_name}"/disk1.vdi --format VDI
    VBoxManage storageattach "${vm_name}" --storagectl SATA --port 0 --device 0 --type hdd --medium ~/"VirtualBox VMs"/"${vm_name}"/disk1.vdi
    VBoxManage modifyvm "${vm_name}" --memory 4096 --cpus 2 --vram 10 --nictype1 virtio --nictype2 virtio --nic2 hostonly --hostonlyadapter2 vboxnet0 --nestedpaging off --paravirtprovider kvm
    VBoxManage guestproperty enumerate "${vm_name}"
    VBoxManage startvm "${vm_name}" --type headless
  fi
  echo "--> wait ip to be generated, by patient..."
  ip="No value set!"
  while [ "$ip" = "No value set!" ]; do
    sleep 1
    ip=$(VBoxManage guestproperty get ${vm_name} /VirtualBox/GuestInfo/Net/1/V4/IP)
  done
  echo "---> VM CREATED SUCCESS WITH IP: ${ip}"
elif [ "$1" == "export" ]; then
  full_package_name=$2
  protocol_name=$(echo $full_package_name | cut -d. -f1)
  package_name=$(echo $full_package_name | cut -d. -f2-)
  if [ "${package_name}" = "" ]; then
    echo "${help_message}"
    echo "[error]: package_name is missing"
    exit 1
  fi
  echo "[action] export ${full_package_name}..."
  if [  -e $my/nix.sh.out/${full_package_name} ]; then
    echo "---->[info] ${full_package_name} exist already!"
  elif [ "$protocol_name" == "nix" ] ;then
    download_url=$(grep "^${full_package_name}=" nix.sh.dic | cut -d= -f2)
    if [ ! -e "$download_url" ]; then 
      echo "--> nix-env -i ${package_name}"
      nix-env -i ${package_name}
    fi
    if [ -e "$download_url" ];  then
      nix-store --export $(nix-store -qR $download_url) | gzip > nix.sh.out/${full_package_name}.tmp
      mv nix.sh.out/${full_package_name}.tmp nix.sh.out/${full_package_name}
    else echo "--> [ERROR] ${full_package_name} HASH VALUE NOT MATCHED, PLEASE CHECK AND REEXPORT !" && exit 1
    fi
  elif [ "$protocol_name" == "tgz" ]; then
    download_url=$(grep "^${full_package_name}=" nix.sh.dic | cut -d= -f2)
    if [ "$download_url" == "" ]; then echo "----> [ERROR] DOWLOAD URL NOT EXIST!"; exit 1; fi
    echo "--> download ${full_package_name} from ${download_url}"
    wget -c -O nix.sh.out/${full_package_name}.tmp ${download_url}
    if echo "$download_url" | grep 'bz2$' > /dev/null ; then
      bunzip2 -c < nix.sh.out/${full_package_name}.tmp | gzip -c > nix.sh.out/${full_package_name}
      rm -rf nix.sh.out/${full_package_name}.tmp
    else
      mv nix.sh.out/${full_package_name}.tmp nix.sh.out/${full_package_name}
    fi
  else echo "format error: only nix|tgz protocol support" && exit 1
  fi
elif [ "$1" == "build" ]; then
  full_package_name=$2
  if [ -e "nix.sh.out/${package_name}/${full_package_name}" ]; then
      echo "package[${full_package_name}] exist already" && exit 0
  fi
  protocol_name=$(echo $full_package_name | cut -d. -f1)
  package_name=$(echo $full_package_name | cut -d. -f2-)
  if [ $protocol_name = "nix" ]; then
    download_url=$(grep "^src.${package_name}=" nix.sh.dic | cut -d= -f2)
    if [ ! -e "$download_url" ]; then
      echo "--> [info] building ./nix.conf/${package_name}/default.nix ..."
      nix-build -E "with import <nixos-unstable> {}; callPackage ./nix.conf/${package_name}/default.nix {}"
    fi
    if [ -e "$download_url" ];  then
      nix-store --export $(nix-store -qR $download_url) | gzip > nix.sh.out/${full_package_name}.tmp
      mv nix.sh.out/${full_package_name}.tmp nix.sh.out/${full_package_name}
    else echo "--> [ERROR] ${full_package_name} HASH VALUE NOT MATCHED, PLEASE CHECK AND REBUILD!" && exit 1
    fi
  elif [ $protocol_name = "tgz" ]; then
    if grep "^src.${package_name}=" nix.sh.dic 2> /dev/null; then
      echo "--> [info] build source tarball"
      download_url=$(grep "^src.${package_name}=" nix.sh.dic | cut -d= -f2)
      echo "--> download ${package_name} from ${download_url}"
      mkdir -p nix.sh.build/${package_name}
      if [ ! -e nix.sh.build/${package_name}/src.${package_name}.tgz ]; then
        wget -c -O nix.sh.build/${package_name}/src.${package_name}.tgz.tmp ${download_url}
        mv nix.sh.build/${package_name}/src.${package_name}.tgz.tmp nix.sh.build/${package_name}/src.${package_name}.tgz
      fi
      rm -rf nix.sh.build/${package_name}/${package_name}.build
      mkdir -p nix.sh.build/${package_name}/${package_name}.build

      cd nix.sh.build/${package_name}/${package_name}.build 
      tar -xvf ../src.${package_name}.tgz && cd * && bash ${my}/nix.conf/${package_name}/build.sh
      mv ${package_name}.tgz ${my}/nix.sh.out/${package_name}/tgz.${package_name}
      cd .. && rm -rf ${package_name}.build
    fi
  else echo "--> [error] only nix|tgz protocol support" && exit 1
  fi
elif [ "$1" == "create-user" ]; then
  remote_ip=$2
  echo "[action] init $remote_ip"
  ssh $ssh_opt root@$remote_ip "
    set -e ;
    if [ ! -e ~${my_user} ]; then
      if uname -a | grep NixOS > /dev/null; then
	echo '--> adjust nixos for normal case'
        systemctl stop firewall
	if [ ! -e /bin/bash ]; then ln -s /run/current-system/sw/bin/bash /bin/bash; fi
	if [ ! -e /bin/echo ]; then ln -s /run/current-system/sw/bin/echo /bin/echo; fi
	rm -rf /nix/var/nix/profiles/per-user/${my_user}
	rm -rf /nix/var/nix/gcroots/per-user/${my_user}
        chmod 777 /nix/var/nix/profiles/per-user
        chmod 777 /nix/var/nix/gcroots/per-user
	hostname ${remote_ip}
      fi
      useradd -m ${my_user}
      echo '${my_user}:${my_user}' | chpasswd
    else
      echo '---->[${remote_ip}-info] user:${my_user} exist already!'
    fi
    if [ ! -e /nix ]; then install -d -m755 -o ${my_user} /nix; fi
  "
  echo "ssh-copy-id $ssh_opt ${my_user}@${remote_ip}"
  ssh-copy-id $ssh_opt ${my_user}@${remote_ip}
elif [ "$1" == "import" -o "$1" == "install" ]; then
  action=$1
  remote_ip=$2
  full_package_name=$3
  protocol_name=$(echo $full_package_name | cut -d. -f1)
  package_name=$(echo $full_package_name | cut -d. -f2-)
  if [ "${package_name}" = "" ]; then
    echo "${help_message}"
    echo "[error]: package_name is missing"
    exit 1
  fi
  echo "[action] import ${remote_ip} ${full_package_name}"
  echo "--> rsync/scp ${full_package_name}..."
  remote_rsync_exist=$(ssh $ssh_opt ${my_user}@${remote_ip} "if which rsync 2> /dev/null; then echo 1; else echo 0; fi")
  if [ "$remote_rsync_exist" = "1" ]; then
    rsync -e "ssh ${ssh_opt}" -av ${my}/{nix.sh,nix.sh.dic} ${my_user}@${remote_ip}:${my_rhome}/
    rsync -e "ssh ${ssh_opt}" -av ${my}/nix.sh.out/${full_package_name} ${my_user}@${remote_ip}:${my_rhome}/nix.sh.out/
  else 
    echo "--> [warn] switch to scp mode as the rsync command is missing..."
    ssh ${ssh_opt} ${my_user}@${remote_ip} "mkdir -p ${my_rhome}/nix.sh.out"
    scp ${ssh_opt} ${my}/{nix.sh,nix.sh.dic} ${my_user}@${remote_ip}:${my_rhome}/
    scp ${ssh_opt} ${my}/nix.sh.out/${full_package_name} ${my_user}@${remote_ip}:${my_rhome}/nix.sh.out/${full_package_name}
  fi
  my_full_rhome=$(ssh ${ssh_opt} ${my_user}@${remote_ip} "readlink -f $my_rhome")
  echo "my_full_rhome: $my_full_rhome"
  
  if [ $protocol_name = "nix" ]; then
    echo "--> check whether remote package exist..."
    package_exist=$(ssh $ssh_opt ${my_user}@${remote_ip} "
      if compgen -g '/nix/store/*-${package_name}' > /dev/null; then echo 1; else echo 0; fi
    ")
    if [ "$package_exist" = "1" ]; then 
      echo "---->[${remote_ip}-info] ${package_name} imported already"
    else
      nix_user=$(ssh $ssh_opt ${my_user}@${remote_ip} "stat -c %U /nix")
      echo "--> import ${package_name}@${nix_user} need to cost a little time, please be patient..."
      echo "cat ${my_full_rhome}/nix.sh.out/${full_package_name} | gunzip | nix-store --import"
      ssh ${ssh_opt} ${nix_user}@${remote_ip} "
        download_url=\$(grep -E '^(nix|src).${package_name}=' ${my_full_rhome}/nix.sh.dic | cut -d= -f2)
	echo \"--> download_url: \${download_url}\"
        if which nix-store 2> /dev/null; then
          nix_store_cmd=nix-store
	  nix_env_cmd=nix-env
        else
          nix_store_cmd=.nix-profile/bin/nix-store
	  nix_env_cmd=.nix-profile/bin/nix-env
        fi
        cat ${my_full_rhome}/nix.sh.out/${full_package_name} | gunzip | \${nix_store_cmd} --import
	if [ '$action' == 'install' ]; then
          if [ \"\$download_url\" == '' ]; then echo '----> [error] dowload url not exist!'; exit 1; fi
	  \${nix_env_cmd} -i \$download_url
	fi
      "
    fi
  elif [ "$protocol_name" = "tgz" ]; then
    ssh ${ssh_opt} ${my_user}@${remote_ip} "set -e
      my_full_rhome=\$(readlink -f $my_rhome) && cd \$my_full_rhome
      if [ ! -e '${my_rhome}/nix.var/data/${package_name}/_tarball' ]; then
        echo '--> unzip tarball to ${my_rhome}/nix.var/data/${package_name}...'
        rm -rf nix.var/data/${package_name}
        mkdir -p nix.var/data/${package_name}
	cd nix.var/data/${package_name} && tar -xvf \$my_full_rhome/nix.sh.out/${full_package_name} && cd \$my_full_rhome
        touch nix.var/data/${package_name}/_tarball
      else
        echo '---->[${remote_ip}-info] ${package_name} imported already'
      fi
      if [ '$action' == 'install' ]; then
        if [ ! -e '${my_rhome}/nix.var/data/${package_name}/_install' ]; then
          cd nix.var/data/${package_name}/nix*
          sed '/nix-channel --update/ {s/^/  echo/}' install > _install

          if [ ! -e /nix ]; then 
	    echo "[WARN] /nix not exist, su - root to create!"
            su - root -c 'install -d -m755 -o ${my_user} /nix'
	  fi
          if [ -e /nix/store ]; then 
            echo '----> nix install already!'
          else
            chmod +x ./_install && ./_install
          fi
	fi
      fi
    "
  else echo "--> [error] only nix|tgz protocol support" && exit 1
  fi
elif [ "$1" == "reload" -o "$1" == "start" -o "$1" == "start-foreground" ]; then
  action=$1; remote_host=$2; package_name=$(echo $3 | cut -d: -f1)
  echo "[action] $action $remote_ip ${package_name}"
  remote_ip=$(echo $remote_host | cut -d: -f1)
  if [ "${package_name}" = "" ]; then
    echo "${help_message}"
    echo "[error]: package_name is missing"
    exit 1
  fi

  echo "#=> sync conf file: $my/nix.conf/${package_name}"
  remote_rsync_exist=$(ssh $ssh_opt ${my_user}@${remote_ip} "if which rsync 2> /dev/null; then echo 1; else echo 0; fi")
  if [ "$remote_rsync_exist" = "1" ]; then
    rsync -e "ssh ${ssh_opt}" -av ${my}/nix.conf/${package_name} ${my_user}@${remote_ip}:${my_rhome}/nix.conf/
  else
    ssh ${ssh_opt} ${my_user}@${remote_ip} "mkdir -p ${my_rhome}/nix.conf"
    scp -r ${ssh_opt} ${my}/nix.conf/${package_name} ${my_user}@${remote_ip}:${my_rhome}/nix.conf
  fi
  ssh ${ssh_opt} ${my_user}@${remote_ip} -t "sh ${my_rhome}/nix.conf/${package_name}/run.sh $@"
elif [ "$1" == "clean" ]; then
  remote_host=$2
  ssh root@${remote_host} "
    rm -rf /nix
    rm -rf ${my_rhome}
  "
else
  echo ${help_message}
fi

