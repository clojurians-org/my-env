set -e; set -m
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

gettext_package=gettext-0.19.8.1

_action=$1; _host=$2; _package=$3

_ip=$(echo $_host | cut -d: -f1)
_id=$(echo $_host | cut -d: -f2)

export _home _ip _id _package kafkas cluster_id

my_data=${_home}/nix.var/data/${_package}/${_id}
my_log=${_home}/nix.var/log/${_package}/${_id}
mkdir -p ${my_data}/{data,config} ${my_log}

if [ "$(shopt -s nullglob; echo /nix/store/*-${package_name})" != "" ]; then
  envsubst_cmd="/nix/store/*-${gettext_package}/bin/envsubst"
elif [ -e "/usr/bin/envsubst" ]; then
  envsubst_cmd="/usr/bin/envsubst"
else
  echo "----> [ERROR] envsubst@gettext NOT FOUND!"
fi

my_package=/nix/store/*-${_package}
my_cmd=${my_package}/bin/pg_ctl

export PGPORT=${_id}
if [ ! -e ${my_data}/data/PG_VERSION ]; then
  echo "--> [info] init db..." 
  ${my_package}/bin/initdb -E 'UTF-8' --no-locale -D ${my_data}/data
fi

cfg_file=pg_hba.conf
cat $my/${cfg_file}.template | ${envsubst_cmd} > ${my_data}/data/${cfg_file}
echo "====dump file content start===="
cat ${my_data}/data/${cfg_file}
echo "====dump file content end===="

if [ "${_action}" == "start-foreground" ]; then
  echo "${my_package}/bin/postgres -D ${my_data}/data -k ${my_data}/data -h ${_ip} -p ${_id}"
  ${my_package}/bin/postgres -D ${my_data}/data -k  ${my_data}/data -h "${_ip}" -p "${_id}"
elif [ "${_action}" == "start" ]; then
  echo "${my_cmd} -D ${my_data}/data -l ${my_log}/logfile start '-o -h ${_ip} -p ${_id} -k /tmp'"
  ${my_cmd} -w -D ${my_data}/data -l ${my_log}/logfile start '-o -h ${_ip} -p ${_id} -k /tmp'
fi
