set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

echo -e "\n==== bash nix.sh build tgz.hbase-2.1.0" && bash nix.sh build tgz.hbase-2.1.0

echo -e "\n==== bash nix.sh export tgz.nix-2.0.4" && bash nix.sh export tgz.nix-2.0.4
echo -e "\n==== bash nix.sh export nix.rsync-3.1.3" && bash nix.sh export nix.rsync-3.1.3
echo -e "\n==== bash nix.sh export nix.gettext-0.19.8.1" && bash nix.sh export nix.gettext-0.19.8.1

echo -e "\n==== bash nix.sh export nix.openjdk-8u172b11" && bash nix.sh export nix.openjdk-8u172b11
echo -e "\n==== bash nix.sh export nix.zookeeper-3.4.13" && bash nix.sh export nix.zookeeper-3.4.13
echo -e "\n==== bash nix.sh export nix.hadoop-3.1.1" && bash nix.sh export nix.hadoop-3.1.1
