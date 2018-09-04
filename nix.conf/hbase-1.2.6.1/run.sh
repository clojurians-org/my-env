set -e; set -m
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

oraclejre_package=oraclejre-8u181b13
gettext_package=gettext-0.19.8.1

_action=$1; _host=$2; _full_package=$3
zookeepers_opt=$4; zookeepers=$5 
hdfs_master_opt=$6;  hdfs_master=$7

_ip=$(echo $_host | cut -d: -f1)
_ip_id=$(echo $_ip | awk -F. '{print $4}')
_id=$(echo $_host | cut -d: -f2)
_package_parent=$(echo $_full_package | cut -d: -f1)
_package=$(echo $_full_package | cut -d: -f2)

if [ "${zookeepers_opt}" == "--zookeepers" -a "${zookeepers}" == "--hdfs.master" ]; then
  echo "----> [ERROR] --zookeepers IS MISSING!"
  exit 1
elif [ "${hdfs_master_opt}" == "--hdfs.master" -a "${hdfs_master}" == "" ]; then
  echo "----> [ERROR] --hdfs.master IS MISSING!"
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

if [ -e ${_home}/nix.var/data/${_package_parent} ]; then
  _package_home=$(readlink -f ${_home}/nix.var/data/${_package_parent}/*/bin/..)
else
  echo "--> [INFO] PLEASE IMPORT PACKAGE:[${_package_parent}] FIRST!"
  exit 1
fi
mkdir -p ${_id_data}/{data,config} ${_id_log} 

export _package_home _id_data _id_log _ip _ip_id _id hdfs_master zookeepers
if [ "${_package}" == "master" ]; then
  echo "--> [${_package_parent}:${_package}] component selected!"
  cmd_file="hbase"
  cfg_files="hbase-site.xml"
  export master=${_ip}:${_id}
elif [ "${_package}" == "regionserver" ]; then
  echo "--> [${_package_parent}:${_package}] component selected!"
  cmd_file="hbase"
  cfg_files="hbase-site.xml"
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
  export JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' | awk '{print $3}')
fi
if [ -e ${_package_home}/../_tarball ]; then
  my_bin=${_package_home}/bin
else
  my_bin=/nix/store/*-${_package_parent}/bin
fi

if [ "${_action}" == "start-foreground" ]; then
  echo "${my_bin}/${cmd_file} --config ${_id_data}/config ${_package} start"
  ${my_bin}/${cmd_file} --config ${_id_data}/config ${_package} start
elif [ "${_action}" == "start" ]; then
  echo "${my_bin}/${cmd_file} --config ${_id_data}/config ${_package} start 2>&1 > /dev/null &"
  nohup ${my_bin}/${cmd_file} --config ${_id_data}/config ${_package} start 2>&1 > /dev/null &
fi

