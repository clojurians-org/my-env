```sh

#================
# NixOS
#================
  wpa_passphrase 'hl03863' '@hl03863' > nix.conf/wpa_supplicant-2.6/hl03863.conf
  sudo wpa_supplicant -s -u -Dnl80211,wext -c nix.conf/wpa_supplicant-2.6/Shrbank.conf -iwlp7s0
  sudo wpa_supplicant -s -u -Dnl80211,wext -c nix.conf/wpa_supplicant-2.6/hl03863.conf -iwlp7s0
  sudo wpa_supplicant -s -u -Dnl80211,wext -c nix.conf/wpa_supplicant_YGY5G.conf -iwlp7s0
  
  ss-local -s hk3.wormholex.online -p 13173 -k ewxm9l -m rc4-md5 -b 0.0.0.0 -l 1080 -v
  ss-local -s hk2.wormholex.online -p 13173 -k ewxm9l -m aes-256-cfb  -b 0.0.0.0 -l 1080 -v
  ss-local -s 47.88.155.121 -p 443 -m chacha20  -b 0.0.0.0 -l 1080 -k p123D.alao.+ -v
  
  proxychains4 chromium
  
  # rdkafka
  nix-prefetch-url --unpack --print-path https://github.com/edenhill/librdkafka/archive/v0.9.5.tar.gz
  nix-build -E 'with import <nixpkgs> {}; callPackage nixpkgs/rdkafka/default.nix {}'
  
  #================
  # HYDRA
  #================
  initdb -D opt.var/data/postgresql-10.3/5432
  pg_ctl -D opt.var/data/postgresql-10.3/5432 -l logfile start
  psql -d postgres
  createuser -S -D -R -P hydra
  createdb -O hydra hydra
  
  export HYDRA_DBI="dbi:Pg:dbname=hydra;host=localhost;user=hydra;"
  export HYDRA_DATA=opt.var/data/hydra-2017-11-21/3000
  
  hydra-create-user larluo --full-name 'larry.luo' --email-address 'larluo@clojurians.org' --password larluo --role admin

   hydra-create-user alice --full-name 'hydra' --email-address 'hydra@clojurians.org' --password hydra--role admin

#================
# ELK [docker run --name centos6 -it --net=host centos:6 sh]
#================
  # zookeeper [10.132.37.33:2181,10.132.37.34:2181,10.132.37.35:2181]
  bash nix.sh export zookeeper-3.4.12
  bash nix.sh import 10.132.37.33 zookeeper-3.4.12
  bash nix.sh start-foreground 10.132.37.33:2181 zookeeper-3.4.12 --all "10.132.37.33:2181,10.132.37.34:2181,10.132.37.35:2181"

  echo ruok | nc 10.132.37.33 2181
  zkCli.sh -server "10.132.37.33:2181,10.132.37.34:2181,10.132.37.34:2181"

  # kafka [10.132.37.33:2181,10.132.37.34:2181,10.132.37.35:2181]
  bash nix.sh export apache-kafka-2.12-1.1.0 
  bash nix.sh import 10.132.37.33 apache-kafka-2.12-1.1.0
  bash nix.sh start-foreground 10.132.37.33:9092 apache-kafka-2.12-1.1.0 --zookeepers "10.132.37.33:2181,10.132.37.34:2181,10.132.37.35:2181" --cluster.id monitor

  # elasticsearch [10.132.37.36:9200,10.132.37.37:9200,10.132.37.39:9200,10.132.37.40:9200]
  curl 10.132.37.36:9200/_cluster/health?pretty=true
  
#================
# VirtualBox
#================
  wget http://nixos.org/releases/nixos/virtualbox-nixops-images/virtualbox-nixops-18.03pre131587.b6ddb9913f2.vmdk.xz

  ssh-keygen -t ed25519 -f nix.sh.out/key -N '' -C "my-env auto-generated key"

  VBoxManage createvm --name nixos-elk-001 --ostype Linux26_64 --register
  VBoxManage guestproperty set nixos-elk-001 /VirtualBox/GuestInfo/Charon/ClientPublicKey "$(cat nix.sh.out/key.pub)"
  VBoxManage guestproperty set nixos-elk-001 /VirtualBox/GuestInfo/NixOps/PrivateHostEd25519Key "$(cat nix.sh.out/key)"

  VBoxManage storagectl nixos-elk-001 --name SATA --add sata --portcount 8 --bootable on --hostiocache on 
  VBoxManage clonehd nix.sh.out/virtualbox-nixops-18.03pre131587.b6ddb9913f2.vmdk ~/"VirtualBox VMs"/nixos-elk-001/disk1.vdi --format VDI
  VBoxManage storageattach nixos-elk-001 --storagectl SATA --port 0 --device 0 --type hdd --medium ~/"VirtualBox VMs"/nixos-elk-001/disk1.vdi
  VBoxManage modifyvm nixos-elk-001 --memory 2048 --cpus 2 --vram 10 --nictype1 virtio --nictype2 virtio --nic2 hostonly --hostonlyadapter2 vboxnet0 --nestedpaging off --paravirtprovider kvm
  VBoxManage guestproperty enumerate nixos-elk-001
  VBoxManage startvm nixos-elk-001 --type headless


  VBoxManage guestproperty get nixos-elk-001 /VirtualBox/GuestInfo/Net/1/V4/IP

  VBoxManage controlvm nixos-elk-001 poweroff
  VBoxManage controlvm nixos-elk-001 acpipowerbutton
  VBoxManage unregistervm --delete nixos-elk-001
  
  VBoxManage list runningvms
  VBoxManage list vms
  VBoxManage showvminfo --machinereadable nixos-elk-001
#================
# Java
#================
mvn archetype:generate -DgroupId=my-first -DartifactId=my-first


http://www.jedi.be/blog/2011/11/04/vagrant-virtualbox-hostonly-pxe-vlans/


mkdir -p nix.opt/{tar.src,tar.bin,bin}
```

