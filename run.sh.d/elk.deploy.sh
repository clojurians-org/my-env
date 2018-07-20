my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/..

#========
# SERVER
#========
# init nix[root]
#echo -e "\n==== bash nix.sh init 10.132.37.32" && bash nix.sh init 10.132.37.32 
#echo -e "\n==== bash nix.sh init 10.132.37.33" && bash nix.sh init 10.132.37.33 
#echo -e "\n==== bash nix.sh init 10.132.37.34" && bash nix.sh init 10.132.37.34 
#echo -e "\n==== bash nix.sh init 10.132.37.35" && bash nix.sh init 10.132.37.35 
#echo -e "\n==== bash nix.sh init 10.132.37.36" && bash nix.sh init 10.132.37.36 
#echo -e "\n==== bash nix.sh init 10.132.37.37" && bash nix.sh init 10.132.37.37 
#echo -e "\n==== bash nix.sh init 10.132.37.39" && bash nix.sh init 10.132.37.39
#echo -e "\n==== bash nix.sh init 10.132.37.40" && bash nix.sh init 10.132.37.40
echo -e "\n==== bash nix.sh init 10.132.37.41" && bash nix.sh init 10.132.37.41
echo -e "\n==== bash nix.sh init 10.132.37.42" && bash nix.sh init 10.132.37.42
echo -e "\n==== bash nix.sh init 10.132.37.43" && bash nix.sh init 10.132.37.43

# install nix
echo -e "\n==== bash nix.sh install 10.132.37.32" && bash nix.sh install 10.132.37.32
echo -e "\n==== bash nix.sh install 10.132.37.33" && bash nix.sh install 10.132.37.33
echo -e "\n==== bash nix.sh install 10.132.37.34" && bash nix.sh install 10.132.37.34
echo -e "\n==== bash nix.sh install 10.132.37.35" && bash nix.sh install 10.132.37.35
echo -e "\n==== bash nix.sh install 10.132.37.36" && bash nix.sh install 10.132.37.36
echo -e "\n==== bash nix.sh install 10.132.37.37" && bash nix.sh install 10.132.37.37
echo -e "\n==== bash nix.sh install 10.132.37.39" && bash nix.sh install 10.132.37.39
echo -e "\n==== bash nix.sh install 10.132.37.40" && bash nix.sh install 10.132.37.40
echo -e "\n==== bash nix.sh install 10.132.37.41" && bash nix.sh install 10.132.37.41
echo -e "\n==== bash nix.sh install 10.132.37.42" && bash nix.sh install 10.132.37.42
echo -e "\n==== bash nix.sh install 10.132.37.43" && bash nix.sh install 10.132.37.43

# install zookeeper & kafka [message queue]
echo -e "\n==== bash nix.sh import 10.132.37.33 zookeeper-3.4.11" && bash nix.sh import 10.132.37.33 zookeeper-3.4.11 
echo -e "\n==== bash nix.sh import 10.132.37.34 zookeeper-3.4.11" && bash nix.sh import 10.132.37.34 zookeeper-3.4.11 
echo -e "\n==== bash nix.sh import 10.132.37.35 zookeeper-3.4.11" && bash nix.sh import 10.132.37.35 zookeeper-3.4.11 
echo -e "\n==== bash nix.sh import 10.132.37.33 zookeeper-3.4.12" && bash nix.sh import 10.132.37.33 zookeeper-3.4.12 
echo -e "\n==== bash nix.sh import 10.132.37.34 zookeeper-3.4.12" && bash nix.sh import 10.132.37.34 zookeeper-3.4.12 
echo -e "\n==== bash nix.sh import 10.132.37.35 zookeeper-3.4.12" && bash nix.sh import 10.132.37.35 zookeeper-3.4.12 
echo -e "\n==== bash nix.sh import 10.132.37.33 apache-kafka-2.11-0.9.0.1" && bash nix.sh import 10.132.37.33 apache-kafka-2.11-0.9.0.1
echo -e "\n==== bash nix.sh import 10.132.37.34 apache-kafka-2.11-0.9.0.1" && bash nix.sh import 10.132.37.34 apache-kafka-2.11-0.9.0.1
echo -e "\n==== bash nix.sh import 10.132.37.35 apache-kafka-2.11-0.9.0.1" && bash nix.sh import 10.132.37.35 apache-kafka-2.11-0.9.0.1
echo -e "\n==== bash nix.sh import 10.132.37.33 apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.33 apache-kafka-2.12-1.1.0
echo -e "\n==== bash nix.sh import 10.132.37.34 apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.34 apache-kafka-2.12-1.1.0
echo -e "\n==== bash nix.sh import 10.132.37.35 apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.35 apache-kafka-2.12-1.1.0

# install elasticsearch & kibana & filebeat & logstash  [search-service]
echo -e "\n==== bash nix.sh import 10.132.37.36 elasticsearch-6.2.4" && bash nix.sh import 10.132.37.36 elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.37 elasticsearch-6.2.4" && bash nix.sh import 10.132.37.37 elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.39 elasticsearch-6.2.4" && bash nix.sh import 10.132.37.39 elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.40 elasticsearch-6.2.4" && bash nix.sh import 10.132.37.40 elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.36 kibana-6.2.4" && bash nix.sh import 10.132.37.36 kibana-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.36 filebeat-6.2.4" && bash nix.sh import 10.132.37.36 filebeat-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.36 logstash-2.4.0" && bash nix.sh import 10.132.37.36 logstash-2.4.0
echo -e "\n==== bash nix.sh import 10.132.37.36 logstash-6.2.4" && bash nix.sh import 10.132.37.36 logstash-6.2.4

# install mongo & postgresql & redis [report-service]
echo -e "\n==== bash nix.sh import 10.132.37.36 postgresql-10.3" && bash nix.sh import 10.132.37.36 postgresql-10.3
echo -e "\n==== bash nix.sh import 10.132.37.37 postgresql-10.3" && bash nix.sh import 10.132.37.37 postgresql-10.3
echo -e "\n==== bash nix.sh import 10.132.37.39 postgresql-10.3" && bash nix.sh import 10.132.37.39 postgresql-10.3
echo -e "\n==== bash nix.sh import 10.132.37.40 postgresql-10.3" && bash nix.sh import 10.132.37.40 postgresql-10.3
echo -e "\n==== bash nix.sh import 10.132.37.36 mongodb-3.4.10" && bash nix.sh import 10.132.37.36 mongodb-3.4.10
echo -e "\n==== bash nix.sh import 10.132.37.37 mongodb-3.4.10" && bash nix.sh import 10.132.37.37 mongodb-3.4.10
echo -e "\n==== bash nix.sh import 10.132.37.39 mongodb-3.4.10" && bash nix.sh import 10.132.37.39 mongodb-3.4.10
echo -e "\n==== bash nix.sh import 10.132.37.40 mongodb-3.4.10" && bash nix.sh import 10.132.37.40 mongodb-3.4.10
echo -e "\n==== bash nix.sh import 10.132.37.36 redis-4.0.10" && bash nix.sh import 10.132.37.36 redis-4.0.10
echo -e "\n==== bash nix.sh import 10.132.37.37 redis-4.0.10" && bash nix.sh import 10.132.37.37 redis-4.0.10
echo -e "\n==== bash nix.sh import 10.132.37.39 redis-4.0.10" && bash nix.sh import 10.132.37.39 redis-4.0.10
echo -e "\n==== bash nix.sh import 10.132.37.40 redis-4.0.10" && bash nix.sh import 10.132.37.40 redis-4.0.10

# install postgresql [data-platform]
echo -e "\n==== bash nix.sh import 10.132.37.41 postgresql-10.3" && bash nix.sh import 10.132.37.41 postgresql-10.3
echo -e "\n==== bash nix.sh import 10.132.37.42 postgresql-10.3" && bash nix.sh import 10.132.37.42 postgresql-10.3
echo -e "\n==== bash nix.sh import 10.132.37.43 postgresql-10.3" && bash nix.sh import 10.132.37.43 postgresql-10.3

# install client machine [zookeeper & kafka & filebeat & logstash & postgresql & mongodb & redis]
echo -e "\n==== bash nix.sh import 10.132.37.32 zookeeper-3.4.11" && bash nix.sh import 10.132.37.32 zookeeper-3.4.11 
echo -e "\n==== bash nix.sh import 10.132.37.32 apache-kafka-2.11-0.9.0.1" && bash nix.sh import 10.132.37.32 apache-kafka-2.11-0.9.0.1
echo -e "\n==== bash nix.sh import 10.132.37.32 apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.32 apache-kafka-2.12-1.1.0
echo -e "\n==== bash nix.sh import 10.132.37.32 filebeat-6.2.4" && bash nix.sh import 10.132.37.32 filebeat-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.32 logstash-2.4.0" && bash nix.sh import 10.132.37.32 logstash-2.4.0
echo -e "\n==== bash nix.sh import 10.132.37.32 logstash-6.2.4" && bash nix.sh import 10.132.37.32 logstash-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.32 postgresql-10.3" && bash nix.sh import 10.132.37.32 postgresql-10.3
echo -e "\n==== bash nix.sh import 10.132.37.32 mongodb-3.4.10" && bash nix.sh import 10.132.37.32 mongodb-3.4.10
echo -e "\n==== bash nix.sh import 10.132.37.32 redis-4.0.10" && bash nix.sh import 10.132.37.32 redis-4.0.10

#========
# CLIENT
#========

# init nix[root]
# echo -e "\n==== bash nix.sh init 10.132.33.43" && bash nix.sh init 10.132.33.43

# install nix
echo -e "\n==== bash nix.sh install 10.132.33.43" && bash nix.sh install 10.132.33.43

# install filebeat & logstash & kafka
echo -e "\n==== bash nix.sh import 10.132.33.43 filebeat-6.2.4" && bash nix.sh import 10.132.33.43 filebeat-6.2.4
echo -e "\n==== bash nix.sh import 10.132.33.43 logstash-2.4.0" && bash nix.sh import 10.132.33.43 logstash-2.4.0
echo -e "\n==== bash nix.sh import 10.132.33.43 logstash-6.2.4" && bash nix.sh import 10.132.33.43 logstash-6.2.4
echo -e "\n==== bash nix.sh import 10.132.33.43 apache-kafka-2.11-0.9.0.1" && bash nix.sh import 10.132.33.43 apache-kafka-2.11-0.9.0.1
echo -e "\n==== bash nix.sh import 10.132.33.43 apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.33.43 apache-kafka-2.12-1.1.0
