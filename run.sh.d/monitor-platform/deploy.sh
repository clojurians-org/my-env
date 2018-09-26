set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

export my_user=op
#==================================
# ENV SETUP
#==================================
# prepare-network [root]
scp run.sh.d/monitor-platform/hosts root@10.132.37.221:/etc/hosts
scp run.sh.d/monitor-platform/hosts root@10.132.37.221:/etc/hosts
scp run.sh.d/monitor-platform/hosts root@10.132.37.221:/etc/hosts
ssh root@10.132.37.221 "systemctl stop firewalld"
ssh root@10.132.37.222 "systemctl stop firewalld"
ssh root@10.132.37.223 "systemctl stop firewalld"

# create-user [root]
echo -e "\n==== bash nix.sh create-user 10.132.37.201" && bash nix.sh create-user 10.132.37.201 
echo -e "\n==== bash nix.sh create-user 10.132.37.202" && bash nix.sh create-user 10.132.37.202 
echo -e "\n==== bash nix.sh create-user 10.132.37.203" && bash nix.sh create-user 10.132.37.203 

# install tgz.nix-2.0.4
echo -e "\n==== bash nix.sh install 10.132.37.201 tgz.nix-2.0.4" && bash nix.sh install 10.132.37.201 tgz.nix-2.0.4
echo -e "\n==== bash nix.sh install 10.132.37.202 tgz.nix-2.0.4" && bash nix.sh install 10.132.37.202 tgz.nix-2.0.4
echo -e "\n==== bash nix.sh install 10.132.37.203 tgz.nix-2.0.4" && bash nix.sh install 10.132.37.203 tgz.nix-2.0.4

# install nix.gettext-0.19.8.1
echo -e "\n==== bash nix.sh install 10.132.37.201 nix.gettext-0.19.8.1" && bash nix.sh install 10.132.37.201 nix.gettext-0.19.8.1
echo -e "\n==== bash nix.sh install 10.132.37.202 nix.gettext-0.19.8.1" && bash nix.sh install 10.132.37.202 nix.gettext-0.19.8.1
echo -e "\n==== bash nix.sh install 10.132.37.203 nix.gettext-0.19.8.1" && bash nix.sh install 10.132.37.203 nix.gettext-0.19.8.1

# install nix.openjdk-8u172b11
echo -e "\n==== bash nix.sh install 10.132.37.201 nix.openjdk-8u172b11" && bash nix.sh install 10.132.37.201 nix.openjdk-8u172b11
echo -e "\n==== bash nix.sh install 10.132.37.202 nix.openjdk-8u172b11" && bash nix.sh install 10.132.37.202 nix.openjdk-8u172b11
echo -e "\n==== bash nix.sh install 10.132.37.203 nix.openjdk-8u172b11" && bash nix.sh install 10.132.37.203 nix.openjdk-8u172b11

#==================================
# STREAMING ENGINE [KAFKA + KAFKA STREAMS + KSQL + KAFKA CONNECT]
#==================================
# install zookeeper & kafka & ksql [streaming-platform]
echo -e "\n==== bash nix.sh import 10.132.37.201 tgz.confluent-oss-5.0.0" && bash nix.sh import 10.132.37.201 tgz.confluent-oss-5.0.0
echo -e "\n==== bash nix.sh import 10.132.37.202 tgz.confluent-oss-5.0.0" && bash nix.sh import 10.132.37.202 tgz.confluent-oss-5.0.0
echo -e "\n==== bash nix.sh import 10.132.37.203 tgz.confluent-oss-5.0.0" && bash nix.sh import 10.132.37.203 tgz.confluent-oss-5.0.0

#==================================
# BATCH ENGINE [POSTGRES-XL + SPARK ON YARN]
#==================================
# DATA WAREHOUSE
echo -e "\n==== bash nix.sh import 10.132.37.201 nix.postgres-xl-10.0" && bash nix.sh import 10.132.37.201 nix.postgres-xl-10.0
echo -e "\n==== bash nix.sh import 10.132.37.202 nix.postgres-xl-10.0" && bash nix.sh import 10.132.37.202 nix.postgres-xl-10.0
echo -e "\n==== bash nix.sh import 10.132.37.203 nix.postgres-xl-10.0" && bash nix.sh import 10.132.37.203 nix.postgres-xl-10.0

#==================================
# SERVICE INTERFACE [ELASTICSEARCH & KIBANA + POSTGRESQL + REDIS + HBASE + AIRFLOW]
#==================================
# install elasticsearch & kibana & filebeat & logstash  [search-service]
echo -e "\n==== bash nix.sh import 10.132.37.201 nix.elasticsearch-6.2.4" && bash nix.sh import 10.132.37.201 nix.elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.202 nix.elasticsearch-6.2.4" && bash nix.sh import 10.132.37.202 nix.elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.203 nix.elasticsearch-6.2.4" && bash nix.sh import 10.132.37.203 nix.elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.201 nix.kibana-6.2.4" && bash nix.sh import 10.132.37.201 nix.kibana-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.202 nix.kibana-6.2.4" && bash nix.sh import 10.132.37.202 nix.kibana-6.2.4
echo -e "\n==== bash nix.sh import 10.132.37.203 nix.kibana-6.2.4" && bash nix.sh import 10.132.37.203 nix.kibana-6.2.4

## install postgresql & postgREST & redis [report-service]
#echo -e "\n==== bash nix.sh import 10.132.37.201 nix.postgresql-10.4" && bash nix.sh import 10.132.37.201 nix.postgresql-10.4
#echo -e "\n==== bash nix.sh import 10.132.37.202 nix.postgresql-10.4" && bash nix.sh import 10.132.37.202 nix.postgresql-10.4
#echo -e "\n==== bash nix.sh import 10.132.37.203 nix.postgresql-10.4" && bash nix.sh import 10.132.37.203 nix.postgresql-10.4
#echo -e "\n==== bash nix.sh import 10.132.37.201 nix.redis-4.0.10" && bash nix.sh import 10.132.37.201 nix.redis-4.0.10
#echo -e "\n==== bash nix.sh import 10.132.37.202 nix.redis-4.0.10" && bash nix.sh import 10.132.37.202 nix.redis-4.0.10
#echo -e "\n==== bash nix.sh import 10.132.37.203 nix.redis-4.0.10" && bash nix.sh import 10.132.37.203 nix.redis-4.0.10

# install METABASE
echo -e "\n==== bash nix.sh install 10.132.37.201 nix.metabase-0.30.0" && bash nix.sh install 10.132.37.201 nix.metabase-0.30.0
echo -e "\n==== bash nix.sh install 10.132.37.202 nix.metabase-0.30.0" && bash nix.sh install 10.132.37.202 nix.metabase-0.30.0
echo -e "\n==== bash nix.sh install 10.132.37.203 nix.metabase-0.30.0" && bash nix.sh install 10.132.37.203 nix.metabase-0.30.0

# install JOB-QUEUE & JOB-SCHEDULER
echo -e "\n==== bash nix.sh install 10.132.37.201 nix.rabbitmq-server-3.6.15" && bash nix.sh install 10.132.37.201 nix.rabbitmq-server-3.6.15
echo -e "\n==== bash nix.sh install 10.132.37.202 nix.rabbitmq-server-3.6.15" && bash nix.sh install 10.132.37.202 nix.rabbitmq-server-3.6.15
echo -e "\n==== bash nix.sh install 10.132.37.203 nix.rabbitmq-server-3.6.15" && bash nix.sh install 10.132.37.203 nix.rabbitmq-server-3.6.15

echo -e "\n==== bash nix.sh install 10.132.37.201 nix.apache-airflow-1.9.0" && bash nix.sh install 10.132.37.201 nix.apache-airflow-1.9.0
echo -e "\n==== bash nix.sh install 10.132.37.202 nix.apache-airflow-1.9.0" && bash nix.sh install 10.132.37.202 nix.apache-airflow-1.9.0
echo -e "\n==== bash nix.sh install 10.132.37.203 nix.apache-airflow-1.9.0" && bash nix.sh install 10.132.37.203 nix.apache-airflow-1.9.0

#
## install zookeeper & hdfs & hbase [query-service]
#echo -e "\n==== bash nix.sh import 10.132.37.36 tgz.zookeeper-3.4.12" && bash nix.sh import 10.132.37.36 tgz.zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.37 tgz.zookeeper-3.4.12" && bash nix.sh import 10.132.37.37 tgz.zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.39 tgz.zookeeper-3.4.12" && bash nix.sh import 10.132.37.39 tgz.zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.40 tgz.zookeeper-3.4.12" && bash nix.sh import 10.132.37.40 tgz.zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.201 nix.hadoop-3.1.1" && bash nix.sh import 10.132.37.201 nix.hadoop-3.1.1
#echo -e "\n==== bash nix.sh import 10.132.37.201 nix.hadoop-3.1.1" && bash nix.sh import 10.132.37.202 nix.hadoop-3.1.1
#echo -e "\n==== bash nix.sh import 10.132.37.203 nix.hadoop-3.1.1" && bash nix.sh import 10.132.37.203 nix.hadoop-3.1.1
echo -e "\n==== bash nix.sh import 10.132.37.201 nix.hadoop-2.9.1" && bash nix.sh import 10.132.37.201 nix.hadoop-2.9.1
echo -e "\n==== bash nix.sh import 10.132.37.201 nix.hadoop-2.9.1" && bash nix.sh import 10.132.37.202 nix.hadoop-2.9.1
echo -e "\n==== bash nix.sh import 10.132.37.203 nix.hadoop-2.9.1" && bash nix.sh import 10.132.37.203 nix.hadoop-2.9.1
echo -e "\n==== bash nix.sh import 10.132.37.201 tgz.hbase-1.2.6.1" && bash nix.sh import 10.132.37.201 tgz.hbase-1.2.6.1
echo -e "\n==== bash nix.sh import 10.132.37.202 tgz.hbase-1.2.6.1" && bash nix.sh import 10.132.37.202 tgz.hbase-1.2.6.1
echo -e "\n==== bash nix.sh import 10.132.37.203 tgz.hbase-1.2.6.1" && bash nix.sh import 10.132.37.203 tgz.hbase-1.2.6.1

#==================================
# CLIENT
#==================================
# install client machine [zookeeper & kafka & filebeat & logstash & postgresql & mongodb & redis]
#echo -e "\n==== bash nix.sh import 10.132.37.32 tgz.oraclejre-8u181b13" && bash nix.sh import 10.132.37.32 tgz.oraclejre-8u181b13
#echo -e "\n==== bash nix.sh import 10.132.37.32 tgz.zookeeper-3.4.12" && bash nix.sh import 10.132.37.32 tgz.zookeeper-3.4.12 
#echo -e "\n==== bash nix.sh import 10.132.37.32 tgz.apache-kafka-2.12-1.1.0" && bash nix.sh import 10.132.37.32 tgz.apache-kafka-2.12-1.1.0
#echo -e "\n==== bash nix.sh import 10.132.37.32 tgz.confluent-oss-5.0.0" && bash nix.sh import 10.132.37.32 tgz.confluent-oss-5.0.0
#echo -e "\n==== bash nix.sh import 10.132.37.32 tgz.filebeat-6.2.4" && bash nix.sh import 10.132.37.32 tgz.filebeat-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.32 tgz.logstash-6.2.4" && bash nix.sh import 10.132.37.32 tgz.logstash-6.2.4
#echo -e "\n==== bash nix.sh import 10.132.37.32 nix.postgresql-10.4" && bash nix.sh import 10.132.37.32 nix.postgresql-10.4
#echo -e "\n==== bash nix.sh import 10.132.37.32 nix.redis-4.0.10" && bash nix.sh import 10.132.37.32 nix.redis-4.0.10
