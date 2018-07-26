set -e ; set -m ;
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

_action=$1; _host=$2; _package=$3

_ip=$(echo $_host | cut -d: -f1)
_port=$(echo $_host | cut -d: -f2)

my_data=${_home}/nix.var/data/${_package}/${_port}
mkdir -p ${my_data}
if [ -e ${my_data}/../_tarball ]; then
  my_cmd=${my_data}/../*/bin/kibana
  export JAVA_HOME=${_home}/nix.var/data/oraclejre-8u181b13/jre1.8.0_181
else
  my_cmd=/nix/store/*-${_package}/bin/kibana
fi


if [ "${_action}" == "start-foreground" ]; then
  echo "${my_cmd} -p ${_port} -H 0.0.0.0 -e http://${_ip}:9200"
  ${my_cmd} -p ${_port} -H 0.0.0.0 -e http://${_ip}:9200
elif [ "${_action}" == "start" ]; then
  echo "nohup ${my_cmd} -p ${_port} -H 0.0.0.0 -e http://${_ip}:9200 2>&1 > /dev/null &"
  nohup ${my_cmd} -p ${_port} -H 0.0.0.0 -e http://${_ip}:9200 2>&1 > /dev/null &
fi
