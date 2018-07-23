my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my

export ZK_ALL="10.132.37.33:2181,10.132.37.34:2181,10.132.37.34:2181"
# start zookeeper-3.4.12
echo -e "\n==== bash nix.sh start 10.132.37.33:2181 zookeeper-3.4.12 --all ${ZK_ALL}" && bash nix.sh start 10.132.37.33:2181 zookeeper-3.4.12 ${ZK_ALL}
echo -e "\n==== bash nix.sh start 10.132.37.34:2181 zookeeper-3.4.12 --all ${ZK_ALL}" && bash nix.sh start 10.132.37.34:2181 zookeeper-3.4.12 ${ZK_ALL}
echo -e "\n==== bash nix.sh start 10.132.37.35:2181 zookeeper-3.4.12 --all ${ZK_ALL}" && bash nix.sh start 10.132.37.35:2181 zookeeper-3.4.12 ${ZK_ALL}

# start apache-kafka-2.12-1.1.0
export KAFKA_ALL="10.132.37.33:9092,10.132.37.34:9092,10.132.37.35:9092"
echo -e "\n==== bash nix.sh start 10.132.37.33:9092 apache-kafka-2.12-1.1.0 --zookeeper ${ZK_ALL} --cluster.id=monitor" 
                bash nix.sh start 10.132.37.33:9092 apache-kafka-2.12-1.1.0 --zookeeper ${ZK_ALL} --cluster.id=monitor
echo -e "\n==== bash nix.sh start 10.132.37.34:9092 apache-kafka-2.12-1.1.0 --zookeeper ${ZK_ALL} --cluster.id=monitor" 
                bash nix.sh start 10.132.37.34:9092 apache-kafka-2.12-1.1.0 --zookeeper ${ZK_ALL} --cluster.id=monitor
echo -e "\n==== bash nix.sh start 10.132.37.35:9092 apache-kafka-2.12-1.1.0 --zookeeper ${ZK_ALL} --cluster.id=monitor" 
                bash nix.sh start 10.132.37.35:9092 apache-kafka-2.12-1.1.0 --zookeeper ${ZK_ALL} --cluster.id=monitor

# start elasticsearch-6.2.4
export ES_ALL="10.132.37.36:9200,10.132.37.37:9200,10.132.37.39:9200"
echo -e "\n==== bash nix.sh start 10.132.37.36:9200 elasticsearch-6.2.4" && bash nix.sh start 10.132.37.36 elasticsearch-6.2.4
echo -e "\n==== bash nix.sh start 10.132.37.37:9200 elasticsearch-6.2.4" && bash nix.sh start 10.132.37.37 elasticsearch-6.2.4
echo -e "\n==== bash nix.sh start 10.132.37.39:9200 elasticsearch-6.2.4" && bash nix.sh start 10.132.37.39 elasticsearch-6.2.4

# start kibana-6.2.4
echo -e "\n==== bash nix.sh start 10.132.37.36:5601 kibana-6.2.4 -e ${ES_ALL}" && bash nix.sh start 10.132.37.36 kibana-6.2.4 -e ${ES_ALL}

# start logstash-6.2.4
# -- logi_cores_pts
path_cores_pts="/app/bohr/logs/Pts2/cbsd.log,/app/bohr/logs/Pts2/ccfc.log,/app/bohr/logs/Pts2/gateway.log,/app/bohr/logs/Pts2/send.log,/app/bohr/logs/Pts2/INDEX.tmp"
echo -e "\n==== sh nix.sh start bohrview@10.129.34.250 logstash-6.2.4 --bootstrap-server ${KAFKA_ALL} --topic log --id cores_pts --path ${path_cores_pts}" && 
	        sh nix.sh start bohrview@10.129.34.250 logstash-6.2.4 --bootstrap-server ${KAFKA_ALL} --topic log --id cores_pts --path ${path_cores_pts}

# -- logi_cores_pts-COMPRESS
path_cores_pts__COMPRESS="/app/bohr/logs/Pts2/COMPRESS.tmp"
echo -e "\n==== sh nix.sh start bohrview@10.129.34.250 logstash-6.2.4 --bootstrap-server ${KAFKA_ALL} --topic cores_pts__COMPRESS --id cores_pts --path ${path_cores_pts__COMPRESS}" && 
	        sh nix.sh start bohrview@10.129.34.250 logstash-6.2.4 --bootstrap-server ${KAFKA_ALL} --topic cores_pts__COMPRESS --id cores_pts --path ${path_cores_pts__COMPRESS}

# -- logi_pimp_protal
echo -e "\n==== sh nix.sh start X@X.X.X.X logstash-6.2.4 --bootstrap-server ${KAFKA_ALL} --db log --id logi_pimp_protal" &&  
	        sh nix.sh start X@X.X.X.X logstash-6.2.4 --bootstrap-server ${KAFKA_ALL} --db log --id logi_pimp_protal --path "
path_cores_pts__COMPRESS=path_cores_pts__COMPRESS=path_cores_pts__COMPRESS=                "

# -- es
echo -e "\n==== sh nix.sh start 10.132.37.36 logstash-6.2.4 --bootstrap-server ${KAFKA_ALL} --db log"
	        sh nix.sh start 10.132.37.36 logstash-6.2.4 --bootstrap-server ${KAFKA_ALL} --db log 
