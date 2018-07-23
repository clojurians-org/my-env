set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

echo -e "\n==== bash nix.sh export gettext-0.19.8.1" && bash nix.sh export gettext-0.19.8.1
echo -e "\n==== bash nix.sh export openjdk-8u172b11" && bash nix.sh export openjdk-8u172b11
echo -e "\n==== bash nix.sh export zookeeper-3.4.11" && bash nix.sh export zookeeper-3.4.11
echo -e "\n==== bash nix.sh export zookeeper-3.4.12" && bash nix.sh export zookeeper-3.4.12
echo -e "\n==== bash nix.sh export apache-kafka-2.11-0.9.0.1" && bash nix.sh export apache-kafka-2.11-0.9.0.1
echo -e "\n==== bash nix.sh export apache-kafka-2.12-1.1.0" && bash nix.sh export apache-kafka-2.12-1.1.0
echo -e "\n==== bash nix.sh export elasticsearch-6.2.4" && bash nix.sh export elasticsearch-6.2.4
echo -e "\n==== bash nix.sh export filebeat-6.2.4" && bash nix.sh export filebeat-6.2.4
echo -e "\n==== bash nix.sh export logstash-2.4.0" && bash nix.sh export logstash-2.4.0
echo -e "\n==== bash nix.sh export logstash-6.2.4" && bash nix.sh export logstash-6.2.4
echo -e "\n==== bash nix.sh export kibana-6.2.4" && bash nix.sh export kibana-6.2.4
echo -e "\n==== bash nix.sh export mongodb-3.4.10" && bash nix.sh export mongodb-3.4.10
echo -e "\n==== bash nix.sh export postgresql-10.3" && bash nix.sh export postgresql-10.3
echo -e "\n==== bash nix.sh export redis-4.0.10" && bash nix.sh export redis-4.0.10
