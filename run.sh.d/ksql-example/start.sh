my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

export my_user=op

export ZK_ALL="192.168.56.101:2181,192.168.56.102:2181,192.168.56.103:2181"
# start confluent-oss-5.0.0:zookeeper
echo -e "\n==== bash nix.sh start 192.168.56.101:2181 confluent-oss-5.0.0:zookeeper --all ${ZK_ALL}" 
                bash nix.sh start 192.168.56.101:2181 confluent-oss-5.0.0:zookeeper --all ${ZK_ALL}
echo -e "\n==== bash nix.sh start 192.168.56.102:2181 confluent-oss-5.0.0:zookeeper --all ${ZK_ALL}"
                bash nix.sh start 192.168.56.102:2181 confluent-oss-5.0.0:zookeeper --all ${ZK_ALL}
echo -e "\n==== bash nix.sh start 192.168.56.103:2181 confluent-oss-5.0.0:zookeeper --all ${ZK_ALL}" 
                bash nix.sh start 192.168.56.103:2181 confluent-oss-5.0.0:zookeeper --all ${ZK_ALL}

# start confluent-oss-5.0.0:kafka
export KAFKA_ALL="192.168.56.101:9092,192.168.56.102:9092,192.168.56.103:9092"
echo -e "\n==== bash nix.sh start 192.168.56.101:9092 confluent-oss-5.0.0:kafka --zookeepers ${ZK_ALL} --cluster.id monitor" 
                bash nix.sh start 192.168.56.101:9092 confluent-oss-5.0.0:kafka --zookeepers ${ZK_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 192.168.56.102:9092 confluent-oss-5.0.0:kafka --zookeepers ${ZK_ALL} --cluster.id monitor" 
                bash nix.sh start 192.168.56.102:9092 confluent-oss-5.0.0:kafka --zookeepers ${ZK_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 192.168.56.103:9092 confluent-oss-5.0.0:kafka --zookeepers ${ZK_ALL} --cluster.id monitor" 
                bash nix.sh start 192.168.56.103:9092 confluent-oss-5.0.0:kafka --zookeepers ${ZK_ALL} --cluster.id monitor

# start confluent-oss-5.0.0:ksql
echo -e "\n==== bash nix.sh start 192.168.56.101:8088 confluent-oss-5.0.0:ksql --kafkas ${KAFKA_ALL} --cluster.id monitor" 
                bash nix.sh start 192.168.56.101:8088 confluent-oss-5.0.0:ksql --kafkas ${KAFKA_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 192.168.56.102:8088 confluent-oss-5.0.0:ksql --kafkas ${KAFKA_ALL} --cluster.id monitor" 
                bash nix.sh start 192.168.56.102:8088 confluent-oss-5.0.0:ksql --kafkas ${KAFKA_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 192.168.56.103:8088 confluent-oss-5.0.0:ksql --kafkas ${KAFKA_ALL} --cluster.id monitor" 
                bash nix.sh start 192.168.56.103:8088 confluent-oss-5.0.0:ksql --kafkas ${KAFKA_ALL} --cluster.id monitor

# start confluent-oss-5.0.0:schema-registry
echo -e "\n==== bash nix.sh start 192.168.56.101:8081 confluent-oss-5.0.0:schema-registry --kafkas ${KAFKA_ALL} --cluster.id monitor"
                bash nix.sh start 192.168.56.101:8081 confluent-oss-5.0.0:schema-registry --kafkas ${KAFKA_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 192.168.56.102:8081 confluent-oss-5.0.0:schema-registry --kafkas ${KAFKA_ALL} --cluster.id monitor"
                bash nix.sh start 192.168.56.102:8081 confluent-oss-5.0.0:schema-registry --kafkas ${KAFKA_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 192.168.56.103:8081 confluent-oss-5.0.0:schema-registry --kafkas ${KAFKA_ALL} --cluster.id monitor"
                bash nix.sh start 192.168.56.103:8081 confluent-oss-5.0.0:schema-registry --kafkas ${KAFKA_ALL} --cluster.id monitor

# start confluent-oss-5.0.0:kafka-connect
echo -e "\n==== bash nix.sh start 192.168.56.101:8083 confluent-oss-5.0.0:kafka-connect --kafkas ${KAFKA_ALL} --cluster.id monitor" 
                bash nix.sh start 192.168.56.101:8083 confluent-oss-5.0.0:kafka-connect --kafkas ${KAFKA_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 192.168.56.102:8083 confluent-oss-5.0.0:kafka-connect --kafkas ${KAFKA_ALL} --cluster.id monitor" 
                bash nix.sh start 192.168.56.102:8083 confluent-oss-5.0.0:kafka-connect --kafkas ${KAFKA_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 192.168.56.103:8083 confluent-oss-5.0.0:kafka-connect --kafkas ${KAFKA_ALL} --cluster.id monitor" 
                bash nix.sh start 192.168.56.103:8083 confluent-oss-5.0.0:kafka-connect --kafkas ${KAFKA_ALL} --cluster.id monitor

# start postgresql-10.4
echo -e "\n==== bash nix.sh start 192.168.56.101:5432 postgresql-10.4" && bash nix.sh start 192.168.56.101:5432 postgresql-10.4
