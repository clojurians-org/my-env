set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

export my_user=op
echo -e "\n==== bash nix.sh create-user 192.168.56.101" && bash nix.sh create-user 192.168.56.101
echo -e "\n==== bash nix.sh create-user 192.168.56.102" && bash nix.sh create-user 192.168.56.102
echo -e "\n==== bash nix.sh create-user 192.168.56.103" && bash nix.sh create-user 192.168.56.103

echo -e "\n==== bash nix.sh import-nix 192.168.56.101 tgz.nix-2.0.4" && bash nix.sh import-nix 192.168.56.101 tgz.nix-2.0.4
echo -e "\n==== bash nix.sh import-nix 192.168.56.102 tgz.nix-2.0.4" && bash nix.sh import-nix 192.168.56.102 tgz.nix-2.0.4
echo -e "\n==== bash nix.sh import-nix 192.168.56.103 tgz.nix-2.0.4" && bash nix.sh import-nix 192.168.56.103 tgz.nix-2.0.4

echo -e "\n==== bash nix.sh import 192.168.56.101 tgz.confluent-oss-5.0.0" && bash nix.sh import 192.168.56.101 tgz.confluent-oss-5.0.0
echo -e "\n==== bash nix.sh import 192.168.56.102 tgz.confluent-oss-5.0.0" && bash nix.sh import 192.168.56.102 tgz.confluent-oss-5.0.0
echo -e "\n==== bash nix.sh import 192.168.56.103 tgz.confluent-oss-5.0.0" && bash nix.sh import 192.168.56.103 tgz.confluent-oss-5.0.0

export my_user=root
echo -e "\n==== bash nix.sh import 192.168.56.101 gettext-0.19.8.1" && bash nix.sh import 192.168.56.101 nix.gettext-0.19.8.1
echo -e "\n==== bash nix.sh import 192.168.56.102 gettext-0.19.8.1" && bash nix.sh import 192.168.56.102 nix.gettext-0.19.8.1
echo -e "\n==== bash nix.sh import 192.168.56.103 gettext-0.19.8.1" && bash nix.sh import 192.168.56.103 nix.gettext-0.19.8.1

echo -e "\n==== bash nix.sh import 192.168.56.101 openjdk-8u172b11" && bash nix.sh import 192.168.56.101 nix.openjdk-8u172b11
echo -e "\n==== bash nix.sh import 192.168.56.102 openjdk-8u172b11" && bash nix.sh import 192.168.56.102 nix.openjdk-8u172b11
echo -e "\n==== bash nix.sh import 192.168.56.103 openjdk-8u172b11" && bash nix.sh import 192.168.56.103 nix.openjdk-8u172b11
