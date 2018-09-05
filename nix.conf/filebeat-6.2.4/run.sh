set -e; set -m
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

gettext_package=gettext-0.19.8.1

_action=$1; _host=$2; _package=$3; kafkas_opt=$4; kafkas=$5; input_opt=$6; inputs=$7; pattern_opt=$8; pattern=$9

_package_parent=$_package
_ip=$(echo $_host | cut -d: -f1)
_id=$(echo $_host | cut -d: -f2)

if [ "${kafkas}" == "--inputs" ]; then
  echo "----> [ERROR] KAFKAS IS MISSING!"
  exit 1
fi

path_arr="[$(printf "$inputs" | awk 'BEGIN {RS=","} {all=all",\""$0"\""} END {print all}' | cut -c2-)]"
host_arr="[$(printf "$kafkas" | awk 'BEGIN {RS=","} {all=all",\""$0"\""} END {print all}' | cut -c2-)]"

_id_data=${_home}/nix.var/data/${_package_parent}/${_package}/${_id}
_id_log=${_home}/nix.var/log/${_package_parent}/${_package}/${_id}

nix_package=$(shopt -s nullglob; echo /nix/store/*-${_package_parent}-bin)
echo "NIX_PACKAGES: $nix_package"
if [ "${nix_package}" != "" ] ;then
  _package_home=${nix_package}
elif [ -e ${_home}/nix.var/data/${_package_parent} ]; then
  _package_home=$(readlink -f ${_home}/nix.var/data/${_package_parent}/*/filebeat | xargs dirname)
  mkdir -p $_package_home/bin
  if [ ! -e $_package_home/bin/filebeat ]; then
    ln -s $_package_home/filebeat $_package_home/bin/filebeat
  fi
else echo "--> [INFO] PLEASE IMPORT PACKAGE:[${_package_parent}] FIRST!" && exit 1
fi
echo "--> [INFO] PACKAGE_HOME: ${_package_home}"

mkdir -p ${_id_data}/{data,config} ${_id_log}

if [ "$(shopt -s nullglob; echo /nix/store/*-${gettext_package})" != "" ]; then
  envsubst_cmd="/nix/store/*-${gettext_package}/bin/envsubst"
elif [ -e "/usr/bin/envsubst" ]; then
  envsubst_cmd="/usr/bin/envsubst"
else
  echo "----> [ERROR] envsubst@gettext NOT FOUND!"
fi

rm -rf ${_id_data}/config && mkdir -p ${_id_data}/config
cfg_files=filebeat.yml
export _home _ip _id _package path_arr host_arr pattern
for cfg_file in $cfg_files; do
  echo "====dump file content start:[$cfg_file]===="
  cat $my/${cfg_file}.template | ${envsubst_cmd} > ${_id_data}/config/${cfg_file}
  cat ${_id_data}/config/${cfg_file}
  echo "====dump file content end===="
done

chmod 600 ${_id_data}/config/filebeat.yml

if [ "${_action}" == "start-foreground" ]; then
  echo "${_package_home}/bin/filebeat --path.config ${_id_data}/config --path.data ${_id_data}/data --path.logs ${_id_log}"
  ${_package_home}/bin/filebeat --path.config ${_id_data}/config --path.data ${_id_data}/data --path.logs ${_id_log}
elif [ "${_action}" == "start" ]; then
  echo "${_package_home}/bin/filebeat --path.config ${_id_data}/config --path.data ${_id_data}/data --path.logs ${_id_log}"
  nohup ${_package_home}/bin/filebeat --path.config ${_id_data}/config --path.data ${_id_data}/data --path.logs ${_id_log} 2>&1 > /dev/null &
fi
