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

echo -e "\n==== bash nix.sh install 192.168.56.101 nix.postgres-xl-10.0" && bash nix.sh install 192.168.56.101 nix.postgres-xl-10.0
echo -e "\n==== bash nix.sh install 192.168.56.102 nix.postgres-xl-10.0" && bash nix.sh install 192.168.56.102 nix.postgres-xl-10.0
echo -e "\n==== bash nix.sh install 192.168.56.103 nix.postgres-xl-10.0" && bash nix.sh install 192.168.56.103 nix.postgres-xl-10.0

