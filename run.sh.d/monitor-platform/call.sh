my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/..

export KAFKA_ALL="10.132.37.33:9092,10.132.37.34:9092,10.132.37.35:9092"
# export JAVA_HOME=my-env/nix.var/data/oraclejre-8u181b13/jre1.8.0_181
#========
# CLIENT
#========
export my_user=bohrview
bash nix.sh import-tarball 10.129.34.250 oraclejre-8u181b13
bash nix.sh import-tarball 10.129.34.250 logstash-6.2.4
bash nix.sh start 10.129.34.250:logi_cores_pts logstash-6.2.4 --kafkas $KAFKA_ALL --multiline true --paths "/app/bohr/logs/Pts2/cbsd.log,/app/bohr/logs/Pts2/ccfc.log,/app/bohr/logs/Pts2/gateway.log,/app/bohr/logs/Pts2/send.log,/app/bohr/logs/Pts2/INDEX.tmp"
bash nix.sh start 10.129.34.250:logi_cores_pts-encrypt logstash-6.2.4 --kafkas $KAFKA_ALL --multiline false --paths "/app/bohr/logs/Pts2/COMPRESS.tmp"

bash nix.sh import-tarball 10.132.33.43 oraclejre-8u181b13
bash nix.sh import-tarball 10.132.33.43 logstash-6.2.4

## -- logi_pimp_protal
#echo -e "\n==== sh nix.sh start X@X.X.X.X logstash-6.2.4 --bootstrap-server ${KAFKA_ALL} --db log --id logi_pimp_protal" &&  
#	        sh nix.sh start X@X.X.X.X logstash-6.2.4 --bootstrap-server ${KAFKA_ALL} --db log --id logi_pimp_protal --path "
#path_cores_pts__COMPRESS=path_cores_pts__COMPRESS=path_cores_pts__COMPRESS=                "
#
## -- es
#echo -e "\n==== sh nix.sh start 10.132.37.36 logstash-6.2.4 --bootstrap-server ${KAFKA_ALL} --db log"
#	        sh nix.sh start 10.132.37.36 logstash-6.2.4 --bootstrap-server ${KAFKA_ALL} --db log 
