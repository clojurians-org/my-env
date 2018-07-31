set -e; set -m
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

oraclejre_package=oraclejre-8u181b13

_action=$1; _host=$2; _package=$3; kafkas_opt=$4; kafkas=$5; cluster_id_opt=$6; cluster_id=$7

_ip=$(echo $_host | cut -d: -f1)
_id=$(echo $_host | cut -d: -f2)

if [ "${kafkas}" == "--cluster.id" ]; then
  echo "----> [ERROR] KAFKAS IS MISSING!"
  exit 1
fi

export _home _ip _id _package kafkas cluster_id

my_data=${_home}/nix.var/data/${_package}/${_id}
my_log=${_home}/nix.var/log/${_package}/${_id}
mkdir -p ${my_data} ${my_log}

if [ "$(shopt -s nullglob; echo /nix/store/*-${package_name})" != "" ]; then
  envsubst_cmd="/nix/store/*gettext-0.19.8.1/bin/envsubst"
elif [ -e "/usr/bin/envsubst" ]; then
  envsubst_cmd="/usr/bin/envsubst"
else
  echo "----> [ERROR] envsubst@gettext NOT FOUND!"
fi

cfg_file=ksql-server.properties
cmd_file=ksql-server-start

cat $my/${cfg_file}.template | ${envsubst_cmd} > ${my_data}/${cfg_file}
echo "====dump file content start===="
cat ${my_data}/${cfg_file}
echo "====dump file content end===="

if [ -e ${my_data}/../_tarball ]; then
  export JAVA_HOME="${_home}/nix.var/data/${oraclejre_package}/jre1.8.0_181"
  my_cmd=${my_data}/../*/bin/${cmd_file}
else
  my_cmd=/nix/store/*-${_package}/bin/${cmd_file}
fi

if [ "${_action}" == "start-foreground" ]; then
  echo "${my_cmd} ${my_data}/${cfg_file}"
  ${my_cmd} ${my_data}/${cfg_file}
elif [ "${_action}" == "start" ]; then
  echo "${my_cmd} -daemon ${my_data}/${cfg_file}"
  ${my_cmd} -daemon ${my_data}/${cfg_file}
fi
