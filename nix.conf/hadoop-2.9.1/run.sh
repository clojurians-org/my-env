set -e; set -m
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

oraclejre_package=oraclejre-8u181b13
gettext_package=gettext-0.19.8.1

_action=$1; _host=$2; _full_package=$3
master_opt=$4; master=$5

_ip=$(echo $_host | cut -d: -f1)
_ip_id=$(echo $_ip | awk -F. '{print $4}')
_id=$(echo $_host | cut -d: -f2)
_package_parent=$(echo $_full_package | cut -d: -f1)
_package=$(echo $_full_package | cut -d: -f2)

if [ "${master_opt}" == "--master" -a "${master}" == "" ]; then
  echo "----> [ERROR] MASTER IS MISSING!"
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

if [ -e $(readlink -f /nix/store/*-${_package_parent}) ] ;then
  _package_home=$(readlink -f /nix/store/*-${_package_parent})
elif [ -e ${_home}/nix.var/data/${_package_parent} ]; then
  _package_home=$(readlink -f ${_home}/nix.var/data/${_package_parent}/*/bin/..)
else echo "--> [INFO] PLEASE IMPORT PACKAGE:[${_package_parent}] FIRST!" && exit 1
fi

mkdir -p ${_id_data}/{data,config} ${_id_log} 

export _package_home _id_data _id_log _ip _ip_id _id master
if [ "${_package}" == "namenode" ]; then
  echo "--> [${_package_parent}:${_package}] component selected!"
  cmd_name="hdfs"
  sub_cmd="namenode"
  cfg_files="core-site.xml hdfs-site.xml"
  export master=${_ip}:${_id}
elif [ "${_package}" == "datanode" ]; then
  echo "--> [${_package_parent}:${_package}] component selected!"
  cmd_name="hdfs"
  sub_cmd="datanode"
  cfg_files="core-site.xml hdfs-site.xml"
elif [ "${_package}" == "nodemanager" ]; then
  echo "NOT IMPLEMENTED!"
elif [ "${_package}" == "resourcemanager" ]; then
  echo "NOT IMPLEMENTED!"
fi

rm -rf ${_id_data}/config && mkdir -p ${_id_data}/config
for cfg_file in $cfg_files; do
  echo "====dump file content start:[$cfg_file]===="
  cat $my/${cfg_file}.template | ${envsubst_cmd} > ${_id_data}/config/${cfg_file}
  cat ${_id_data}/config/${cfg_file}
  echo "====dump file content end===="
done

if [ -e "${_home}/nix.var/data/${oraclejre_package}/jre1.8.0_181" ]; then
  export JAVA_HOME="${_home}/nix.var/data/${oraclejre_package}/jre1.8.0_181"
elif [ -e ~/.nix-profile/bin/java ]; then
  export JAVA_HOME=$(~/.nix-profile/bin/java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' | awk '{print $3}')
  echo "JAVA_HOME: $JAVA_HOME"
  export PATH=$JAVA_HOME/bin:$PATH
else
  echo "--> use path java: $(which java)"
fi

export HADOOP_PID_DIR=${_id_data}
export HADOOP_LOG_DIR=${_id_log}
if [ "${_package}" == "namenode" ]; then
  if [ ! -e ${_id_data}/data/current ]; then
    echo "--> [info] RUN namenode -format -nonInteractive"
    ${_package_home}/bin/hdfs --config ${_id_data}/config namenode -format -nonInteractive
  else
    echo "--> [info] namenode format already, reused !"
  fi
fi
if [ "${_action}" == "start-foreground" ]; then
  echo "${_package_home}/bin/${cmd_name} --config ${_id_data}/config ${sub_cmd}"
  ${_package_home}/bin/${cmd_name} --config ${_id_data}/config ${sub_cmd}
elif [ "${_action}" == "start" ]; then
  echo "${_package_home}/bin/${cmd_name} --config ${_id_data}/config ${sub_cmd}"
  nohup ${_package_home}/bin/${cmd_name} --config ${_id_data}/config ${sub_cmd} 2>&1 > ${_id_log}/logfile &
fi
