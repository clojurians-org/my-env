set -e; set -m
my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P)
_home=$(readlink -f "$my/../..") # my-env/nix.conf/${my}/run.sh

oraclejre_package=oraclejre-8u181b13
kafka_package=kafka_2.12-1.1.1

_action=$1; _host=$2; _package=$3; kafkas_opt=$4; kafkas=$5; type_opt=$6; type=$7; inputs_opt=$8; inputs=$9; 

_ip=$(echo $_host | cut -d: -f1)
_id=$(echo $_host | cut -d: -f2)
if [ "${type}" == "file:multiline" ]; then
  codec_info='
    codec => multiline {
      pattern => "^%{TIMESTAMP_ISO8601} "
      negate => "true"
      what => "previous"
    }'
elif [ "${type}" == "file" ]; then
  codec_info='
    codec => plain{charset=>"UTF-8"}
  '
fi
input_arr="[$(printf "$inputs" | awk 'BEGIN {RS=","} {all=all",\""$0"\""} END {print all}' | cut -c2-)]"
echo "[debug]: inputs:${inputs} => ${input_arr}"

export _home _ip _id _package kafkas input_arr codec_info

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
if [ "$(shopt -s nullglob; echo /nix/store/*-${kafka_package})" != "" ]; then
  kafka_topics_sh=/nix/store/*-${kafka_package}/bin/kafka-topics.sh
elif [ "$(shopt -s nullglob; echo ${_home}/nix.var/data/${kafka_package})" != '' ];then
  kafka_topics_sh=${_home}/nix.var/data/${kafka_package}/*/bin/kafka-topics.sh
fi

zookeeper_arg==$(echo $kafkas | sed 's/:9092/:2181/g')
partition_count=$(echo $kafkas | awk -F, '{print NF}')
echo ${kafka_topics_sh} --zookeeper $zookeeper_arg --create --replication-factor 1 --partitions ${partition_count} --topic ${_id} --if-not-exists
${kafka_topics_sh} --zookeeper $zookeeper_arg --create --replication-factor 1 --partitions ${partition_count} --topic ${_id} --if-not-exists
major_type=$(echo $type | cut -d: -f1)
cat $my/${major_type}.conf.template | ${envsubst_cmd} > ${my_data}/${major_type}.conf

echo "====dump file content start===="
cat ${my_data}/${major_type}.conf
echo "====dump file content end===="

if [ -e ${my_data}/../_tarball ]; then
  logstash_cmd=${my_data}/../*/bin/logstash
  export JAVA_HOME=${_home}/nix.var/data/${oraclejre_package}/jre1.8.0_181
else
  logstash_cmd=/nix/store/*-${_package}/bin/logstash
fi

if [ "${_action}" == "start-foreground" ]; then
  echo "${logstash_cmd} -f ${my_data}/${major_type}.conf"
  ${logstash_cmd} -f ${my_data}/${major_type}.conf
elif [ "${_action}" == "start" ]; then
  echo "nohup ${logstash_cmd} -f ${my_data}/${major_type}.conf 2>&1 > /dev/null &"
  nohup ${logstash_cmd} -f ${my_data}/${major_type}.conf 2>&1 > /dev/null &
fi
