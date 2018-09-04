set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

# basic-tool 
echo -e "\n==== bash nix.sh export tgz.nix-2.0.4" && bash nix.sh export tgz.nix-2.0.4
echo -e "\n==== bash nix.sh export nix.rsync-3.1.3" && bash nix.sh export nix.rsync-3.1.3
echo -e "\n==== bash nix.sh export nix.gettext-0.19.8.1" && bash nix.sh export nix.gettext-0.19.8.1
echo -e "\n==== bash nix.sh export nix.openjdk-8u172b11" && bash nix.sh export nix.openjdk-8u172b11

# realtime-engine 
echo -e "\n==== bash nix.sh export tgz.confluent-oss-5.0.0" && bash nix.sh export tgz.confluent-oss-5.0.0

# batch-engine
echo -e "\n==== bash nix.sh build nix.postgres-xl-10.0" && bash nix.sh build nix.postgres-xl-10.0
echo -e "\n==== bash nix.sh build nix.postgres-xl-10.0" && bash nix.sh build nix.postgres-xl-10.0

# service-backend
# 1. elk
echo -e "\n==== bash nix.sh export nix.elasticsearch-6.2.4" && bash nix.sh export nix.elasticsearch-6.2.4
echo -e "\n==== bash nix.sh export nix.logstash-6.2.4" && bash nix.sh export nix.logstash-6.2.4
echo -e "\n==== bash nix.sh export nix.kibana-6.2.4" && bash nix.sh export nix.kibana-6.2.4
# 2. hbase
echo -e "\n==== bash nix.sh export nix.hadoop-2.9.1" && bash nix.sh export nix.hadoop-2.9.1
echo -e "\n==== bash nix.sh export nix.hadoop-3.1.1" && bash nix.sh export nix.hadoop-3.1.1
echo -e "\n==== bash nix.sh export tgz.hbase-2.1.0" && bash nix.sh export tgz.hbase-2.1.0
echo -e "\n==== bash nix.sh export tgz.hbase-1.2.6.1" && bash nix.sh export tgz.hbase-1.2.6.1

# client-tool
echo -e "\n==== bash nix.sh export tgz.oraclejre-8u181b13" && bash nix.sh export tgz.oraclejre-8u181b13
echo -e "\n==== bash nix.sh export tgz.logstash-6.2.4" && bash nix.sh export tgz.logstash-6.2.4
