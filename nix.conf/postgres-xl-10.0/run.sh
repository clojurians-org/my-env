set -e; set -m
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

gettext_package=gettext-0.19.8.1

_action=$1; _host=$2; _full_package=$3
gtm_opt=$4; gtm=$5
coordinators_opt=$4; coordinators=$5; datanodes_opt=$6; datanodes=$7

if [ "${coordinators_opt}" == "--coordinators" -a "${coordinators}" == "--datanodes" ]; then
  echo "----> [ERROR] --coordinators IS MISSING!"
  exit 1
elif [ "${datanodes_opt}" == "--datanodes" -a "${datanodes}" == "" ]; then
  echo "----> [ERROR] --datanodes IS MISSING!"
  exit 1
fi

if [ "${_action}" == "start-foreground" ]; then set -x; fi

_ip=$(echo $_host | cut -d: -f1)
_ip_name=$(echo $_ip | tr '.' '_')
_ip_id=$(echo $_ip | awk -F. '{print $4}')
_id=$(echo $_host | cut -d: -f2)
_package_parent=$(echo $_full_package | cut -d: -f1)
_package=$(echo $_full_package | cut -d: -f2)

gtm_ip=$(echo $gtm | cut -d: -f1)
gtm_port=$(echo $gtm | cut -d: -f2)

export _home _ip _id _package

_id_data=${_home}/nix.var/data/${_package_parent}/${_package}/${_id}
_id_log=${_home}/nix.var/log/${_package_parent}/${_package}/${_id}
mkdir -p ${_id_data}/{data,config} ${_id_log} 

if [ -e $(readlink -f /nix/store/*-${_package_parent}) ] ;then
  _package_home=$(readlink -f /nix/store/*-${_package_parent})
elif [ -e ${_home}/nix.var/data/${_package_parent} ]; then
  _package_home=$(readlink -f ${_home}/nix.var/data/${_package_parent}/*/bin/..)
else echo "--> [INFO] PLEASE IMPORT PACKAGE:[${_package_parent}] FIRST!" && exit 1
fi

if [ "$(shopt -s nullglob; echo /nix/store/*-${gettext_package})" != "" ]; then
  envsubst_cmd="/nix/store/*-${gettext_package}/bin/envsubst"
elif [ -e "/usr/bin/envsubst" ]; then
  envsubst_cmd="/usr/bin/envsubst"
else
  echo "----> [ERROR] envsubst@gettext NOT FOUND!"
fi

echo "--> [${_package_parent}:${_package}] component selected!"
if [ "${_package}" == "gtm" ]; then
  cmd_name=gtm
  cmd_opt=""
  cfg_files="pg_hba.conf"
elif [ "${_package}" == "gtm-proxy" ]; then
  echo "NOT IMPLEMENATED" && exit 1
elif [ "${_package}" == "coordinator" -o "${_package}" == "datanode" ]; then
  cmd_name="postgres"
  cmd_opts="--${_package} -c pooler_port=$(( 6667-5432+_id )) -c gtm_host=${gtm_ip} -c gtm_port=${gtm_port}"
  cfg_files="pg_hba.conf"
elif [ "${_package}" == "_connector" ]; then
  echo "----> add nodes..."
  printf $datanodes | awk 'BEGIN {RS=","} {print}' | grep -v ${_host} | \
    awk -F: '{it=$1; gsub("\\.","_",it);
      system("echo '${_package_home}'/bin/psql -p '${_id}' -c \"create node datanode_"it"_"$2" with (type=datanode,host='"'"'"$1"'"'"',port="$2")\" postgres") }'
  printf $datanodes | awk 'BEGIN {RS=","} {print}' | grep -v ${_host} | \
    awk -F: '{it=$1; gsub("\\.","_",it);
      system("'${_package_home}'/bin/psql -p '${_id}' -c \"create node datanode_"it"_"$2" with (type=datanode,host='"'"'"$1"'"'"',port="$2")\" postgres") }'

  echo "----> alter node..."
  printf $datanodes | awk 'BEGIN {RS=","} {print}' | grep ${_host} | \
    awk -F: '{it=$1; gsub("\\.","_",it);
      system("echo '${_package_home}'/bin/psql -p '${_id}' -c \"create node datanode_"it"_"$2" with (type=datanode,host='"'"'"$1"'"'"',port="$2")\" postgres") }'
  printf $datanodes | awk 'BEGIN {RS=","} {print}' | grep ${_host} | \
    awk -F: '{it=$1; gsub("\\.","_",it);
      system("'${_package_home}'/bin/psql -p '${_id}' -c \"alter node datanode_"it"_"$2" with (type=datanode,host='"'"'"$1"'"'"',port="$2")\" postgres") }'

  echo "----> connect coordinators..."
  printf $coordinators | awk 'BEGIN {RS=","} {print}' | grep -v ${_host} | \
    awk -F: '{it=$1; gsub("\\.","_",it);
      system("echo '${_package_home}'/bin/psql -p '${_id}' -c \"create node coordinator_"it"_"$2" with (type=coordinator,host='"'"'"$1"'"'"',port="$2")\" postgres") }'
  printf $coordinators | awk 'BEGIN {RS=","} {print}' | grep -v ${_host} | \
    awk -F: '{it=$1; gsub("\\.","_",it);
      system("'${_package_home}'/bin/psql -p '${_id}' -c \"create node coordinator_"it"_"$2" with (type=coordinator,host='"'"'"$1"'"'"',port="$2")\" postgres") }'

  echo "----> alter coordinators..."
  printf $coordinators | awk 'BEGIN {RS=","} {print}' | grep ${_host} | \
    awk -F: '{it=$1; gsub("\\.","_",it);
      system("echo '${_package_home}'/bin/psql -p '${_id}' -c \"alter node coordinator_"it"_"$2" with (type=coordinator,host='"'"'"$1"'"'"',port="$2")\" postgres") }'
  printf $coordinators | awk 'BEGIN {RS=","} {print}' | grep ${_host} | \
    awk -F: '{it=$1; gsub("\\.","_",it);
      system("'${_package_home}'/bin/psql -p '${_id}' -c \"alter node coordinator_"it"_"$2" with (type=coordinator,host='"'"'"$1"'"'"',port="$2")\" postgres") }'

  exit 0
fi

if [ "${_package}" == "gtm" ]; then
  if [ ! -e ${_id_data}/data/register.node ]; then
    echo "--> [info] init db=> ${_package_home}/bin/initgtm -D ${_id_data}/data" 
    ${_package_home}/bin/initgtm -D ${_id_data}/data -Z gtm
  fi
elif [ "${_package}" == "coordinator" -o "${_package}" == "datanode" ]; then
  if [ ! -e ${_id_data}/data/PG_VERSION ]; then
    echo "--> [info] init db=> ${_package_home}/bin/initdb -E 'UTF-8' --no-locale -D ${_id_data}/data --nodename ${_package}_${_ip_name}_${_id}"
    ${_package_home}/bin/initdb -E 'UTF-8' --no-locale -D ${_id_data}/data --nodename ${_package}_${_ip_name}_${_id}
  fi
fi

for cfg_file in $cfg_files; do
  echo "====dump file content start:[$cfg_file]===="
  cat $my/${cfg_file}.template | ${envsubst_cmd} > ${_id_data}/data/${cfg_file}
  cat ${_id_data}/data/${cfg_file}
  echo "====dump file content end===="
done

echo "${_package_home}/bin/${cmd_name} ${cmd_opts} -D ${_id_data}/data -h ${_ip} -p ${_id}"
if [ "${_action}" == "start-foreground" ]; then
  ${_package_home}/bin/${cmd_name} ${cmd_opts} -D ${_id_data}/data -h "${_ip}" -p "${_id}"
elif [ "${_action}" == "start" ]; then
  nohup ${_package_home}/bin/${cmd_name} ${cmd_opts} -D ${_id_data}/data -h "${_ip}" -p "${_id}"  2>&1 > ${_id_log}/logfile &
fi
