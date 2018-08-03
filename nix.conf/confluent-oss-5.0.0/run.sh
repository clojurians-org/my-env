set -e; set -m
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

oraclejre_package=oraclejre-8u181b13
gettext_package=gettext-0.19.8.1

_action=$1; _host=$2; _full_package=$3
all_opt=$4; all=$5; zookeepers_opt=$4; zookeepers=$5; kafkas_opt=$4; kafkas=$5; 
cluster_id_opt=$6; cluster_id=$7

_ip=$(echo $_host | cut -d: -f1)
_ip_id=$(echo $_ip | awk -F. '{print $4}')
_id=$(echo $_host | cut -d: -f2)
_package_parent=$(echo $_full_package | cut -d: -f1)
_package=$(echo $_full_package | cut -d: -f2)

if [ "${kafkas}" == "--cluster.id" ]; then
  echo "----> [ERROR] KAFKAS IS MISSING!"
  exit 1
fi

if [ "$(shopt -s nullglob; echo /nix/store/*-${gettext_package})" != "" ]; then
  envsubst_cmd="/nix/store/*-${gettext_package}/bin/envsubst"
elif [ -e "/usr/bin/envsubst" ]; then
  envsubst_cmd="/usr/bin/envsubst"
else
  echo "----> [ERROR] envsubst@gettext NOT FOUND!"
fi

_id_data=${_home}/nix.var/data/${_package_parent}/${_package}/${_id}
_id_log=${_home}/nix.var/log/${_package_parent}/${_package}/${_id}
_package_home=$(readlink -f ${_home}/nix.var/data/${_package_parent}/*/bin/..)
mkdir -p ${_id_data}/{data,config} ${_id_log} 

export _package_home _id_data _id_log _ip _ip_id _id zookeepers kafkas cluster_id

if [ "${_package}" == "zookeeper" ]; then
  echo "--> [confluent-oss-5.0.0:zookeeper] component selected!"
  cmd_file=zookeeper-server-start
  cfg_file=zoo.cfg
  export servers_info=$(echo $all | awk 'BEGIN {RS=",";FS=":"} {print "server."NR"="$1":"($2+2888-2181)":"($2+3888-2181)}')
  echo ${all} | awk "BEGIN {RS=\",\"} /${_host}/ {print FNR}" > ${_id_data}/data/myid
  echo "${_id_data}/data/myid:$(cat ${_id_data}/data/myid)" 
elif [ "${_package}" == "kafka" ]; then
  echo "--> [confluent-oss-5.0.0:kafka] component selected!"
  cmd_file=kafka-server-start
  cfg_file=server.properties
  export zookeeper_connect=$(printf $zookeepers | awk -v cluster_id="$cluster_id" 'BEGIN {RS=","} {all=all","$0"/"cluster_id} END {print all}' | cut -c2-)
elif [ "${_package}" == "ksql" ]; then
  cmd_file=ksql-server-start
  cfg_file=ksql-server.properties
elif [ "${_package}" == "schema-registry" ]; then
  cmd_file=schema-registry-start
  cfg_file=schema-registry.properties
  export protocol_kafkas="$(printf "$kafkas" | awk 'BEGIN {RS=","} {all=all",PLAINTEXT://"$0} END {print all}' | cut -c2-)"
elif [ "${_package}" == "kafka-connect" ]; then
  cmd_file=connect-distributed
  cfg_file=connect-distributed.properties
fi

cat $my/${cfg_file}.template | ${envsubst_cmd} > ${_id_data}/config/${cfg_file}
echo "====dump file content start===="
cat ${_id_data}/config/${cfg_file}
echo "====dump file content end===="

if [ -e ${_package_home}/../_tarball ]; then
  export JAVA_HOME="${_home}/nix.var/data/${oraclejre_package}/jre1.8.0_181"
  my_cmd=${_package_home}/bin/${cmd_file}
else
  my_cmd=/nix/store/*-${_package_parent}/bin/${cmd_file}
fi

if [ "${_action}" == "start-foreground" ]; then
  echo "${my_cmd} ${_id_data}/config/${cfg_file}"
  ${my_cmd} ${_id_data}/config/${cfg_file}
elif [ "${_action}" == "start" ]; then
  echo "${my_cmd} -daemon ${_id_data}/config/${cfg_file}"
  ${my_cmd} -daemon ${_id_data}/config/${cfg_file}
fi

