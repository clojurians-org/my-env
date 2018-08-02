```sh
#================
# REDHAT
#================
    cat /etc/sysconfig/network-scripts/ifcfg-eth0 
    DEVICE=eth0
    HWADDR=00:0C:29:D6:7C:73
    TYPE=Ethernet
    UUID=065d2da1-8409-48fc-a501-4fdf0ec57da9
    ONBOOT=yes
    NM_CONTROLLED=yes
    BOOTPROTO=static
    IPADDR=10.132.37.32
    NETMASK=255.255.255.0
    GATEWAY=10.132.37.254

    systemctl restart network

#================
# UBUNTU
#================
    cat /etc/network/interfaces
    iface em1 inet static
    address 192.168.1.?
    netmask 255.255.0.0
    gateway 192.168.1.1

    sudo ifdown em1
    sudo ifup em1 

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
  
  # rdkafka
  nix-prefetch-url --unpack --print-path https://github.com/edenhill/librdkafka/archive/v0.9.5.tar.gz
  nix-build -E 'with import <nixpkgs> {}; callPackage nixpkgs/rdkafka/default.nix {}'
  
  #================
  # HYDRA
  #================
  initdb -D nix.var/data/postgresql-10.3/5432
  pg_ctl -D nix.var/data/postgresql-10.3/5432 -l logfile start
  psql -d postgres
  createuser -S -D -R -P hydra
  createdb -O hydra hydra
  
  export HYDRA_DBI="dbi:Pg:dbname=hydra;host=localhost;user=hydra;"
  export HYDRA_DATA=nix.var/data/hydra-2017-11-21/3000

  su root; su hydra
  hydra-create-user larluo --full-name 'larry.luo' --email-address 'larluo@clojurians.org' --password larluo --role admin

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

  VBoxManage guestproperty get nixos-elk-001 /VirtualBox/GuestInfo/Net/1/V4/IP

  VBoxManage controlvm nixos-elk-001 poweroff
  VBoxManage controlvm nixos-elk-001 acpipowerbutton
  VBoxManage unregistervm --delete nixos-elk-001
  
  VBoxManage list runningvms
  VBoxManage list vms
  VBoxManage showvminfo --machinereadable nixos-elk-001

#================
# KSQL
#================
  SET 'auto.offset.reset' = 'earliest';
  SET 'auto.offset.reset' = 'latest' ;

#================
# Java
#================


http://www.jedi.be/blog/2011/11/04/vagrant-virtualbox-hostonly-pxe-vlans/


mkdir -p nix.opt/{tar.src,tar.bin,bin}
```

