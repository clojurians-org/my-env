set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/..

echo -e "\n==== bash nix.sh download" && bash nix.sh download
echo -e "\n==== bash nix.sh export gettext-0.19.8.1" && bash nix.sh export gettext-0.19.8.1
echo -e "\n==== bash nix.sh export zookeeper-3.4.12" && bash nix.sh export zookeeper-3.4.12
echo -e "\n==== bash nix.sh export apache-kafka-2.12-1.1.0" && bash nix.sh export apache-kafka-2.12-1.1.0
echo -e "\n==== bash nix.sh export elasticsearch-6.2.4" && bash nix.sh export elasticsearch-6.2.4
echo -e "\n==== bash nix.sh export kibana-6.2.4" && bash nix.sh export kibana-6.2.4
