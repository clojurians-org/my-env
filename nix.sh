set -e
help_message="$0 <download|mkdir :ip|export :nix_package|import :ip :nix_package|start :ip :nix_package [--:arg-name arg-value]+>"

my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
mkdir -p $my/{nix.sh.d,nix.sh.out}

nix_name=nix-2.0.4
nix_sys=${nix_name}-x86_64-linux
nix_tar=${nix_sys}.tar.bz2

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
  if [ ! -e nix.sh.out/key ]; then
    echo "--> ssh-keygen to nix.sh.out/key"
    ssh-keygen -t ed25519 -f nix.sh.out/key -N '' -C "my-env auto-generated key"
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
  nix_package=$2
  if [ "${nix_package}" = "" ]; then
    echo "${help_message}"
    echo "[error]: nix_package is missing"
    exit 1
  fi
  echo "[action] export ${nix_package}..."
  if [ -e $my/nix.sh.out/${nix_package}.closure.bz2 ]; then
    echo "---->[info] ${nix_package} exist already!"
  else
    if [ "$(shopt -s nullglob; echo /nix/store/*-${nix_package})" == "" ]; then 
      echo "--> nix-env -i ${nix_package}"
      nix-env -i ${nix_package}
    fi
    nix-store --export $(nix-store -qR /nix/store/*-${nix_package}) | bzip2 > nix.sh.out/${nix_package}.closure.bz2
  fi
elif [ "$1" == "init" ]; then
  remote_ip=$2
  echo "[action] init $remote_ip"
  ssh -i nix.sh.out/key root@$remote_ip "
    if [ ! -e /home/op ]; then
      useradd -m op
      echo 'op:op' | chpasswd
      if [ ! -e /nix ]; then
        install -d -m755 -o op /nix
      else
        chmod 777 /nix/var/nix/profiles/per-user
	ln -s /run/current-system/sw/bin/echo /bin/echo
	systemctl stop firewall
	sysctl -w vm.max_map_count=262144
      fi

    else
      echo '---->[${remote_ip}-info] /nix exist already!'
    fi
  "
elif [ "$1" == "install" ]; then
  remote_ip=$2
  echo "[action] install $remote_ip"
  echo "#=> mkdir my-env directory"
  ssh op@${remote_ip} "mkdir -p my-env/nix.sh.d"
  echo "#=> sync local file"
  rsync -av ${my}/nix.sh.d/ op@${remote_ip}:my-env/nix.sh.d
  echo "#=> install nix"
  ssh op@${remote_ip} "
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
  nix_package=$3
  if [ "${nix_package}" = "" ]; then
    echo "${help_message}"
    echo "[error]: nix_package is missing"
    exit 1
  fi
  echo "[action] import ${remote_ip} ${nix_package}"
  echo "--> check whether remote package exist..."
  package_exist=$(ssh op@${remote_ip} "
    if compgen -G '/nix/store/*${nix_package}' > /dev/null; then echo 1; else echo 0; fi
  ")
  if [ "$package_exist" == "1" ]; then 
    echo "---->[${remote_ip}-info] ${nix_package} imported already"
  else
    echo "--> import ${nix_package} need to cost a little time, please be patient..."
    if [ -e .nix-profile/bin/nix-store ]; then
      nix_store_cmd=.nix-profile/bin/nix-store
      ssh_cmd="ssh op@${remote_ip}"
    elif [ -e /run/current-system/sw/bin/nix-store ]; then
      nix_store_cmd=/run/current-system/sw/bin/nix-store
      ssh_cmd="ssh -i nix.sh.out/key root@${remote_ip}"
    else
      echo " ----> [ERROR] nix-store command not found!"
    fi
    echo "cat nix.sh.out/${nix_package}.closure.bz2 | $ssh_cmd \"bunzip2 | ${nix_store_cmd} -v --import\""
    cat nix.sh.out/${nix_package}.closure.bz2 | $ssh_cmd "bunzip2 | ${nix_store_cmd} --import"
  fi
elif [ "$1" == "import-tarball" ]; then
  remote_ip=$2
  nix_package=$3
  if [ "${nix_package}" = "" ]; then
    echo "${help_message}"
    echo "[error]: nix_package is missing"
    exit 1
  fi
  echo "[action] import-tarball ${remote_ip} ${nix_package}"
  echo "--> mk directory..."
  ssh op@${remote_ip} "mkdir -p my-env/nix.opt/tarball.bin"
  echo "--> sync tarball ..."
  rsync -av ${my}/nix.opt/tarball.bin/${nix_package}/ op@${remote_ip}:my-env/nix.opt/tarball.bin/${nix_package}
  echo "--> unzip tarball to my-env/nix.var/data/${nix_package}..."
  ssh op@${remote_ip} "
    if [ ! -e 'my-env/nix.var/data/${nix_package}/_tarball' ]; then
      mkdir -p my-env/nix.var/data/${nix_package}
      cd my-env/nix.var/data/${nix_package} && tar -xvf ~/my-env/nix.opt/tarball.bin/${nix_package}/*
      touch ~/my-env/nix.opt/tarball.bin/${nix_package}/_tarball
    fi
  "
elif [ "$1" == "start" -o "$1" == "start-foreground" ]; then
  action=$1; remote_host=$2; nix_package=$3
  echo "[action] $action $remote_ip ${nix_package}"
  remote_ip=$(echo $remote_host | cut -d: -f1)
  if [ "${nix_package}" = "" ]; then
    echo "${help_message}"
    echo "[error]: nix_package is missing"
    exit 1
  fi

  echo "#=> mk directory: nix.conf/${nix_package}"
  ssh op@${remote_ip} "mkdir -p my-env/nix.conf/${nix_package}"
  echo "#=> sync conf file: $my/nix.conf/${nix_package}"
  rsync -av ${my}/nix.conf/${nix_package}/ op@${remote_ip}:my-env/nix.conf/${nix_package}
  ssh op@${remote_ip} "sh my-env/nix.conf/${nix_package}/run.sh $@"
elif [ "$1" == "clean" ]; then
  remote_host=$2
  ssh root@${remote_host} "
    rm -rf /nix/*
    rm -rf /home/op/my-env
  "
else
  echo ${help_message}
fi

