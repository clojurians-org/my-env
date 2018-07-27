set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

export my_user=op
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
#echo -e "\n==== bash nix.sh init 10.132.37.41" && bash nix.sh init 10.132.37.41
#echo -e "\n==== bash nix.sh init 10.132.37.43" && bash nix.sh init 10.132.37.43

# install nix
#echo -e "\n==== bash nix.sh install 10.132.37.32" && bash nix.sh install 10.132.37.32
#echo -e "\n==== bash nix.sh install 10.132.37.33" && bash nix.sh install 10.132.37.33
#echo -e "\n==== bash nix.sh install 10.132.37.34" && bash nix.sh install 10.132.37.34
#echo -e "\n==== bash nix.sh install 10.132.37.35" && bash nix.sh install 10.132.37.35
#echo -e "\n==== bash nix.sh install 10.132.37.36" && bash nix.sh install 10.132.37.36
#echo -e "\n==== bash nix.sh install 10.132.37.37" && bash nix.sh install 10.132.37.37
#echo -e "\n==== bash nix.sh install 10.132.37.39" && bash nix.sh install 10.132.37.39
#echo -e "\n==== bash nix.sh install 10.132.37.40" && bash nix.sh install 10.132.37.40
#echo -e "\n==== bash nix.sh install 10.132.37.41" && bash nix.sh install 10.132.37.41
#echo -e "\n==== bash nix.sh install 10.132.37.43" && bash nix.sh install 10.132.37.43

# install gettext
#echo -e "\n==== bash nix.sh import 10.132.37.32 gettext-0.19.8.1" && bash nix.sh import 10.132.37.32 gettext-0.19.8.1
#echo -e "\n==== bash nix.sh import 10.132.37.33 gettext-0.19.8.1" && bash nix.sh import 10.132.37.33 gettext-0.19.8.1
#echo -e "\n==== bash nix.sh import 10.132.37.34 gettext-0.19.8.1" && bash nix.sh import 10.132.37.34 gettext-0.19.8.1
#echo -e "\n==== bash nix.sh import 10.132.37.35 gettext-0.19.8.1" && bash nix.sh import 10.132.37.35 gettext-0.19.8.1
#echo -e "\n==== bash nix.sh import 10.132.37.36 gettext-0.19.8.1" && bash nix.sh import 10.132.37.36 gettext-0.19.8.1
#echo -e "\n==== bash nix.sh import 10.132.37.37 gettext-0.19.8.1" && bash nix.sh import 10.132.37.37 gettext-0.19.8.1
#echo -e "\n==== bash nix.sh import 10.132.37.39 gettext-0.19.8.1" && bash nix.sh import 10.132.37.39 gettext-0.19.8.1
#echo -e "\n==== bash nix.sh import 10.132.37.40 gettext-0.19.8.1" && bash nix.sh import 10.132.37.40 gettext-0.19.8.1
#echo -e "\n==== bash nix.sh import 10.132.37.41 gettext-0.19.8.1" && bash nix.sh import 10.132.37.41 gettext-0.19.8.1
#echo -e "\n==== bash nix.sh import 10.132.37.43 gettext-0.19.8.1" && bash nix.sh import 10.132.37.43 gettext-0.19.8.1

# install oraclejre-8u181b13
echo -e "\n==== bash nix.sh import-tarball 10.132.37.32 oraclejre-8u181b13" && bash nix.sh import-tarball 10.132.37.32 oraclejre-8u181b13
echo -e "\n==== bash nix.sh import-tarball 10.132.37.33 oraclejre-8u181b13" && bash nix.sh import-tarball 10.132.37.33 oraclejre-8u181b13
echo -e "\n==== bash nix.sh import-tarball 10.132.37.34 oraclejre-8u181b13" && bash nix.sh import-tarball 10.132.37.34 oraclejre-8u181b13
echo -e "\n==== bash nix.sh import-tarball 10.132.37.35 oraclejre-8u181b13" && bash nix.sh import-tarball 10.132.37.35 oraclejre-8u181b13
echo -e "\n==== bash nix.sh import-tarball 10.132.37.36 oraclejre-8u181b13" && bash nix.sh import-tarball 10.132.37.36 oraclejre-8u181b13
echo -e "\n==== bash nix.sh import-tarball 10.132.37.37 oraclejre-8u181b13" && bash nix.sh import-tarball 10.132.37.37 oraclejre-8u181b13
echo -e "\n==== bash nix.sh import-tarball 10.132.37.39 oraclejre-8u181b13" && bash nix.sh import-tarball 10.132.37.39 oraclejre-8u181b13
echo -e "\n==== bash nix.sh import-tarball 10.132.37.40 oraclejre-8u181b13" && bash nix.sh import-tarball 10.132.37.40 oraclejre-8u181b13
echo -e "\n==== bash nix.sh import-tarball 10.132.37.41 oraclejre-8u181b13" && bash nix.sh import-tarball 10.132.37.41 oraclejre-8u181b13
echo -e "\n==== bash nix.sh import-tarball 10.132.37.43 oraclejre-8u181b13" && bash nix.sh import-tarball 10.132.37.43 oraclejre-8u181b13

# install zookeeper & kafka [message queue]
#echo -e "\n==== bash nix.sh import 10.132.37.33 zookeeper-3.4.12" && bash nix.sh import 10.132.37.33 zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.34 zookeeper-3.4.12" && bash nix.sh import 10.132.37.34 zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.35 zookeeper-3.4.12" && bash nix.sh import 10.132.37.35 zookeeper-3.4.12 
echo -e "\n==== bash nix.sh import-tarball 10.132.37.33 zookeeper-3.4.12" && bash nix.sh import-tarball 10.132.37.33 zookeeper-3.4.12 
echo -e "\n==== bash nix.sh import-tarball 10.132.37.34 zookeeper-3.4.12" && bash nix.sh import-tarball 10.132.37.34 zookeeper-3.4.12 
echo -e "\n==== bash nix.sh import-tarball 10.132.37.35 zookeeper-3.4.12" && bash nix.sh import-tarball 10.132.37.35 zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.33 apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.33 apache-kafka-2.12-1.1.0
#echo -e "\n==== bash nix.sh import 10.132.37.34 apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.34 apache-kafka-2.12-1.1.0
#echo -e "\n==== bash nix.sh import 10.132.37.35 apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.35 apache-kafka-2.12-1.1.0
echo -e "\n==== bash nix.sh import-tarball 10.132.37.33 apache-kafka-2.12-1.1.0" && bash nix.sh import-tarball 10.132.37.33 apache-kafka-2.12-1.1.0
echo -e "\n==== bash nix.sh import-tarball 10.132.37.34 apache-kafka-2.12-1.1.0" && bash nix.sh import-tarball 10.132.37.34 apache-kafka-2.12-1.1.0
echo -e "\n==== bash nix.sh import-tarball 10.132.37.35 apache-kafka-2.12-1.1.0" && bash nix.sh import-tarball 10.132.37.35 apache-kafka-2.12-1.1.0

# install elasticsearch & kibana & filebeat & logstash  [search-service]
#echo -e "\n==== bash nix.sh import 10.132.37.36 elasticsearch-6.2.4" && bash nix.sh import 10.132.37.36 elasticsearch-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.37 elasticsearch-6.2.4" && bash nix.sh import 10.132.37.37 elasticsearch-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.39 elasticsearch-6.2.4" && bash nix.sh import 10.132.37.39 elasticsearch-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.40 elasticsearch-6.2.4" && bash nix.sh import 10.132.37.40 elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import-tarball 10.132.37.36 elasticsearch-6.2.4" && bash nix.sh import-tarball 10.132.37.36 elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import-tarball 10.132.37.37 elasticsearch-6.2.4" && bash nix.sh import-tarball 10.132.37.37 elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import-tarball 10.132.37.39 elasticsearch-6.2.4" && bash nix.sh import-tarball 10.132.37.39 elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import-tarball 10.132.37.40 elasticsearch-6.2.4" && bash nix.sh import-tarball 10.132.37.40 elasticsearch-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.36 kibana-6.2.4" && bash nix.sh import 10.132.37.36 kibana-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.37 kibana-6.2.4" && bash nix.sh import 10.132.37.37 kibana-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.39 kibana-6.2.4" && bash nix.sh import 10.132.37.39 kibana-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.40 kibana-6.2.4" && bash nix.sh import 10.132.37.40 kibana-6.2.4
echo -e "\n==== bash nix.sh import-tarball 10.132.37.36 kibana-6.2.4" && bash nix.sh import-tarball 10.132.37.36 kibana-6.2.4
echo -e "\n==== bash nix.sh import-tarball 10.132.37.37 kibana-6.2.4" && bash nix.sh import-tarball 10.132.37.37 kibana-6.2.4
echo -e "\n==== bash nix.sh import-tarball 10.132.37.39 kibana-6.2.4" && bash nix.sh import-tarball 10.132.37.39 kibana-6.2.4
echo -e "\n==== bash nix.sh import-tarball 10.132.37.40 kibana-6.2.4" && bash nix.sh import-tarball 10.132.37.40 kibana-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.36 logstash-6.2.4" && bash nix.sh import 10.132.37.36 logstash-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.37 logstash-6.2.4" && bash nix.sh import 10.132.37.37 logstash-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.39 logstash-6.2.4" && bash nix.sh import 10.132.37.39 logstash-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.40 logstash-6.2.4" && bash nix.sh import 10.132.37.40 logstash-6.2.4
echo -e "\n==== bash nix.sh import-tarball 10.132.37.36 logstash-6.2.4" && bash nix.sh import-tarball 10.132.37.36 logstash-6.2.4
echo -e "\n==== bash nix.sh import-tarball 10.132.37.37 logstash-6.2.4" && bash nix.sh import-tarball 10.132.37.37 logstash-6.2.4
echo -e "\n==== bash nix.sh import-tarball 10.132.37.39 logstash-6.2.4" && bash nix.sh import-tarball 10.132.37.39 logstash-6.2.4
echo -e "\n==== bash nix.sh import-tarball 10.132.37.40 logstash-6.2.4" && bash nix.sh import-tarball 10.132.37.40 logstash-6.2.4

# install confluent-oss-2.11-4.1.2 [realtime-service]
echo -e "\n==== bash nix.sh import-tarball 10.132.37.36 confluent-oss-2.11-4.1.2" && bash nix.sh import-tarball 10.132.37.36 confluent-oss-2.11-4.1.2
echo -e "\n==== bash nix.sh import-tarball 10.132.37.37 confluent-oss-2.11-4.1.2" && bash nix.sh import-tarball 10.132.37.37 confluent-oss-2.11-4.1.2
echo -e "\n==== bash nix.sh import-tarball 10.132.37.39 confluent-oss-2.11-4.1.2" && bash nix.sh import-tarball 10.132.37.39 confluent-oss-2.11-4.1.2
echo -e "\n==== bash nix.sh import-tarball 10.132.37.40 confluent-oss-2.11-4.1.2" && bash nix.sh import-tarball 10.132.37.40 confluent-oss-2.11-4.1.2

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
echo -e "\n==== bash nix.sh import 10.132.37.43 postgresql-10.3" && bash nix.sh import 10.132.37.43 postgresql-10.3

# install client machine [zookeeper & kafka & filebeat & logstash & postgresql & mongodb & redis]
echo -e "\n==== bash nix.sh import 10.132.37.32 zookeeper-3.4.11" && bash nix.sh import 10.132.37.32 zookeeper-3.4.11 
echo -e "\n==== bash nix.sh import 10.132.37.32 apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.32 apache-kafka-2.12-1.1.0
echo -e "\n==== bash nix.sh import 10.132.37.32 filebeat-6.2.4" && bash nix.sh import 10.132.37.32 filebeat-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.32 logstash-6.2.4" && bash nix.sh import 10.132.37.32 logstash-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.32 postgresql-10.3" && bash nix.sh import 10.132.37.32 postgresql-10.3
echo -e "\n==== bash nix.sh import 10.132.37.32 mongodb-3.4.10" && bash nix.sh import 10.132.37.32 mongodb-3.4.10
echo -e "\n==== bash nix.sh import 10.132.37.32 redis-4.0.10" && bash nix.sh import 10.132.37.32 redis-4.0.10
