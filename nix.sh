set -e
help_message="$0 <create-vm|(export|build) :package_name|(import|install) :ip :package_name|start :ip :package_name [--:arg-name :arg-value]+>"
#----------------------------------------
# systemctl stop firewall
# install -d -m755 -o ${my_user} /nix
# ssh-copy-id $ssh_opt ${my_user}@${remote_ip}
#---------------------------------------

my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P); cd $my
my_rhome=${my_rhome:-my-env}

mkdir -p nix.sh.out

if [ ! -e nix.sh.out/key ]; then
  echo "--> ssh-keygen to nix.sh.out/key"
  ssh-keygen -t ed25519 -f nix.sh.out/key -N '' -C "my-env auto-generated key"
fi

if which nix-channel 2> /dev/null && [ "$(nix-channel --list | grep nixos-19.03 > /dev/null)" = "" ] ; then
    echo "--> adjust nixpkgs to nixpkgs-unstable, nix-channel --update..."  
    nix-channel --add https://nixos.org/channels/nixos-19.03 nixpkgs
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
  if [ "$protocol_name" == "nix" ] ;then
    nix-env -f '<nixpkgs>' -iA ${package_name}
    download_url=$(nix-build '<nixpkgs>' -A ${package_name} --no-out-link)
    my_package_name=$(basename $download_url | cut -d- -f2-)
    echo "----> [info] export my_package_name: ${my_package_name}"
    if [ ! -e nix.sh.out/nix.${my_package_name} ]; then
      nix-store --export $(nix-store -qR $download_url) | gzip > nix.sh.out/nix.${my_package_name}.tmp
      mv nix.sh.out/nix.${my_package_name}.tmp nix.sh.out/nix.${my_package_name}
    else
      echo "----> [warn] ${full_package_name} exist already!"
    fi
  elif [ "$protocol_name" == "tgz" ]; then
    if [  -e $my/nix.sh.out/${full_package_name} ]; then
      echo "---->[info] ${full_package_name} exist already!"
      exit -1
    fi
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
    # [TODO]: BUILD GENERAL BUILD INSTRUCTION
    # -- nix-build -f ${my}/nix.conf/${package_name} -A ${package_name}
    package_path=$(nix-env -f '<nixpkgs>' -q --out-path ${package_name} | awk  '{print $2}')
    echo "-- EXPORTING  $package_name: =<< $package_path ... "
    nix-store --export $(nix-store -qR $package_path) | gzip > nix.sh.out/${full_package_name}.tmp
    mv nix.sh.out/${full_package_name}.tmp nix.sh.out/${full_package_name}
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
elif [ "$1" == "import" -o "$1" == "install" ]; then
  action=$1
  remote_info=$2
  remote_user=$(echo $remote_info | cut -d@ -f1)
  full_package_name=$3
  protocol_name=$(echo $full_package_name | cut -d. -f1)
  package_name=$(echo $full_package_name | cut -d. -f2-)
  if [ "${package_name}" = "" ]; then
    echo "${help_message}"
    echo "[error]: package_name is missing"
    exit 1
  fi
  echo "[action] import ${remote_info} ${full_package_name}"
  echo "--> rsync/scp ${full_package_name}..."
  remote_rsync_exist=$(ssh $ssh_opt $remote_info "if which rsync 2> /dev/null; then echo 1; else echo 0; fi")
  if [ "$remote_rsync_exist" = "1" ]; then
    rsync -e "ssh ${ssh_opt}" -av ${my}/{nix.sh,nix.sh.dic} ${remote_info}:${my_rhome}/
    rsync -e "ssh ${ssh_opt}" -av ${my}/nix.sh.out/${full_package_name} ${remote_info}:${my_rhome}/nix.sh.out/
  else 
    echo "--> [warn] switch to scp mode as the rsync command is missing..."
    ssh ${ssh_opt} ${remote_info} "mkdir -p ${my_rhome}/nix.sh.out"
    scp ${ssh_opt} ${my}/{nix.sh,nix.sh.dic} ${remote_info}:${my_rhome}/
    scp ${ssh_opt} ${my}/nix.sh.out/${full_package_name} ${remote_info}:${my_rhome}/nix.sh.out/${full_package_name}
  fi
  my_full_rhome=$(ssh ${ssh_opt} ${remote_info} "readlink -f $my_rhome")
  echo "my_full_rhome: $my_full_rhome"
  
  if [ $protocol_name = "nix" ]; then
    echo "--> check whether remote package exist..."
    package_exist=$(ssh $ssh_opt ${remote_info} "
      if compgen -g '/nix/store/*-${package_name}' > /dev/null; then echo 1; else echo 0; fi
    ")
    if [ "$package_exist" = "1" ]; then 
      echo "---->[${remote_info}-info] ${package_name} imported already"
    else
      echo "--> import ${remote_info}/${package_name} need to cost a little time, please be patient..."
      echo "cat ${my_full_rhome}/nix.sh.out/${full_package_name} | gunzip | nix-store --import"
      ssh ${ssh_opt} "${remote_info}" "set -e; 
        if which nix-store 2> /dev/null; then
          nix_store_cmd=nix-store
	  nix_env_cmd=nix-env
        else
          nix_store_cmd=.nix-profile/bin/nix-store
	  nix_env_cmd=.nix-profile/bin/nix-env
        fi
        package_url=\$(cat ${my_full_rhome}/nix.sh.out/${full_package_name} | gunzip | \${nix_store_cmd} --import)
        echo \"package_url: \${package_url}\"
	#if [ '$action' == 'install' ]; then
	#  \${nix_env_cmd} -i \$package_url
	#fi
      "
    fi
  elif [ "$protocol_name" = "tgz" ]; then
    ssh ${ssh_opt} ${remote_info} "set -e
      if [ ${package_name} == 'nix' ]; then
          if [ ! -e /nix ]; then 
            echo "[WARN] /nix not exist, su - root to create!"
            su - root -c 'install -d -m755 -o ${remote_user} /nix'
	  fi
          if [ -e /nix/store ]; then 
            echo '----> nix install already!' && exit -1
          fi
          rm -rf /tmp/nix-installer && mkdir -p /tmp/nix-installer && cd /tmp/nix-installer
          tar -xvf $my_full_rhome/nix.sh.out/tgz.nix
          cd /tmp/nix-installer/nix-*
          sed 's/^.*nix-channel --update/echo #**NO-CHANNEL-UPDATE**/g' install > _install
          chmod +x ./_install && ./_install
          cd ~ && rm -rf /tmp/nix-installer
      else
        my_full_rhome=\$(readlink -f $my_rhome) && cd \$my_full_rhome
        if [ ! -e '${my_rhome}/nix.var/data/${package_name}/_tarball' ]; then
          echo '--> unzip tarball to ${my_rhome}/nix.var/data/${package_name}...'
          rm -rf nix.var/data/${package_name}
          mkdir -p nix.var/data/${package_name}
          cd nix.var/data/${package_name} && tar -xvf \$my_full_rhome/nix.sh.out/${full_package_name} && cd \$my_full_rhome
          touch nix.var/data/${package_name}/_tarball
        else
          echo '---->[${remote_info}-info] ${package_name} imported already'
        fi
      fi
    "
  else echo "--> [error] only nix|tgz protocol support" && exit 1
  fi
elif [ "$1" == "reload" -o "$1" == "start" -o "$1" == "start-foreground" ]; then
  action=$1; remote_info_port=$2; package_name=$(echo $3 | cut -d: -f1)
  echo "[action] $action $remote_info ${package_name}"
  remote_info=$(echo $remote_info_port | cut -d: -f1)
  remote_host_port=$(echo $remote_info_port | cut -d@ -f2)
  if [ "${package_name}" = "" ]; then
    echo "${help_message}"
    echo "[error]: package_name is missing"
    exit 1
  fi

  echo "#=> sync conf file: $my/nix.conf/${package_name}"
  remote_rsync_exist=$(ssh $ssh_opt ${remote_info} "if which rsync 2> /dev/null; then echo 1; else echo 0; fi")
  if [ "$remote_rsync_exist" = "1" ]; then
    rsync -e "ssh ${ssh_opt}" -av ${my}/nix.conf/${package_name} ${remote_info}:${my_rhome}/nix.conf/
  else
    ssh ${ssh_opt} ${remote_info} "mkdir -p ${my_rhome}/nix.conf"
    scp -r ${ssh_opt} ${my}/nix.conf/${package_name} ${remote_info}:${my_rhome}/nix.conf
  fi
  shift && shift
  ssh ${ssh_opt} ${remote_info} -t "sh ${my_rhome}/nix.conf/${package_name}/run.sh $action $remote_host_port $@"
else
  echo ${help_message}
fi
