set -e
help_message="$0 <download|mkdir :ip|export :package_name|import :ip :package_name|start :ip :package_name [--:arg-name arg-value]+>"

my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P); cd $my
mkdir -p nix.sh.d nix.sh.out nix.opt/tarball.bin

my_user=${my_user:-op}

nix_name=nix-2.0.4
nix_sys=${nix_name}-x86_64-linux
nix_tar=${nix_sys}.tar.bz2

if [ ! -e nix.sh.out/key ]; then
  echo "--> ssh-keygen to nix.sh.out/key"
  ssh-keygen -t ed25519 -f nix.sh.out/key -N '' -C "my-env auto-generated key"
fi
ssh_opt="-i nix.sh.out/key"

if [ "$1" == "createvm" ]; then
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
    exit 1
  else
    VBoxManage createvm --name "${vm_name}" --ostype Linux26_64 --register
    VBoxManage guestproperty set "${vm_name}" /VirtualBox/GuestInfo/Charon/ClientPublicKey "$(cat nix.sh.out/key.pub)"
    VBoxManage guestproperty set "${vm_name}" /VirtualBox/GuestInfo/NixOps/PrivateHostEd25519Key "$(cat nix.sh.out/key)"
    VBoxManage storagectl "${vm_name}" --name SATA --add sata --portcount 8 --bootable on --hostiocache on
    VBoxManage clonehd nix.sh.out/virtualbox-nixops-18.03pre131587.b6ddb9913f2.vmdk ~/"VirtualBox VMs"/"${vm_name}"/disk1.vdi --format VDI
    VBoxManage storageattach "${vm_name}" --storagectl SATA --port 0 --device 0 --type hdd --medium ~/"VirtualBox VMs"/"${vm_name}"/disk1.vdi
    VBoxManage modifyvm "${vm_name}" --memory 3072 --cpus 2 --vram 10 --nictype1 virtio --nictype2 virtio --nic2 hostonly --hostonlyadapter2 vboxnet0 --nestedpaging off --paravirtprovider kvm
    VBoxManage guestproperty enumerate "${vm_name}"
    VBoxManage startvm "${vm_name}" --type headless
  fi
elif [ "$1" == "download" ]; then
  echo "[action] download ${nix_name}"
  if [ ! -e $my/nix.sh.d/${nix_tar} ]; then
    wget -O $my/nix.sh.d/${nix_tar}.tmp https://nixos.org/releases/nix/${nix_name}/${nix_tar}
    mv $my/nix.sh.d/${nix_tar}.tmp $my/nix.sh.d/${nix_tar}
  else
    echo "[info] file exist already!"
  fi
elif [ "$1" == "export" ]; then
  package_name=$2
  if [ "${package_name}" = "" ]; then
    echo "${help_message}"
    echo "[error]: package_name is missing"
    exit 1
  fi
  echo "[action] export ${package_name}..."
  if [ -e $my/nix.sh.out/${package_name}.closure.bz2 ]; then
    echo "---->[info] ${package_name} exist already!"
  else
    if [ "$(shopt -s nullglob; echo /nix/store/*-${package_name})" == "" ]; then 
      echo "--> nix-env -i ${package_name}"
      nix-env -i ${package_name}
    fi
    nix-store --export $(nix-store -qR /nix/store/*-${package_name}) | bzip2 > nix.sh.out/${package_name}.closure.bz2
  fi
elif [ "$1" == "export-tarball" ]; then
  package_name=$2
  if [ "${package_name}" = "" ]; then
    echo "${help_message}"
    echo "[error]: package_name is missing"
    exit 1
  fi
  echo "[action] export-tarball ${package_name}..."
  if [ -e "nix.opt/tarball.bin/${package_name}/${package_name}.tgz" ]; then
    echo "----> [info] ${package_name}.tgz exist!" 
  else
    download_url=$(grep "^${package_name}=" nix.opt.dic | cut -d= -f2)
    if [ "${download_url}" == "" ]; then echo "----> [ERROR] DOWLOAD URL NOT EXIST!"; exit 1; fi
    echo "--> download ${package_name} from ${download_url}"
    mkdir -p nix.opt/tarball.bin/${package_name}
    wget -O nix.opt/tarball.bin/${package_name}/${package_name}.tgz.tmp ${download_url}
    mv nix.opt/tarball.bin/${package_name}/${package_name}.tgz.tmp nix.opt/tarball.bin/${package_name}/${package_name}.tgz
  fi
elif [ "$1" == "init" ]; then
  remote_ip=$2
  echo "[action] init $remote_ip"
  ssh $ssh_opt root@$remote_ip "
    if [ ! -e /home/${my_user} ]; then
      useradd -m ${my_user}
      echo '${my_user}:${my_user}' | chpasswd
      if [ ! -e /nix ]; then
        install -d -m755 -o ${my_user} /nix
      else
        chmod 777 /nix/var/nix/profiles/per-user
	ln -s /run/current-system/sw/bin/echo /bin/echo
	systemctl stop firewall
	sysctl -w vm.max_map_count=262144
      fi
      su root -c 'echo -e "*          soft    nproc     65556\nroot       soft    nproc     unlimited"  > /etc/security/limits.d/90-nproc.conf'
    else
      echo '---->[${remote_ip}-info] /nix exist already!'
    fi
  "
  ssh-copy-id $ssh_opt ${my_user}@${remote_ip}
elif [ "$1" == "install" ]; then
  remote_ip=$2
  echo "[action] install $remote_ip"
  echo "#=> sync local file"
  rsync -e "ssh ${ssh_opt}" -av ${my}/nix.sh.d op@${remote_ip}:my-env
  echo "#=> install nix"
  ssh ${ssh_opt} op@${remote_ip} "
    if [ -e '.nix-defexpr' ]; then
      echo '---->[info] remote_ip:${remote_ip} install nix already!'
    else
      mkdir -p my-env/nix.conf
      mkdir -p my-env/nix.opt/tarball.bin
      cd my-env/nix.sh.d && tar -xvf ${nix_tar} && cd ${nix_sys} && cp ../_install . && ./_install
    fi
  "
elif [ "$1" == "import" ]; then
  remote_ip=$2
  package_name=$3
  if [ "${package_name}" = "" ]; then
    echo "${help_message}"
    echo "[error]: package_name is missing"
    exit 1
  fi
  echo "[action] import ${remote_ip} ${package_name}"
  echo "--> check whether remote package exist..."
  package_exist=$(ssh $ssh_opt ${my_user}@${remote_ip} "
    if compgen -G '/nix/store/*-${package_name}' > /dev/null; then echo 1; else echo 0; fi
  ")
  if [ "$package_exist" == "1" ]; then 
    echo "---->[${remote_ip}-info] ${package_name} imported already"
  else
    echo "--> import ${package_name} need to cost a little time, please be patient..."
    echo "cat nix.sh.out/${package_name}.closure.bz2 | ssh ${ssh_opt} ${my_user}@${remote_ip} \"bunzip2 | .nix-profile/bin/nix-store -v --import\""
    cat nix.sh.out/${package_name}.closure.bz2 | ssh ${ssh_opt} ${my_user}@${remote_ip} "bunzip2 | .nix-profile/bin/nix-store --import"
  fi
elif [ "$1" == "import-tarball" ]; then
  remote_ip=$2
  package_name=$3
  if [ "${package_name}" = "" ]; then
    echo "${help_message}"
    echo "[error]: package_name is missing"
    exit 1
  fi
  echo "[action] import-tarball ${remote_ip} ${package_name}"
  echo "--> mk directory..."
  ssh ${ssh_opt} ${my_user}@${remote_ip} "mkdir -p my-env/nix.opt/tarball.bin"
  echo "--> sync tarball ..."
  rsync -e "ssh ${ssh_opt}" -av ${my}/nix.opt/tarball.bin/${package_name} ${my_user}@${remote_ip}:my-env/nix.opt/tarball.bin
  ssh ${ssh_opt} ${my_user}@${remote_ip} "
    if [ ! -e 'my-env/nix.var/data/${package_name}/_tarball' ]; then
      echo '--> unzip tarball to my-env/nix.var/data/${package_name}...'
      mkdir -p my-env/nix.var/data/${package_name}
      cd my-env/nix.var/data/${package_name} && tar -xvf ~/my-env/nix.opt/tarball.bin/${package_name}/${package_name}.tgz
      touch ~/my-env/nix.var/data/${package_name}/_tarball
    else
      echo '---->[${remote_ip}-info] ${package_name} imported already'
    fi
  "
elif [ "$1" == "reload" -o "$1" == "start" -o "$1" == "start-foreground" ]; then
  action=$1; remote_host=$2; package_name=$3
  echo "[action] $action $remote_ip ${package_name}"
  remote_ip=$(echo $remote_host | cut -d: -f1)
  if [ "${package_name}" = "" ]; then
    echo "${help_message}"
    echo "[error]: package_name is missing"
    exit 1
  fi

  echo "#=> sync conf file: $my/nix.conf/${package_name}"
  rsync -e "ssh ${ssh_opt}" -av ${my}/nix.conf/${package_name} ${my_user}@${remote_ip}:my-env/nix.conf
  ssh ${ssh_opt} ${my_user}@${remote_ip} -t "sh my-env/nix.conf/${package_name}/run.sh $@"
elif [ "$1" == "clean" ]; then
  remote_host=$2
  ssh root@${remote_host} "
    rm -rf /nix/*
    rm -rf /home/op/my-env
  "
else
  echo ${help_message}
fi

