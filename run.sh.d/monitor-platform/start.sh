my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

export ZK_ALL="10.132.37.33:2181,10.132.37.34:2181,10.132.37.35:2181"
# start confluent-oss-5.0.0:zookeeper
echo -e "\n==== bash nix.sh start 10.132.37.33:2181 confluent-oss-5.0.0:zookeeper --all ${ZK_ALL}" 
                bash nix.sh start 10.132.37.33:2181 confluent-oss-5.0.0:zookeeper --all ${ZK_ALL}
echo -e "\n==== bash nix.sh start 10.132.37.34:2181 confluent-oss-5.0.0:zookeeper --all ${ZK_ALL}"
                bash nix.sh start 10.132.37.34:2181 confluent-oss-5.0.0:zookeeper --all ${ZK_ALL}
echo -e "\n==== bash nix.sh start 10.132.37.35:2181 confluent-oss-5.0.0:zookeeper --all ${ZK_ALL}" 
                bash nix.sh start 10.132.37.35:2181 confluent-oss-5.0.0:zookeeper --all ${ZK_ALL}

# start confluent-oss-5.0.0:kafka
export KAFKA_ALL="10.132.37.33:9092,10.132.37.34:9092,10.132.37.35:9092"
echo -e "\n==== bash nix.sh start 10.132.37.33:9092 confluent-oss-5.0.0:kafka --zookeepers ${ZK_ALL} --cluster.id monitor" 
                bash nix.sh start 10.132.37.33:9092 confluent-oss-5.0.0:kafka --zookeepers ${ZK_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 10.132.37.34:9092 confluent-oss-5.0.0:kafka --zookeepers ${ZK_ALL} --cluster.id monitor" 
                bash nix.sh start 10.132.37.34:9092 confluent-oss-5.0.0:kafka --zookeepers ${ZK_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 10.132.37.35:9092 confluent-oss-5.0.0:kafka --zookeepers ${ZK_ALL} --cluster.id monitor" 
                bash nix.sh start 10.132.37.35:9092 confluent-oss-5.0.0:kafka --zookeepers ${ZK_ALL} --cluster.id monitor

# start confluent-oss-5.0.0:ksql
echo -e "\n==== bash nix.sh start 10.132.37.33:8088 confluent-oss-5.0.0:ksql --kafkas ${KAFKA_ALL} --cluster.id monitor" 
                bash nix.sh start 10.132.37.33:8088 confluent-oss-5.0.0:ksql --kafkas ${KAFKA_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 10.132.37.34:8088 confluent-oss-5.0.0:ksql --kafkas ${KAFKA_ALL} --cluster.id monitor" 
                bash nix.sh start 10.132.37.34:8088 confluent-oss-5.0.0:ksql --kafkas ${KAFKA_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 10.132.37.35:8088 confluent-oss-5.0.0:ksql --kafkas ${KAFKA_ALL} --cluster.id monitor" 
                bash nix.sh start 10.132.37.35:8088 confluent-oss-5.0.0:ksql --kafkas ${KAFKA_ALL} --cluster.id monitor

# start confluent-oss-5.0.0:schema-registry
echo -e "\n==== bash nix.sh start 10.132.37.33:8081 confluent-oss-5.0.0:schema-registry --kafkas ${KAFKA_ALL} --cluster.id monitor"
                bash nix.sh start 10.132.37.33:8081 confluent-oss-5.0.0:schema-registry --kafkas ${KAFKA_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 10.132.37.34:8081 confluent-oss-5.0.0:schema-registry --kafkas ${KAFKA_ALL} --cluster.id monitor"
                bash nix.sh start 10.132.37.34:8081 confluent-oss-5.0.0:schema-registry --kafkas ${KAFKA_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 10.132.37.35:8081 confluent-oss-5.0.0:schema-registry --kafkas ${KAFKA_ALL} --cluster.id monitor"
                bash nix.sh start 10.132.37.35:8081 confluent-oss-5.0.0:schema-registry --kafkas ${KAFKA_ALL} --cluster.id monitor

# start confluent-oss-5.0.0:kafka-connect
echo -e "\n==== bash nix.sh start 10.132.37.33:8083 confluent-oss-5.0.0:kafka-connect --kafkas ${KAFKA_ALL} --cluster.id monitor" 
                bash nix.sh start 10.132.37.33:8083 confluent-oss-5.0.0:kafka-connect --kafkas ${KAFKA_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 10.132.37.34:8083 confluent-oss-5.0.0:kafka-connect --kafkas ${KAFKA_ALL} --cluster.id monitor" 
                bash nix.sh start 10.132.37.34:8083 confluent-oss-5.0.0:kafka-connect --kafkas ${KAFKA_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 10.132.37.35:8083 confluent-oss-5.0.0:kafka-connect --kafkas ${KAFKA_ALL} --cluster.id monitor" 
                bash nix.sh start 10.132.37.35:8083 confluent-oss-5.0.0:kafka-connect --kafkas ${KAFKA_ALL} --cluster.id monitor

# start elasticsearch-6.2.4
export ES_ALL="10.132.37.36:9200,10.132.37.37:9200,10.132.37.39:9200,10.132.37.40:9200"
echo -e "\n==== bash nix.sh start 10.132.37.36:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor" 
                bash nix.sh start 10.132.37.36:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 10.132.37.37:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor" 
                bash nix.sh start 10.132.37.37:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 10.132.37.39:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor" 
                bash nix.sh start 10.132.37.39:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 10.132.37.40:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor" 
                bash nix.sh start 10.132.37.40:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor

# start kibana-6.2.4
echo -e "\n==== bash nix.sh start 10.132.37.36:5601 kibana-6.2.4" && bash nix.sh start 10.132.37.36:5601 kibana-6.2.4
echo -e "\n==== bash nix.sh start 10.132.37.37:5601 kibana-6.2.4" && bash nix.sh start 10.132.37.37:5601 kibana-6.2.4
echo -e "\n==== bash nix.sh start 10.132.37.39:5601 kibana-6.2.4" && bash nix.sh start 10.132.37.39:5601 kibana-6.2.4
echo -e "\n==== bash nix.sh start 10.132.37.40:5601 kibana-6.2.4" && bash nix.sh start 10.132.37.40:5601 kibana-6.2.4

# start postgresql-10.4
echo -e "\n==== bash nix.sh start 10.132.37.36:5432 postgresql-10.4" && bash nix.sh start 10.132.37.36:5432 postgresql-10.4
echo -e "\n==== bash nix.sh start 10.132.37.37:5432 postgresql-10.4" && bash nix.sh start 10.132.37.37:5432 postgresql-10.4
echo -e "\n==== bash nix.sh start 10.132.37.39:5432 postgresql-10.4" && bash nix.sh start 10.132.37.39:5432 postgresql-10.4
echo -e "\n==== bash nix.sh start 10.132.37.40:5432 postgresql-10.4" && bash nix.sh start 10.132.37.40:5432 postgresql-10.4
