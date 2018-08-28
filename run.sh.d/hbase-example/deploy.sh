set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

echo -e "\n==== bash nix.sh create-user 192.168.56.101" && bash nix.sh create-user 192.168.56.101
echo -e "\n==== bash nix.sh create-user 192.168.56.102" && bash nix.sh create-user 192.168.56.102
echo -e "\n==== bash nix.sh create-user 192.168.56.103" && bash nix.sh create-user 192.168.56.103

echo -e "\n==== bash nix.sh install 192.168.56.101 tgz.nix-2.0.4" && bash nix.sh install 192.168.56.101 tgz.nix-2.0.4
echo -e "\n==== bash nix.sh install 192.168.56.102 tgz.nix-2.0.4" && bash nix.sh install 192.168.56.102 tgz.nix-2.0.4
echo -e "\n==== bash nix.sh install 192.168.56.103 tgz.nix-2.0.4" && bash nix.sh install 192.168.56.103 tgz.nix-2.0.4

echo -e "\n==== bash nix.sh install 192.168.56.101 nix.rsync-3.1.3" && bash nix.sh install 192.168.56.101 nix.rsync-3.1.3
echo -e "\n==== bash nix.sh install 192.168.56.102 nix.rsync-3.1.3" && bash nix.sh install 192.168.56.102 nix.rsync-3.1.3
echo -e "\n==== bash nix.sh install 192.168.56.103 nix.rsync-3.1.3" && bash nix.sh install 192.168.56.103 nix.rsync-3.1.3

echo -e "\n==== bash nix.sh install 192.168.56.101 nix.gettext-0.19.8.1" && bash nix.sh install 192.168.56.101 nix.gettext-0.19.8.1
echo -e "\n==== bash nix.sh install 192.168.56.102 nix.gettext-0.19.8.1" && bash nix.sh install 192.168.56.102 nix.gettext-0.19.8.1
echo -e "\n==== bash nix.sh install 192.168.56.103 nix.gettext-0.19.8.1" && bash nix.sh install 192.168.56.103 nix.gettext-0.19.8.1

echo -e "\n==== bash nix.sh install 192.168.56.101 nix.openjdk-8u172b11" && bash nix.sh install 192.168.56.101 nix.openjdk-8u172b11
echo -e "\n==== bash nix.sh install 192.168.56.102 nix.openjdk-8u172b11" && bash nix.sh install 192.168.56.102 nix.openjdk-8u172b11
echo -e "\n==== bash nix.sh install 192.168.56.103 nix.openjdk-8u172b11" && bash nix.sh install 192.168.56.103 nix.openjdk-8u172b11

echo -e "\n==== bash nix.sh install 192.168.56.101 nix.zookeeper-3.4.13" && bash nix.sh install 192.168.56.101 nix.zookeeper-3.4.13
echo -e "\n==== bash nix.sh install 192.168.56.102 nix.zookeeper-3.4.13" && bash nix.sh install 192.168.56.102 nix.zookeeper-3.4.13
echo -e "\n==== bash nix.sh install 192.168.56.103 nix.zookeeper-3.4.13" && bash nix.sh install 192.168.56.103 nix.zookeeper-3.4.13

echo -e "\n==== bash nix.sh install 192.168.56.101 nix.hadoop-3.1.1" && bash nix.sh install 192.168.56.101 nix.hadoop-3.1.1
echo -e "\n==== bash nix.sh install 192.168.56.102 nix.hadoop-3.1.1" && bash nix.sh install 192.168.56.102 nix.hadoop-3.1.1
echo -e "\n==== bash nix.sh install 192.168.56.103 nix.hadoop-3.1.1" && bash nix.sh install 192.168.56.103 nix.hadoop-3.1.1

echo -e "\n==== bash nix.sh import 192.168.56.101 tgz.hbase-2.1.0" && bash nix.sh import 192.168.56.101 tgz.hbase-2.1.0
echo -e "\n==== bash nix.sh import 192.168.56.102 tgz.hbase-2.1.0" && bash nix.sh import 192.168.56.102 tgz.hbase-2.1.0
echo -e "\n==== bash nix.sh import 192.168.56.103 tgz.hbase-2.1.0" && bash nix.sh import 192.168.56.103 tgz.hbase-2.1.0
