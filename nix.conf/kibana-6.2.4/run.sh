set -e ; set -m ;
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

gettext_package=gettext-0.19.8.1

_action=$1; _host=$2; _package=$3
_package_parent=${_package}

_ip=$(echo $_host | cut -d: -f1)
_id=$(echo $_host | cut -d: -f2)

_id_data=${_home}/nix.var/data/${_package_parent}/${_package}/${_id}
_id_log=${_home}/nix.var/log/${_package_parent}/${_package}/${_id}


export _home _ip _id _package _id_data _id_log

if [ -e $(readlink -f /nix/store/*-${_package_parent}) ] ;then
  _package_home=$(readlink -f /nix/store/*-${_package_parent})
elif [ -e ${_home}/nix.var/data/${_package_parent} ]; then
  _package_home=$(readlink -f ${_home}/nix.var/data/${_package_parent}/*/bin/..)
else echo "--> [INFO] PLEASE IMPORT PACKAGE:[${_package_parent}] FIRST!" && exit 1
fi

rm -rf ${_id_data}/config
mkdir -p ${_id_data}/{data,config} ${_id_log}

if [ -e "${_home}/nix.var/data/${oraclejre_package}/jre1.8.0_181" ]; then
  export JAVA_HOME="${_home}/nix.var/data/${oraclejre_package}/jre1.8.0_181"
else
  echo "--> use path java: $(which java)"
  export JAVA_HOME=$(java -XshowSettings:properties -version 2>&1 > /dev/null | grep 'java.home' | awk '{print $3}')
fi

if [ "$(shopt -s nullglob; echo /nix/store/*-${gettext_package})" != "" ]; then
  envsubst_cmd="/nix/store/*-${gettext_package}/bin/envsubst"
elif [ -e "/usr/bin/envsubst" ]; then
  envsubst_cmd="/usr/bin/envsubst"
else
  echo "----> [ERROR] envsubst@gettext NOT FOUND!"
fi

cfg_files=kibana.yml
for cfg_file in $cfg_files; do
  echo "====dump file content start:[$cfg_file]===="
  cat $my/${cfg_file}.template | ${envsubst_cmd} > ${_id_data}/config/${cfg_file}
  cat ${_id_data}/config/${cfg_file}
  echo "====dump file content end===="
done

export BABEL_CACHE_PATH=$(pwd)/.babelcache.json
if [ "${_action}" == "start-foreground" ]; then
  echo "${_package_home}/bin/kibana -p ${_id} -H 0.0.0.0 -e http://${_ip}:9200 -c ${_id_data}/config/${cfg_file}"
  ${_package_home}/bin/kibana -p ${_id} -H 0.0.0.0 -e http://${_ip}:9200 -c ${_id_data}/config/${cfg_file}
elif [ "${_action}" == "start" ]; then
  echo "nohup ${_package_home}/bin/kibana -p ${_id} -H 0.0.0.0 -e http://${_ip}:9200 -c ${_id_data}/config/${cfg_file} 2>&1 > /dev/null &"
  nohup ${_package_home}/bin/kibana -p ${_id} -H 0.0.0.0 -e http://${_ip}:9200 -c ${_id_data}/config/${cfg_file} 2>&1 > /dev/null &
fi
