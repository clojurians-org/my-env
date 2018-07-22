set -e 
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

_action=$1; _host=$2; _package=$3; all_opt=$4; _all=$5

_ip=$(echo $_host | cut -d: -f1)
_port=$(echo $_host | cut -d: -f2)
servers_info=$(echo $_all | awk 'BEGIN {RS=",";FS=":"} {print "server."NR"="$1":"($2+2888-2181)":"($2+3888-2181)}')
_port_tcp=$(( _port + 100 ))
export _ip _port _port_tcp _package _home servers_info

my_data=${_home}/nix.var/data/${_package}/${_port}
my_log=${_home}/nix.var/log/${_package}/${_port}
mkdir -p ${my_var} ${my_log}

cat $my/elasticsearch.yml.template | /nix/store/*gettext-0.19.8.1/bin/envsubst > ${my_data}/elasticsearch.yml

echo "====dump file content start===="
cat ${my_data}/elasticsearch.yml
echo "====dump file content end===="

cp /nix/store/*-${_package}/config/log4j2.properties ${my_data}/log4j2.properties
cp /nix/store/*-${_package}/config/jvm.options ${my_data}/jvm.options
echo "/nix/store/*${_package}*/bin/zkServer.sh ${_action} ${my_data}/zoo.cfg"
if [ "${_action}" == "start-foreground" ]; then
  echo "/nix/store/*-${_package}/bin/elasticsearch Epath.data=${my_data} -Epath.logs=${my_log}"
  /nix/store/*-${_package}/bin/elasticsearch Epath.data=${my_data} -Epath.logs=${my_log}
elif [ "${_action}" == ]; then
  echo "/nix/store/*-${_package}/bin/elasticsearch Epath.data=${my_data} -Epath.logs=${my_log} -d"
  /nix/store/*-${_package}/bin/elasticsearch Epath.data=${my_data} -Epath.logs=${my_log} -d
fi
