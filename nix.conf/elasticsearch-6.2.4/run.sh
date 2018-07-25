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


if [ -e ${my_data}/../_tarball ]; then
  elasticsearch_cmd=${my_data}/../*/bin/elasticsearch
  export JAVA_HOME=${_home}/nix.var/data/oraclejre-8u181b13/jre1.8.0_181
else
  elasticsearch_cmd=/nix/store/*-${_package}/bin/elasticsearch
fi


if [ "${_action}" == "start-foreground" ]; then
  # echo "${elasticsearch_cmd} -Epath.data=${my_data} -Epath.logs=${my_log}"
  start_elasticsearch_cmd="${elasticsearch_cmd} -Epath.data=${my_data} -Epath.logs=${my_log}"
elif [ "${_action}" == "start" ]; then
  # echo "${elasticsearch_cmd} -Epath.data=${my_data} -Epath.logs=${my_log} -d"
  start_elasticsearch_cmd="${elasticsearch_cmd} -Epath.data=${my_data} -Epath.logs=${my_log} -d"
fi

if [ $(ulimit -Hn) -lt 65536 ]; then
    echo "--> [ulimit] value is too low: $(ulimit -Hn), use su root[$USER] commmand to  run"
    su - root -c "ulimit -n 65536 && sysctl -w vm.max_map_count=262144 && su - ${USER} -c '
      ulimit -u 4096
      export ES_HOME=${ES_HOME}
      export ES_PATH_CONF=${ES_PATH_CONF}
      echo ${start_elasticsearch_cmd}
      ${start_elasticsearch_cmd}
    '"
else
    echo ${start_elasticsearch_cmd}
    ${start_elasticsearch_cmd}
fi
