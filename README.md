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

#================
# ELK [docker run --name centos6 -it --net=host centos:6 sh]
#================
  sh nix.sh import 10.132.37.33 zookeeper-3.4.12
  sh nix.sh start-foreground 10.132.37.34:2181 zookeeper-3.4.12 --all "10.132.37.33:2181,10.132.37.34:2181,10.132.37.35:2181"
  zkCli.sh -server "10.132.37.33:2181,10.132.37.34:2181,10.132.37.34:2181"
  

#================
# Java
#================
mvn archetype:generate -DgroupId=my-first -DartifactId=my-first

```
