my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my

# mkdir /nix
echo -e "\n==== sh nix.sh mkdir 10.132.37.33" && sh nix.sh mkdir 10.132.37.33 
echo -e "\n==== sh nix.sh mkdir 10.132.37.34" && sh nix.sh mkdir 10.132.37.34 
echo -e "\n==== sh nix.sh mkdir 10.132.37.35" && sh nix.sh mkdir 10.132.37.35 
echo -e "\n==== sh nix.sh mkdir 10.132.37.36" && sh nix.sh mkdir 10.132.37.36 
echo -e "\n==== sh nix.sh mkdir 10.132.37.37" && sh nix.sh mkdir 10.132.37.37 
echo -e "\n==== sh nix.sh mkdir 10.132.37.39" && sh nix.sh mkdir 10.132.37.39

# install nix
echo -e "\n==== nix.sh install 10.132.37.33" && sh nix.sh install 10.132.37.33
echo -e "\n==== nix.sh install 10.132.37.34" && sh nix.sh install 10.132.37.34
echo -e "\n==== nix.sh install 10.132.37.35" && sh nix.sh install 10.132.37.35
echo -e "\n==== nix.sh install 10.132.37.36" && sh nix.sh install 10.132.37.36
echo -e "\n==== nix.sh install 10.132.37.37" && sh nix.sh install 10.132.37.37
echo -e "\n==== nix.sh install 10.132.37.39" && sh nix.sh install 10.132.37.39

# install zookeeper-3.4.12 [nix-env -i zookeeper-3.4.12]
echo -e "\n==== sh nix.sh export zookeeper-3.4.12" && sh nix.sh export zookeeper-3.4.12
echo -e "\n==== sh nix.sh import 10.132.37.33 zookeeper-3.4.12" && sh nix.sh import 10.132.37.33 zookeeper-3.4.12 
echo -e "\n==== sh nix.sh import 10.132.37.34 zookeeper-3.4.12" && sh nix.sh import 10.132.37.34 zookeeper-3.4.12 
echo -e "\n==== sh nix.sh import 10.132.37.35 zookeeper-3.4.12" && sh nix.sh import 10.132.37.35 zookeeper-3.4.12 

# install apache-kafka-2.12-1.1.0 [nix-env -i apache-kafka-2.12-1.1.0]
echo -e "\n==== sh nix.sh export apache-kafka-2.12-1.1.0" && sh nix.sh export apache-kafka-2.12-1.1.0
echo -e "\n==== sh nix.sh import 10.132.37.33 apache-kafka-2.12-1.1.0" && sh nix.sh import 10.132.37.33 apache-kafka-2.12-1.1.0
echo -e "\n==== sh nix.sh import 10.132.37.34 apache-kafka-2.12-1.1.0" && sh nix.sh import 10.132.37.34 apache-kafka-2.12-1.1.0
echo -e "\n==== sh nix.sh import 10.132.37.35 apache-kafka-2.12-1.1.0" && sh nix.sh import 10.132.37.35 apache-kafka-2.12-1.1.0

# install export elasticsearch-6.2.4 [nix-env -i elasticsearch-6.2.4]
echo -e "\n==== sh nix.sh export elasticsearch-6.2.4" && sh nix.sh export elasticsearch-6.2.4
echo -e "\n==== sh nix.sh import 10.132.37.36 elasticsearch-6.2.4" && sh nix.sh import 10.132.37.36 elasticsearch-6.2.4
echo -e "\n==== sh nix.sh import 10.132.37.37 elasticsearch-6.2.4" && sh nix.sh import 10.132.37.37 elasticsearch-6.2.4
echo -e "\n==== sh nix.sh import 10.132.37.39 elasticsearch-6.2.4" && sh nix.sh import 10.132.37.39 elasticsearch-6.2.4

# install logstash-6.2.4 [nix-env -i logstash-6.2.4]
echo -e "\n==== sh nix.sh export log-6.2.4" && sh nix.sh export logstash-6.2.4
echo -e "\n==== sh nix.sh import 10.132.37.36 logstash-6.2.4" && sh nix.sh import 10.132.37.36 logstash-6.2.4

# install kibana-6.4.2 [nix-env -i kibana-6.4.2]
echo -e "\n==== sh nix.sh export kibana-6.2.4" && sh nix.sh export kibana-6.2.4
echo -e "\n==== sh nix.sh import 10.132.37.36 kibana-6.2.4" && sh nix.sh import 10.132.37.36 kibana-6.2.4
