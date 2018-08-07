set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

echo -e "\n==== bash nix.sh export tgz.nix-2.0.4" && bash nix.sh export tgz.nix-2.0.4
echo -e "\n==== bash nix.sh export tgz.confluent-oss-5.0.0" && bash nix.sh export tgz.confluent-oss-5.0.0

echo -e "\n==== bash nix.sh export nix.gettext-0.19.8.1" && bash nix.sh export nix.gettext-0.19.8.1
echo -e "\n==== bash nix.sh export nix.openjdk-8u172b11" && bash nix.sh export nix.openjdk-8u172b11
echo -e "\n==== bash nix.sh export nix.postgresql-10.4" && bash nix.sh export nix.postgresql-10.4
