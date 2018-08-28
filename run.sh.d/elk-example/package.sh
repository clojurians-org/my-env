set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

echo -e "\n==== bash nix.sh export nix.gettext-0.19.8.1" && bash nix.sh export nix.gettext-0.19.8.1
echo -e "\n==== bash nix.sh export nix.elasticsearch-6.2.4" && bash nix.sh export nix.elasticsearch-6.2.4
nix-env --set-flag priority 0 elasticsearch-6.2.4
echo -e "\n==== bash nix.sh export nix.logstash-6.2.4" && bash nix.sh export nix.logstash-6.2.4
echo -e "\n==== bash nix.sh export nix.kibana-6.2.4" && bash nix.sh export nix.kibana-6.2.4
