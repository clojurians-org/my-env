my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my

export ZK_ALL="10.132.37.33:2181,10.132.37.34:2181,10.132.37.34:2181"
# start zookeeper-3.4.12
echo -e "\n==== sh nix.sh start 10.132.37.33:2181 zookeeper-3.4.12 --all ${ZK_ALL}" && sh nix.sh start 10.132.37.33:2181 zookeeper-3.4.12 ${ZK_ALL}
echo -e "\n==== sh nix.sh start 10.132.37.34:2181 zookeeper-3.4.12 --all ${ZK_ALL}" && sh nix.sh start 10.132.37.34:2181 zookeeper-3.4.12 ${ZK_ALL}
echo -e "\n==== sh nix.sh start 10.132.37.35:2181 zookeeper-3.4.12 --all ${ZK_ALL}" && sh nix.sh start 10.132.37.35:2181 zookeeper-3.4.12 ${ZK_ALL}

# start apache-kafka-2.12-1.1.0
export KAFKA_ALL="10.132.37.33:9092,10.132.37.34:9092,10.132.37.35:9092"
echo -e "\n==== sh nix.sh start 10.132.37.33:9092 apache-kafka-2.12-1.1.0 --zookeeper ${ZK_ALL}" && sh nix.sh start 10.132.37.33:9092 apache-kafka-2.12-1.1.0 --zookeeper ${ZK_ALL}
echo -e "\n==== sh nix.sh start 10.132.37.34:9092 apache-kafka-2.12-1.1.0 --zookeeper ${ZK_ALL}" && sh nix.sh start 10.132.37.34:9092 apache-kafka-2.12-1.1.0 --zookeeper ${ZK_ALL}
echo -e "\n==== sh nix.sh start 10.132.37.35:9092 apache-kafka-2.12-1.1.0 --zookeeper ${ZK_ALL}" && sh nix.sh start 10.132.37.35:9092 apache-kafka-2.12-1.1.0 --zookeeper ${ZK_ALL}

# start elasticsearch-6.2.4
export ES_ALL="10.132.37.36:9200,10.132.37.37:9200,10.132.37.39:9200"
echo -e "\n==== sh nix.sh start 10.132.37.36:9200 elasticsearch-6.2.4" && sh nix.sh import 10.132.37.36 elasticsearch-6.2.4
echo -e "\n==== sh nix.sh start 10.132.37.37:9200 elasticsearch-6.2.4" && sh nix.sh import 10.132.37.37 elasticsearch-6.2.4
echo -e "\n==== sh nix.sh start 10.132.37.39:9200 elasticsearch-6.2.4" && sh nix.sh import 10.132.37.39 elasticsearch-6.2.4

# start kibana-6.2.4
echo -e "\n==== sh nix.sh start 10.132.37.36:5601 kibana-6.2.4 -e ${ES_ALL}" && sh nix.sh start 10.132.37.36 kibana-6.2.4 -e ${ES_ALL}
