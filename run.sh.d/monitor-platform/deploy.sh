set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

export my_user=op
#==================================
# ENV SETUP
#==================================
# create-user [root]
#echo -e "\n==== bash nix.sh create-user 10.132.37.32" && bash nix.sh create-user 10.132.37.32 
#echo -e "\n==== bash nix.sh create-user 10.132.37.33" && bash nix.sh create-user 10.132.37.33 
#echo -e "\n==== bash nix.sh create-user 10.132.37.34" && bash nix.sh create-user 10.132.37.34 
#echo -e "\n==== bash nix.sh create-user 10.132.37.35" && bash nix.sh create-user 10.132.37.35 
#echo -e "\n==== bash nix.sh create-user 10.132.37.36" && bash nix.sh create-user 10.132.37.36 
#echo -e "\n==== bash nix.sh create-user 10.132.37.37" && bash nix.sh create-user 10.132.37.37 
#echo -e "\n==== bash nix.sh create-user 10.132.37.39" && bash nix.sh create-user 10.132.37.39
#echo -e "\n==== bash nix.sh create-user 10.132.37.40" && bash nix.sh create-user 10.132.37.40

# install nix
#echo -e "\n==== bash nix.sh install 10.132.37.32 tgz.nix-2.0.4" && bash nix.sh install 10.132.37.32 tgz.nix-2.0.4
#echo -e "\n==== bash nix.sh install 10.132.37.33 tgz.nix-2.0.4" && bash nix.sh install 10.132.37.33 tgz.nix-2.0.4
#echo -e "\n==== bash nix.sh install 10.132.37.34 tgz.nix-2.0.4" && bash nix.sh install 10.132.37.34 tgz.nix-2.0.4
#echo -e "\n==== bash nix.sh install 10.132.37.35 tgz.nix-2.0.4" && bash nix.sh install 10.132.37.35 tgz.nix-2.0.4
#echo -e "\n==== bash nix.sh install 10.132.37.36 tgz.nix-2.0.4" && bash nix.sh install 10.132.37.36 tgz.nix-2.0.4
#echo -e "\n==== bash nix.sh install 10.132.37.37 tgz.nix-2.0.4" && bash nix.sh install 10.132.37.37 tgz.nix-2.0.4
#echo -e "\n==== bash nix.sh install 10.132.37.39 tgz.nix-2.0.4" && bash nix.sh install 10.132.37.39 tgz.nix-2.0.4
#echo -e "\n==== bash nix.sh install 10.132.37.40 tgz.nix-2.0.4" && bash nix.sh install 10.132.37.40 tgz.nix-2.0.4

# install gettext
#echo -e "\n==== bash nix.sh install 10.132.37.33 nix.gettext-0.19.8.1" && bash nix.sh install 10.132.37.33 nix.gettext-0.19.8.1
#echo -e "\n==== bash nix.sh install 10.132.37.34 nix.gettext-0.19.8.1" && bash nix.sh install 10.132.37.34 nix.gettext-0.19.8.1
#echo -e "\n==== bash nix.sh install 10.132.37.35 nix.gettext-0.19.8.1" && bash nix.sh install 10.132.37.35 nix.gettext-0.19.8.1
#echo -e "\n==== bash nix.sh install 10.132.37.36 nix.gettext-0.19.8.1" && bash nix.sh install 10.132.37.36 nix.gettext-0.19.8.1
#echo -e "\n==== bash nix.sh install 10.132.37.37 nix.gettext-0.19.8.1" && bash nix.sh install 10.132.37.37 nix.gettext-0.19.8.1
#echo -e "\n==== bash nix.sh install 10.132.37.39 nix.gettext-0.19.8.1" && bash nix.sh install 10.132.37.39 nix.gettext-0.19.8.1
#echo -e "\n==== bash nix.sh install 10.132.37.40 nix.gettext-0.19.8.1" && bash nix.sh install 10.132.37.40 nix.gettext-0.19.8.1

# install oraclejre-8u181b13
echo -e "\n==== bash nix.sh import 10.132.37.33 tgz.oraclejre-8u181b13" && bash nix.sh import 10.132.37.33 tgz.oraclejre-8u181b13
echo -e "\n==== bash nix.sh import 10.132.37.34 tgz.oraclejre-8u181b13" && bash nix.sh import 10.132.37.34 tgz.oraclejre-8u181b13
echo -e "\n==== bash nix.sh import 10.132.37.35 tgz.oraclejre-8u181b13" && bash nix.sh import 10.132.37.35 tgz.oraclejre-8u181b13
echo -e "\n==== bash nix.sh import 10.132.37.36 tgz.oraclejre-8u181b13" && bash nix.sh import 10.132.37.36 tgz.oraclejre-8u181b13
echo -e "\n==== bash nix.sh import 10.132.37.37 tgz.oraclejre-8u181b13" && bash nix.sh import 10.132.37.37 tgz.oraclejre-8u181b13
echo -e "\n==== bash nix.sh import 10.132.37.39 tgz.oraclejre-8u181b13" && bash nix.sh import 10.132.37.39 tgz.oraclejre-8u181b13
echo -e "\n==== bash nix.sh import 10.132.37.40 tgz.oraclejre-8u181b13" && bash nix.sh import 10.132.37.40 tgz.oraclejre-8u181b13

#==================================
# STREAMING ENGINE [KAFKA + KAFKA STREAMS + KSQL + KAFKA CONNECT]
#==================================
# install zookeeper & kafka & ksql [streaming-platform]
#echo -e "\n==== bash nix.sh import 10.132.37.33 nix.zookeeper-3.4.12" && bash nix.sh import 10.132.37.33 nix.zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.34 nix.zookeeper-3.4.12" && bash nix.sh import 10.132.37.34 nix.zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.35 nix.zookeeper-3.4.12" && bash nix.sh import 10.132.37.35 nix.zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.33 tgz.zookeeper-3.4.12" && bash nix.sh import 10.132.37.33 tgz.zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.34 tgz.zookeeper-3.4.12" && bash nix.sh import 10.132.37.34 tgz.zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.35 tgz.zookeeper-3.4.12" && bash nix.sh import 10.132.37.35 tgz.zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.33 nix.apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.33 nix.apache-kafka-2.12-1.1.0
#echo -e "\n==== bash nix.sh import 10.132.37.34 nix.apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.34 nix.apache-kafka-2.12-1.1.0
#echo -e "\n==== bash nix.sh import 10.132.37.35 nix.apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.35 nix.apache-kafka-2.12-1.1.0
#echo -e "\n==== bash nix.sh import 10.132.37.33 tgz.apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.33 tgz.apache-kafka-2.12-1.1.0
#echo -e "\n==== bash nix.sh import 10.132.37.34 tgz.apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.34 tgz.apache-kafka-2.12-1.1.0
#echo -e "\n==== bash nix.sh import 10.132.37.35 tgz.apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.35 tgz.apache-kafka-2.12-1.1.0
#echo -e "\n==== bash nix.sh import 10.132.37.33 tgz.ksql-5.0.0" && bash nix.sh import 10.132.37.33 tgz.ksql-5.0.0
#echo -e "\n==== bash nix.sh import 10.132.37.34 tgz.ksql-5.0.0" && bash nix.sh import 10.132.37.34 tgz.ksql-5.0.0
#echo -e "\n==== bash nix.sh import 10.132.37.35 tgz.ksql-5.0.0" && bash nix.sh import 10.132.37.35 tgz.ksql-5.0.0
echo -e "\n==== bash nix.sh import 10.132.37.33 tgz.confluent-oss-5.0.0" && bash nix.sh import 10.132.37.33 tgz.confluent-oss-5.0.0
echo -e "\n==== bash nix.sh import 10.132.37.34 tgz.confluent-oss-5.0.0" && bash nix.sh import 10.132.37.34 tgz.confluent-oss-5.0.0
echo -e "\n==== bash nix.sh import 10.132.37.35 tgz.confluent-oss-5.0.0" && bash nix.sh import 10.132.37.35 tgz.confluent-oss-5.0.0

#==================================
# SERVICE INTERFACE [ELASTICSEARCH & KIBANA + POSTGRESQL + REDIS + HBASE]
#==================================
# install elasticsearch & kibana & filebeat & logstash  [search-service]
#echo -e "\n==== bash nix.sh import 10.132.37.36 nix.elasticsearch-6.2.4" && bash nix.sh import 10.132.37.36 nix.elasticsearch-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.37 nix.elasticsearch-6.2.4" && bash nix.sh import 10.132.37.37 nix.elasticsearch-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.39 nix.elasticsearch-6.2.4" && bash nix.sh import 10.132.37.39 nix.elasticsearch-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.40 nix.elasticsearch-6.2.4" && bash nix.sh import 10.132.37.40 nix.elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.36 tgz.elasticsearch-6.2.4" && bash nix.sh import 10.132.37.36 tgz.elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.37 tgz.elasticsearch-6.2.4" && bash nix.sh import 10.132.37.37 tgz.elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.39 tgz.elasticsearch-6.2.4" && bash nix.sh import 10.132.37.39 tgz.elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.40 tgz.elasticsearch-6.2.4" && bash nix.sh import 10.132.37.40 tgz.elasticsearch-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.36 nix.kibana-6.2.4" && bash nix.sh import 10.132.37.36 nix.kibana-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.37 nix.kibana-6.2.4" && bash nix.sh import 10.132.37.37 nix.kibana-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.39 nix.kibana-6.2.4" && bash nix.sh import 10.132.37.39 nix.kibana-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.40 nix.kibana-6.2.4" && bash nix.sh import 10.132.37.40 nix.kibana-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.36 tgz.kibana-6.2.4" && bash nix.sh import 10.132.37.36 tgz.kibana-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.37 tgz.kibana-6.2.4" && bash nix.sh import 10.132.37.37 tgz.kibana-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.39 tgz.kibana-6.2.4" && bash nix.sh import 10.132.37.39 tgz.kibana-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.40 tgz.kibana-6.2.4" && bash nix.sh import 10.132.37.40 tgz.kibana-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.36 nix.logstash-6.2.4" && bash nix.sh import 10.132.37.36 nix.logstash-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.37 nix.logstash-6.2.4" && bash nix.sh import 10.132.37.37 nix.logstash-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.39 nix.logstash-6.2.4" && bash nix.sh import 10.132.37.39 nix.logstash-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.40 nix.logstash-6.2.4" && bash nix.sh import 10.132.37.40 nix.logstash-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.36 tgz.logstash-6.2.4" && bash nix.sh import 10.132.37.36 tgz.logstash-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.37 tgz.logstash-6.2.4" && bash nix.sh import 10.132.37.37 tgz.logstash-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.39 tgz.logstash-6.2.4" && bash nix.sh import 10.132.37.39 tgz.logstash-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.40 tgz.logstash-6.2.4" && bash nix.sh import 10.132.37.40 tgz.logstash-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.36 nix.filebeat-6.2.4" && bash nix.sh import 10.132.37.36 nix.filebeat-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.37 nix.filebeat-6.2.4" && bash nix.sh import 10.132.37.37 nix.filebeat-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.39 nix.filebeat-6.2.4" && bash nix.sh import 10.132.37.39 nix.filebeat-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.40 nix.filebeat-6.2.4" && bash nix.sh import 10.132.37.40 nix.filebeat-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.36 tgz.filebeat-6.2.4" && bash nix.sh import-tarball 10.132.37.36 tgz.filebeat-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.37 tgz.filebeat-6.2.4" && bash nix.sh import-tarball 10.132.37.37 tgz.filebeat-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.39 tgz.filebeat-6.2.4" && bash nix.sh import-tarball 10.132.37.39 tgz.filebeat-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.40 tgz.filebeat-6.2.4" && bash nix.sh import-tarball 10.132.37.40 tgz.filebeat-6.2.4

# install postgresql & redis [report-service]
echo -e "\n==== bash nix.sh import 10.132.37.36 nix.postgresql-10.4" && bash nix.sh import 10.132.37.36 nix.postgresql-10.4
echo -e "\n==== bash nix.sh import 10.132.37.37 nix.postgresql-10.4" && bash nix.sh import 10.132.37.37 nix.postgresql-10.4
echo -e "\n==== bash nix.sh import 10.132.37.39 nix.postgresql-10.4" && bash nix.sh import 10.132.37.39 nix.postgresql-10.4
echo -e "\n==== bash nix.sh import 10.132.37.40 nix.postgresql-10.4" && bash nix.sh import 10.132.37.40 nix.postgresql-10.4
echo -e "\n==== bash nix.sh import 10.132.37.36 nix.redis-4.0.10" && bash nix.sh import 10.132.37.36 nix.redis-4.0.10
echo -e "\n==== bash nix.sh import 10.132.37.37 nix.redis-4.0.10" && bash nix.sh import 10.132.37.37 nix.redis-4.0.10
echo -e "\n==== bash nix.sh import 10.132.37.39 nix.redis-4.0.10" && bash nix.sh import 10.132.37.39 nix.redis-4.0.10
echo -e "\n==== bash nix.sh import 10.132.37.40 nix.redis-4.0.10" && bash nix.sh import 10.132.37.40 nix.redis-4.0.10

# install zookeeper & hdfs & hbase [query-service]
echo -e "\n==== bash nix.sh import 10.132.37.36 tgz.zookeeper-3.4.12" && bash nix.sh import 10.132.37.36 tgz.zookeeper-3.4.12 
echo -e "\n==== bash nix.sh import 10.132.37.37 tgz.zookeeper-3.4.12" && bash nix.sh import 10.132.37.37 tgz.zookeeper-3.4.12 
echo -e "\n==== bash nix.sh import 10.132.37.39 tgz.zookeeper-3.4.12" && bash nix.sh import 10.132.37.39 tgz.zookeeper-3.4.12 
echo -e "\n==== bash nix.sh import 10.132.37.40 tgz.zookeeper-3.4.12" && bash nix.sh import 10.132.37.40 tgz.zookeeper-3.4.12 
echo -e "\n==== bash nix.sh import 10.132.37.36 tgz.hadoop-3.1.1" && bash nix.sh import 10.132.37.36 tgz.hadoop-3.1.1
echo -e "\n==== bash nix.sh import 10.132.37.37 tgz.hadoop-3.1.1" && bash nix.sh import 10.132.37.37 tgz.hadoop-3.1.1
echo -e "\n==== bash nix.sh import 10.132.37.39 tgz.hadoop-3.1.1" && bash nix.sh import 10.132.37.39 tgz.hadoop-3.1.1
echo -e "\n==== bash nix.sh import 10.132.37.40 tgz.hadoop-3.1.1" && bash nix.sh import 10.132.37.40 tgz.hadoop-3.1.1
echo -e "\n==== bash nix.sh import 10.132.37.36 tgz.hbase-2.1.0" && bash nix.sh import 10.132.37.36 tgz.hbase-2.1.0
echo -e "\n==== bash nix.sh import 10.132.37.37 tgz.hbase-2.1.0" && bash nix.sh import 10.132.37.37 tgz.hbase-2.1.0
echo -e "\n==== bash nix.sh import 10.132.37.39 tgz.hbase-2.1.0" && bash nix.sh import 10.132.37.39 tgz.hbase-2.1.0
echo -e "\n==== bash nix.sh import 10.132.37.40 tgz.hbase-2.1.0" && bash nix.sh import 10.132.37.40 tgz.hbase-2.1.0

# install client machine [zookeeper & kafka & filebeat & logstash & postgresql & mongodb & redis]
echo -e "\n==== bash nix.sh import 10.132.37.32 tgz.oraclejre-8u181b13" && bash nix.sh import 10.132.37.32 tgz.oraclejre-8u181b13
echo -e "\n==== bash nix.sh import 10.132.37.32 tgz.zookeeper-3.4.12" && bash nix.sh import 10.132.37.32 tgz.zookeeper-3.4.12 
echo -e "\n==== bash nix.sh import 10.132.37.32 tgz.apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.32 tgz.apache-kafka-2.12-1.1.0
echo -e "\n==== bash nix.sh import 10.132.37.32 tgz.confluent-oss-5.0.0" && bash nix.sh import 10.132.37.32 tgz.confluent-oss-5.0.0
echo -e "\n==== bash nix.sh import 10.132.37.32 tgz.filebeat-6.2.4" && bash nix.sh import 10.132.37.32 tgz.filebeat-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.32 tgz.logstash-6.2.4" && bash nix.sh import 10.132.37.32 tgz.logstash-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.32 nix.postgresql-10.4" && bash nix.sh import 10.132.37.32 nix.postgresql-10.4
echo -e "\n==== bash nix.sh import 10.132.37.32 nix.redis-4.0.10" && bash nix.sh import 10.132.37.32 nix.redis-4.0.10
