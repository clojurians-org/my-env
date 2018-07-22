my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/..

echo -e "\n==== bash nix.sh createvm nixos-elk-001" && bash nix.sh createvm nixos-elk-001
echo -e "\n==== bash nix.sh createvm nixos-elk-002" && bash nix.sh createvm nixos-elk-002
echo -e "\n==== bash nix.sh createvm nixos-elk-003" && bash nix.sh createvm nixos-elk-003
