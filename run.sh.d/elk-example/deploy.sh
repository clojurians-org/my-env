my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

# create user op:op
echo -e "\n==== bash nix.sh create-user 192.168.56.101" && bash nix.sh create-user 192.168.56.101
echo -e "\n==== bash nix.sh create-user 192.168.56.102" && bash nix.sh create-user 192.168.56.102
echo -e "\n==== bash nix.sh create-user 192.168.56.103" && bash nix.sh create-user 192.168.56.103

# install nix
echo -e "\n==== bash nix.sh install 192.168.56.101" && bash nix.sh install 192.168.56.101
echo -e "\n==== bash nix.sh install 192.168.56.102" && bash nix.sh install 192.168.56.102
echo -e "\n==== bash nix.sh install 192.168.56.103" && bash nix.sh install 192.168.56.103

# install gettext for envsubst
echo -e "\n==== bash nix.sh install 192.168.56.101 nix.gettext-0.19.8.1" && bash nix.sh install 192.168.56.101 nix.gettext-0.19.8.1
echo -e "\n==== bash nix.sh install 192.168.56.102 nix.gettext-0.19.8.1" && bash nix.sh install 192.168.56.102 nix.gettext-0.19.8.1
echo -e "\n==== bash nix.sh install 192.168.56.103 nix.gettext-0.19.8.1" && bash nix.sh install 192.168.56.103 nix.gettext-0.19.8.1

# install gettext for envsubst
echo -e "\n==== bash nix.sh install 192.168.56.101 nix.openjdk-8u172b11" && bash nix.sh install 192.168.56.101 nix.openjdk-8u172b11
echo -e "\n==== bash nix.sh install 192.168.56.102 nix.openjdk-8u172b11" && bash nix.sh install 192.168.56.102 nix.openjdk-8u172b11
echo -e "\n==== bash nix.sh install 192.168.56.103 nix.openjdk-8u172b11" && bash nix.sh install 192.168.56.103 nix.openjdk-8u172b11

# install elasticsearch
echo -e "\n==== bash nix.sh import 192.168.56.101 nix.elasticsearch-6.2.4" && bash nix.sh import 192.168.56.101 nix.elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 192.168.56.102 nix.elasticsearch-6.2.4" && bash nix.sh import 192.168.56.102 nix.elasticsearch-6.2.4
echo -e "\n==== bash nix.sh import 192.168.56.103 nix.elasticsearch-6.2.4" && bash nix.sh import 192.168.56.103 nix.elasticsearch-6.2.4

# install logstash
echo -e "\n==== bash nix.sh install 192.168.56.101 nix.logstash-6.2.4" && bash nix.sh install 192.168.56.101 nix.logstash-6.2.4
echo -e "\n==== bash nix.sh install 192.168.56.102 nix.logstash-6.2.4" && bash nix.sh install 192.168.56.102 nix.logstash-6.2.4
echo -e "\n==== bash nix.sh install 192.168.56.103 nix.logstash-6.2.4" && bash nix.sh install 192.168.56.103 nix.logstash-6.2.4

# instal kibana
echo -e "\n==== bash nix.sh import 192.168.56.101 nix.kibana-6.2.4" && bash nix.sh import 192.168.56.101 nix.kibana-6.2.4
echo -e "\n==== bash nix.sh import 192.168.56.102 nix.kibana-6.2.4" && bash nix.sh import 192.168.56.102 nix.kibana-6.2.4
echo -e "\n==== bash nix.sh import 192.168.56.103 nix.kibana-6.2.4" && bash nix.sh import 192.168.56.103 nix.kibana-6.2.4
