set -e
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

# start elasticsearch-6.2.4
export ES_ALL="192.168.56.101:9200,192.168.56.102:9200,192.168.56.103:9200"
echo -e "\n==== bash nix.sh start 192.168.56.101:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor" 
                bash nix.sh start 192.168.56.101:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 192.168.56.102:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor" 
                bash nix.sh start 192.168.56.102:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor
echo -e "\n==== bash nix.sh start 192.168.56.103:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor"
                bash nix.sh start 192.168.56.103:9200 elasticsearch-6.2.4 --all ${ES_ALL} --cluster.id monitor

# start kibana-6.2.4
echo -e "\n==== bash nix.sh start 192.168.56.101:5601 kibana-6.2.4 --elasticsearchs ${ES_ALL}" && bash nix.sh start 192.168.56.101:5601 kibana-6.2.4 --elasticsearchs ${ES_ALL}
echo -e "\n==== bash nix.sh start 192.168.56.102:5601 kibana-6.2.4 --elasticsearchs ${ES_ALL}" && bash nix.sh start 192.168.56.102:5601 kibana-6.2.4 --elasticsearchs ${ES_ALL}
echo -e "\n==== bash nix.sh start 192.168.56.103:5601 kibana-6.2.4 --elasticsearchs ${ES_ALL}" && bash nix.sh start 192.168.56.103:5601 kibana-6.2.4 --elasticsearchs ${ES_ALL}

