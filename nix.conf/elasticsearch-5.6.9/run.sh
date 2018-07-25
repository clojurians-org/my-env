set -e 
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

_action=$1; _host=$2; _package=$3; all_opt=$4; _all=$5; cluster_id_opt=$6; cluster_id=$7

_ip=$(echo $_host | cut -d: -f1)
_port=$(echo $_host | cut -d: -f2)
servers_info="discovery.zen.ping.unicast.hosts: [$(echo $_all | awk 'BEGIN {RS=",";FS=":"} {all=all",\""$1":"($2+9300-9200)"\""} END {print all}' | cut -c2-)]"
_port_tcp=$(( _port + 100 ))
export _ip _port _port_tcp _package _home cluster_id servers_info

my_data=${_home}/nix.var/data/${_package}/${_port}
my_log=${_home}/nix.var/log/${_package}/${_port}
mkdir -p ${my_data} ${my_log}

mkdir -p ${my_data}/{config,plugins}
cp -f /nix/store/*-${_package}/config/log4j2.properties ${my_data}/config/log4j2.properties
cp -f /nix/store/*-${_package}/config/jvm.options ${my_data}/config/jvm.options
cat $my/elasticsearch.yml.template | /nix/store/*gettext-0.19.8.1/bin/envsubst > ${my_data}/config/elasticsearch.yml

echo "====dump file content start===="
cat ${my_data}/config/elasticsearch.yml
echo "====dump file content end===="

export ES_HOME=$(compgen -G "/nix/store/*-${_package}")
export ES_PATH_CONF=${my_data}/config

if [ $(ulimit -Hn) -lt 65536 ]; then
    echo 111      
else
    ulimit -n 65536
fi
if [ "${_action}" == "start-foreground" ]; then
  echo "/nix/store/*-${_package}/bin/elasticsearch -Epath.data=${my_data} -Epath.conf=$ES_PATH_CONF -Epath.logs=${my_log}"
  /nix/store/*-${_package}/bin/elasticsearch -Epath.conf=$ES_PATH_CONF -Epath.data=${my_data} -Epath.logs=${my_log}
elif [ "${_action}" == "start" ]; then
  echo "/nix/store/*-${_package}/bin/elasticsearch -Epath.data=${my_data} -Epath.conf=$ES_PATH_CONF -Epath.logs=${my_log} -d"
  /nix/store/*-${_package}/bin/elasticsearch -Epath.conf=$ES_PATH_CONF -Epath.data=${my_data} -Epath.logs=${my_log} -d
fi
