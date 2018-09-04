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
  bash nix.sh export hello-2.10

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

  ssh -i nix.sh.out/key root@192.168.56.101 "userdel -r op"

#================
# KSQL
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

  kafka-topics.sh --zookeeper 10.132.37.33:2181/monitor --topic LOGI_CORES_PTS_EXT_AVRO --delete

  ssh op@10.132.37.34 'ps -ef | grep zookeeper | grep -v grep | awk "{print \$2}" | xargs kill'
  ssh op@10.132.37.33 "/home/op/my-env/nix.var/data/confluent-oss-5.0.0/confluent-5.0.0/bin/ksql-server-stop"

  # kafka connect
  bash nix.sh start 10.132.37.33:8083 confluent-oss-5.0.0:kafka-connect --kafkas "10.132.37.33:9092,10.132.37.34:9092,10.132.37.35:9092" --cluster.id monitor
  ssh op@10.132.37.34 'ps -ef | grep ConnectDistributed | grep -v grep | awk "{print \$2}" | xargs kill'

  # ksql
  bash nix.sh start 10.132.37.33:8088 confluent-oss-5.0.0:ksql --kafkas 10.132.37.33:2181,10.132.37.34:2181,10.132.37.35:2181 --cluster.id monitor
  curl 10.132.37.34:8083
  ssh op@10.132.37.33 "/home/op/my-env/nix.var/data/confluent-oss-5.0.0/confluent-5.0.0/bin/ksql-server-stop"


  ssh op@10.132.37.34 'ps -ef | grep kafka-connect | grep -v grep | awk "{print \$2}" | xargs kill'


#================
# ELK
#================

  # elasticsearch [10.132.37.36:9200,10.132.37.37:9200,10.132.37.39:9200,10.132.37.40:9200]
  curl 10.132.37.36:9200/_cluster/health?pretty=true
  
#================
# VirtualBox
#================
  wget http://nixos.org/releases/nixos/virtualbox-nixops-images/virtualbox-nixops-18.03pre131587.b6ddb9913f2.vmdk.xz

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

kafka-avro-console-producer \
 --property schema.registry.url=http://10.132.37.33:8081 \
 --broker-list 10.132.37.33:9092 --topic orders \
 --property value.schema='{"type":"record","name":"myrecord","fields":[{"name":"id","type":"int"},{"name":"product", "type": "string"}, {"name":"quantity", "type": "int"}, {"name":"price", "type": "float"}]}'


MY_CMD="EXPLAIN \
  SELECT EXTRACTJSONFIELD(EXTRACTJSONFIELD(message, '\$.message'), '\$.appID') AS app_id \
       , EXTRACTJSONFIELD(EXTRACTJSONFIELD(message, '\$.message'), '\$.mobileOS') AS mobile_os \
       , EXTRACTJSONFIELD(EXTRACTJSONFIELD(message, '\$.message'), '\$.mobileOSVersion') AS mobile_os_version \
       , EXTRACTJSONFIELD(EXTRACTJSONFIELD(message, '\$.message'), '\$.model') AS model \
       , EXTRACTJSONFIELD(EXTRACTJSONFIELD(message, '\$.message'), '\$.appVersion') AS app_version \
       , EXTRACTJSONFIELD(EXTRACTJSONFIELD(message, '\$.message'), '\$.crashTime') AS crash_time \
       , EXTRACTJSONFIELD(EXTRACTJSONFIELD(message, '\$.message'), '\$.openID') AS open_id \
       , EXTRACTJSONFIELD(EXTRACTJSONFIELD(message, '\$.message'), '\$.bundleID') AS bundle_id \
       , EXTRACTJSONFIELD(EXTRACTJSONFIELD(message, '\$.message'), '\$.errorStack') AS error_stack \
  FROM logi_hop_sdk_apm WHERE EXTRACTJSONFIELD(message, '\$.logger_name') = 'CrashInfoDev' ; "

curl -XPOST http://10.132.37.33:8088/ksql -H "Content-Type: application/vnd.ksql.v1+json; charset=utf-8" -d "{\"ksql\": \"$MY_CMD\", \"streamsProperties\": {}}" | jq

#================
# POSTGRES-XL
#================
  nix-build -E 'with import <nixpkgs> {}; callPackage ./nix.conf/postgres-xl-10.0/default.nix {}'

/nix/store/*postgres-xl-10.0/bin/psql -p 5432 -c "create node datanode_10_132_37_41_15432 with (type=datanode, host='10.132.37.41', port=15432)" postgres
/nix/store/*postgres-xl-10.0/bin/psql -p 5432 -c "create node datanode_10_132_37_43_15432 with (type=datanode, host='10.132.37.43', port=15432)" postgres
/nix/store/*postgres-xl-10.0/bin/psql -p 5432 -c "create node datanode_10_132_37_44_15432 with (type=datanode, host='10.132.37.44', port=15432)" postgres
/nix/store/*postgres-xl-10.0/bin/psql -p 5432 -c "create node datanode_10_132_37_45_15432 with (type=datanode, host='10.132.37.45', port=15432)" postgres
/nix/store/*postgres-xl-10.0/bin/psql -p 5432 -c "alter node coordinator_10_132_37_41_5432 with (type=coordinator, host='10.132.37.41', port=5432)" postgres
/nix/store/*postgres-xl-10.0/bin/psql -p 5432 -c "create node coordinator_10_132_37_43_5432 with (type=coordinator, host='10.132.37.43', port=5432)" postgres
/nix/store/*postgres-xl-10.0/bin/psql -p 5432 -c "create node coordinator_10_132_37_44_5432 with (type=coordinator, host='10.132.37.44', port=5432)" postgres
/nix/store/*postgres-xl-10.0/bin/psql -p 5432 -c "create node coordinator_10_132_37_45_5432 with (type=coordinator, host='10.132.37.45', port=5432)" postgres

#================
# Java
#================


http://www.jedi.be/blog/2011/11/04/vagrant-virtualbox-hostonly-pxe-vlans/


mkdir -p nix.opt/{tar.src,tar.bin,bin}

#================
# MIGRATE
#================
  bash nix.sh export tgz.nix-2.0.4
  bash nix.sh export nix.rsync-3.1.3
  bash nix.sh export nix.openjdk-8u172b11
  bash nix.sh export nix.leiningen-2.8.1
  bash nix.sh export nix.emacs-25.3

  bash nix.sh create-user 10.132.37.201
  bash nix.sh install 10.132.37.201 nix.rsync-3.1.3
  bash nix.sh install 10.132.37.201 nix.openjdk-8u172b11
  bash nix.sh install 10.132.37.201 tgz.nix-2.0.4
  bash nix.sh install 10.132.37.201 nix.leiningen-2.8.1
  bash nix.sh install 10.132.37.201 nix.emacs-25.3

    CREATE TABLE users \
      (registertime BIGINT, \
       gender VARCHAR, \
       regionid VARCHAR, \
       userid VARCHAR, \
       interests array<VARCHAR>, \
       contactinfo map<VARCHAR, VARCHAR>) \
      WITH (KAFKA_TOPIC='users', \
            VALUE_FORMAT='JSON', \
            KEY = 'userid');

cat my-tmp/data.txt | ~/my-env/nix.var/data/confluent-oss-5.0.0/confluent-5.0.0/bin/kafka-console-producer --broker-list localhost:9092 --topic larluo
CREATE STREAM larluo (_id VARCHAR, dt VARCHAR, type VARCHAR, id VARCHAR, count VARCHAR) WITH (KAFKA_TOPIC='larluo', VALUE_FORMAT='JSON')
cat my-tmp/data.txt | ~/my-env/nix.var/data/confluent-oss-5.0.0/confluent-5.0.0/bin/kafka-console-producer --broker-list localhost:9092 --topic larluo --property "parse.key=true" --property "key.separator=:"


rsync --rsync-path=/home/op/.nix-profile/bin/rsync -av nix.sh.build/hbase-2.1.0/src.hbase-2.1.0.tgz  op@10.132.37.201:my-env/nix.sh.build/hbase-2.1.0/src.hbase-2.1.0.tgz
rsync --rsync-path=/home/op/.nix-profile/bin/rsync -av ~/.m2 op@10.132.37.201:~/.m2
https://hbase.apache.org/book.html#trouble.versions


http://10.132.37.36:9870


#================
# DEPLOY
#================
ssh-copy-id op@10.132.37.230
ssh -i nix.sh.out/key op@10.132.37.230 "mkdir -p my-env"
scp -i nix.sh.out/key -r {nix.conf,nix.sh,nix.sh.dic,nix.sh.out} op@10.132.37.230:my-env
curl 10.132.37.201:8083/connectors/elasticsearch_sink_logi_pimp_protal/status | jq '.tasks[0].trace' | xargs echo -e
```
