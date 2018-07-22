my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/..

# create /nix and user op:op
echo -e "\n==== bash nix.sh init 192.168.56.101" && bash nix.sh init 192.168.56.101
echo -e "\n==== bash nix.sh init 192.168.56.102" && bash nix.sh init 192.168.56.102
echo -e "\n==== bash nix.sh init 192.168.56.103" && bash nix.sh init 192.168.56.103

# install nix
echo -e "\n==== bash nix.sh install 192.168.56.101" && bash nix.sh install 192.168.56.101
echo -e "\n==== bash nix.sh install 192.168.56.102" && bash nix.sh install 192.168.56.102
echo -e "\n==== bash nix.sh install 192.168.56.103" && bash nix.sh install 192.168.56.103

# install gettext for envsubst
echo -e "\n==== bash nix.sh import 192.168.56.101 gettext-0.19.8.1" && bash nix.sh import 192.168.56.101 gettext-0.19.8.1
echo -e "\n==== bash nix.sh import 192.168.56.102 gettext-0.19.8.1" && bash nix.sh import 192.168.56.102 gettext-0.19.8.1
echo -e "\n==== bash nix.sh import 192.168.56.103 gettext-0.19.8.1" && bash nix.sh import 192.168.56.103 gettext-0.19.8.1

# install zookeeper
echo -e "\n==== bash nix.sh import 192.168.56.101 zookeeper-3.4.12" && bash nix.sh import 192.168.56.101 zookeeper-3.4.12 
echo -e "\n==== bash nix.sh import 192.168.56.102 zookeeper-3.4.12" && bash nix.sh import 192.168.56.102 zookeeper-3.4.12 
echo -e "\n==== bash nix.sh import 192.168.56.103 zookeeper-3.4.12" && bash nix.sh import 192.168.56.103 zookeeper-3.4.12 

# install kafka
echo -e "\n==== bash nix.sh import 192.168.56.101 apache-kafka-2.12-1.1.0" && bash nix.sh import 192.168.56.101 apache-kafka-2.12-1.1.0
echo -e "\n==== bash nix.sh import 192.168.56.102 apache-kafka-2.12-1.1.0" && bash nix.sh import 192.168.56.102 apache-kafka-2.12-1.1.0
echo -e "\n==== bash nix.sh import 192.168.56.103 apache-kafka-2.12-1.1.0" && bash nix.sh import 192.168.56.103 apache-kafka-2.12-1.1.0

# install elasticsearch
echo -e "\n==== bash nix.sh import 192.168.56.101 elasticsearch-6.2.4" && bash nix.sh import 192.168.56.101 elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 192.168.56.102 elasticsearch-6.2.4" && bash nix.sh import 192.168.56.102 elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 192.168.56.103 elasticsearch-6.2.4" && bash nix.sh import 192.168.56.103 elasticsearch-6.2.4

# instal kibana
echo -e "\n==== bash nix.sh import 192.168.56.101 kibana-6.2.4" && bash nix.sh import 192.168.56.101 kibana-6.2.4
echo -e "\n==== bash nix.sh import 192.168.56.102 kibana-6.2.4" && bash nix.sh import 192.168.56.102 kibana-6.2.4
echo -e "\n==== bash nix.sh import 192.168.56.103 kibana-6.2.4" && bash nix.sh import 192.168.56.103 kibana-6.2.4
