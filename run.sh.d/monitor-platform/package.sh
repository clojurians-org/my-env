set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

echo -e "\n==== bash nix.sh export tgz.nix-2.0.4" && bash nix.sh export tgz.nix-2.0.4
echo -e "\n==== bash nix.sh export tgz.confluent-oss-5.0.0" && bash nix.sh export tgz.confluent-oss-5.0.0
echo -e "\n==== bash nix.sh export tgz.elasticsearch-6.2.4" && bash nix.sh export tgz.elasticsearch-6.2.4
echo -e "\n==== bash nix.sh export tgz.kibana-6.2.4" && bash nix.sh export tgz.kibana-6.2.4
echo -e "\n==== bash nix.sh export tgz.logstash-6.2.4" && bash nix.sh export tgz.logstash-6.2.4
echo -e "\n==== bash nix.sh export tgz.filebeat-6.2.4" && bash nix.sh export tgz.filebeat-6.2.4

echo -e "\n==== bash nix.sh export tgz.hadoop-3.1.1" && bash nix.sh export tgz.hadoop-3.1.1
echo -e "\n==== bash nix.sh export tgz.hbase-2.1.0" && bash nix.sh export tgz.hbase-2.1.0

echo -e "\n==== bash nix.sh export nix.protobuf-3.5.1.1" && bash nix.sh export nix.protobuf-3.5.1.1
echo -e "\n==== bash nix.sh export nix.gettext-0.19.8.1" && bash nix.sh export nix.gettext-0.19.8.1
echo -e "\n==== bash nix.sh export nix.postgresql-10.4" && bash nix.sh export nix.postgresql-10.4
echo -e "\n==== bash nix.sh export nix.redis-4.0.10" && bash nix.sh export nix.redis-4.0.10


