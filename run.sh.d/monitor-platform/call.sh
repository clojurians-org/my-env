my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/..

export KAFKA_ALL="10.132.37.33:9092,10.132.37.34:9092,10.132.37.35:9092"
# export JAVA_HOME=my-env/nix.var/data/oraclejre-8u181b13/jre1.8.0_181
#========
# CLIENT
#========

# core-payment
export my_user=bohrview
ssh-copy-id -i nix.sh.out/key ${my_user}@10.129.34.250
bash nix.sh import-tarball 10.129.34.250 oraclejre-8u181b13
bash nix.sh import-tarball 10.129.34.250 apache-kafka-2.12-1.1.0
bash nix.sh import-tarball 10.129.34.250 logstash-6.2.4

bash nix.sh start 10.129.34.250:logi_cores_pts logstash-6.2.4 --kafkas $KAFKA_ALL --type file:multiline --inputs "/app/bohr/logs/Pts2/cbsd.log,/app/bohr/logs/Pts2/ccfc.log,/app/bohr/logs/Pts2/gateway.log,/app/bohr/logs/Pts2/send.log,/app/bohr/logs/Pts2/INDEX.tmp"
bash nix.sh start 10.129.34.250:logi_cores_pts-encrypt logstash-6.2.4 --kafkas $KAFKA_ALL --type file --inputs "/app/bohr/logs/Pts2/COMPRESS.tmp"

# mobile-bank
export my_user=wasadmin
ssh-copy-id -i nix.sh.out/key ${my_user}@10.128.165.149
bash nix.sh import-tarball 10.128.165.149 oraclejre-8u181b13
bash nix.sh import-tarball 10.128.165.149 apache-kafka-2.12-1.1.0
bash nix.sh import-tarball 10.128.165.149 logstash-6.2.4

bash nix.sh start 10.128.165.149:logi_pimp_protal logstash-6.2.4 --kafkas $KAFKA_ALL --type file --inputs "/was/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/portal-site/SystemOut.log"

# open platform
bash nix.sh import-tarball 10.132.33.43 oraclejre-8u181b13
bash nix.sh import-tarball 10.132.33.43 apache-kafka-2.12-1.1.0
bash nix.sh import-tarball 10.132.33.43 logstash-6.2.4

#========
# SERVER
#========
bash nix.sh start 10.132.37.36:monitor logstash-6.2.4 --kafkas $KAFKA_ALL --type elasticsearch --inputs "logi_cores_pts,logi_pimp_protal"
