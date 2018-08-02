set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

echo -e "\n==== bash nix.sh setup" && bash nix.sh setup
echo -e "\n==== bash nix.sh export gettext-0.19.8.1" && bash nix.sh export gettext-0.19.8.1
echo -e "\n==== bash nix.sh export-tarball zookeeper-3.4.12" && bash nix.sh export-tarball zookeeper-3.4.12
echo -e "\n==== bash nix.sh export-tarball apache-kafka-2.12-1.1.0" && bash nix.sh export-tarball apache-kafka-2.12-1.1.0
echo -e "\n==== bash nix.sh export-tarball ksql-5.0.5" && bash nix.sh export-tarball ksql-5.0.0
echo -e "\n==== bash nix.sh export-tarball confluent-oss-5.0.0" && bash nix.sh export-tarball confluent-oss-5.0.0

echo -e "\n==== bash nix.sh export-tarball elasticsearch-6.2.4" && bash nix.sh export-tarball elasticsearch-6.2.4
echo -e "\n==== bash nix.sh export-tarball kibana-6.2.4" && bash nix.sh export-tarball kibana-6.2.4
echo -e "\n==== bash nix.sh export-tarball logstash-6.2.4" && bash nix.sh export-tarball logstash-6.2.4
echo -e "\n==== bash nix.sh export-tarball filebeat-6.2.4" && bash nix.sh export-tarball filebeat-6.2.4

echo -e "\n==== bash nix.sh export postgresql-10.4" && bash nix.sh export postgresql-10.4
echo -e "\n==== bash nix.sh export redis-4.0.10" && bash nix.sh export redis-4.0.10
