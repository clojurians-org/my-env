set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

echo -e "\n==== bash nix.sh build nix.postgres-xl-10.0" && bash nix.sh build nix.postgres-xl-10.0

echo -e "\n==== bash nix.sh export tgz.nix-2.0.4" && bash nix.sh export tgz.nix-2.0.4
echo -e "\n==== bash nix.sh export nix.rsync-3.1.3" && bash nix.sh export nix.rsync-3.1.3
echo -e "\n==== bash nix.sh export nix.gettext-0.19.8.1" && bash nix.sh export nix.gettext-0.19.8.1
