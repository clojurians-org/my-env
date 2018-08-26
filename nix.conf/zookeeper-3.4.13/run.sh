set -e 
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

_action=$1; _host=$2; _package=$3; all_opt=$4; _all=$5

_ip=$(echo $_host | cut -d: -f1)
_port=$(echo $_host | cut -d: -f2)
servers_info=$(echo $_all | awk 'BEGIN {RS=",";FS=":"} {print "server."NR"="$1":"($2+2888-2181)":"($2+3888-2181)}')
export _ip _port _package _home servers_info

mkdir -p ${_home}/nix.var/{data,log}
my_var=${_home}/nix.var/data/${_package}/${_port}
mkdir -p ${my_var}
cat $my/zoo.cfg.template | /nix/store/*gettext-0.19.8.1/bin/envsubst > ${my_var}/zoo.cfg
echo ${_all} | awk "BEGIN {RS=\",\"} /${_host}/ {print FNR}" > ${my_var}/myid

echo "====dump file content start===="
cat ${my_var}/myid
cat ${my_var}/zoo.cfg # for display on console
echo "====dump file content end===="

if [ -e ${my_var}/../_tarball ]; then
  zkServer_sh=${my_var}/../*/bin/zkServer.sh
  export JAVA_HOME=my-env/nix.var/data/oraclejre-8u181b13/jre1.8.0_181
else
  zkServer_sh=/nix/store/*-${_package}/bin/zkServer.sh
fi

echo "${zkServer_sh} ${_action} ${my_var}/zoo.cfg"
${zkServer_sh} ${_action} ${my_var}/zoo.cfg
