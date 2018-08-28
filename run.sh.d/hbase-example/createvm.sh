set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

echo -e "\n==== bash nix.sh create-vm nixos-hbase-001" && bash nix.sh create-vm nixos-hbase-001
echo -e "\n==== bash nix.sh create-vm nixos-hbase-002" && bash nix.sh create-vm nixos-hbase-002
echo -e "\n==== bash nix.sh create-vm nixos-hbase-003" && bash nix.sh create-vm nixos-hbase-003
