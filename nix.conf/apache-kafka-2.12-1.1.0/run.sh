set -e 
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

_action=$1; _host=$2; _package=$3; zookepers_opt=$4; zookeepers=$5; cluster_id_opt=$6; cluster_id=$7

_ip=$(echo $_host | cut -d: -f1)
_ip_4th=$(echo $_ip | cut -d. -f4)
_port=$(echo $_host | cut -d: -f2)
export _ip _ip_4th _port _package _home zookeepers cluster_id

mkdir -p ${_home}/nix.var/log/${_package}/${_port}
my_var=${_home}/nix.var/data/${_package}/${_port}
mkdir -p ${my_var}

cat ${my}/server.properties.template | /nix/store/*gettext-0.19.8.1/bin/envsubst > ${my_var}/server.properties

echo "====dump file content start===="
cat ${my_var}/server.properties
echo "====dump file content end===="

if [ -e ${my_var}/_tarball ]; then
  kafka_server_start_sh=${my_var}/*/kafka-server-start.sh
else
  kafka_server_start_sh=/nix/store/*-${_package}/bin/kafka-server-start.sh
fi
if [ "${_action}" == "start-foreground" ]; then
  echo "bash ${kafka-server-start_sh} start ${my_var}/server.properties"
  bash ${kafka_server_start_sh} ${my_var}/server.properties
elif [ "${_action}" == "start" ]; then
  echo "bash ${kafka-server-start_sh} /nix/store/*${_package}*/bin/kafka-server-start.sh -daemon start ${my_var}/server.properties"
  bash ${kafka_server_start_sh} -daemon ${my_var}/server.properties
fi
