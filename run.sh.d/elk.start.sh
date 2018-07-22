my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my

export ZK_ALL="192.168.56.101:2181,192.168.56.102:2181,192.168.56.103:2181"
# start zookeeper-3.4.12
# [debug] bash nix.sh start-foreground 192.168.56.101:2181 zookeeper-3.4.12 --all ${ZK_ALL}
echo -e "\n==== bash nix.sh start 192.168.56.101:2181 zookeeper-3.4.12 --all ${ZK_ALL}" && bash nix.sh start 192.168.56.101:2181 zookeeper-3.4.12 --all ${ZK_ALL}
echo -e "\n==== bash nix.sh start 192.168.56.102:2181 zookeeper-3.4.12 --all ${ZK_ALL}" && bash nix.sh start 192.168.56.102:2181 zookeeper-3.4.12 --all ${ZK_ALL}
echo -e "\n==== bash nix.sh start 192.168.56.103:2181 zookeeper-3.4.12 --all ${ZK_ALL}" && bash nix.sh start 192.168.56.103:2181 zookeeper-3.4.12 --all ${ZK_ALL}

# start apache-kafka-2.12-1.1.0
export KAFKA_ALL="192.168.56.101:9092,192.168.56.102:9092,192.168.56.103:9092"
# [debug] bash nix.sh start-foreground 192.168.56.101:9092 apache-kafka-2.12-1.1.0 --zookeepers ${ZK_ALL} --cluster.id=monitor
echo -e "\n==== bash nix.sh start 192.168.56.101:9092 apache-kafka-2.12-1.1.0 --zookeepers ${ZK_ALL} --cluster.id=monitor" 
                bash nix.sh start 192.168.56.101:9092 apache-kafka-2.12-1.1.0 --zookeepers ${ZK_ALL} --cluster.id=monitor
echo -e "\n==== bash nix.sh start 192.168.56.102:9092 apache-kafka-2.12-1.1.0 --zookeepers ${ZK_ALL} --cluster.id=monitor" 
                bash nix.sh start 192.168.56.102:9092 apache-kafka-2.12-1.1.0 --zookeepers ${ZK_ALL} --cluster.id=monitor
echo -e "\n==== bash nix.sh start 192.168.56.103:9092 apache-kafka-2.12-1.1.0 --zookeepers ${ZK_ALL} --cluster.id=monitor" 
                bash nix.sh start 192.168.56.103:9092 apache-kafka-2.12-1.1.0 --zookeepers ${ZK_ALL} --cluster.id=monitor

# start elasticsearch-6.2.4
export ES_ALL="192.168.56.101:9200,192.168.56.102:9200,192.168.56.103:9200"
# [debug] bash nix.sh start-foreground 192.168.56.101:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 192.168.56.101:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor" 
                bash nix.sh start 192.168.56.101:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 192.168.56.102:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor" 
                bash nix.sh start 192.168.56.102:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 192.168.56.103:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor"
                bash nix.sh start 192.168.56.103:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor

# start kibana-6.2.4
# [debug] bash nix.sh start-foreground 192.168.50.101:5601 kibana-6.2.4 --elasticsearchs ${ES_ALL}
echo -e "\n==== bash nix.sh start 192.168.50.101:5601 kibana-6.2.4 --elasticsearchs ${ES_ALL}" && bash nix.sh start 192.168.50.101:5601 kibana-6.2.4 --elasticsearchs ${ES_ALL}
echo -e "\n==== bash nix.sh start 192.168.50.102:5601 kibana-6.2.4 --elasticsearchs ${ES_ALL}" && bash nix.sh start 192.168.50.102:5601 kibana-6.2.4 --elasticsearchs ${ES_ALL}
echo -e "\n==== bash nix.sh start 192.168.50.103:5601 kibana-6.2.4 --elasticsearchs ${ES_ALL}" && bash nix.sh start 192.168.50.103:5601 kibana-6.2.4 --elasticsearchs ${ES_ALL}

