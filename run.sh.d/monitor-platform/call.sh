my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/..

export KAFKA_ALL="10.132.37.201:9092,10.132.37.202:9092,10.132.37.203:9092"
# export JAVA_HOME=my-env/nix.var/data/oraclejre-8u181b13/jre1.8.0_181
#========
# CLIENT
#========

# core-payment
export my_user=bohrview
ssh-copy-id -i nix.sh.out/key ${my_user}@10.129.34.250
bash nix.sh import-tarball 10.129.34.250 oraclejre-8u181b13
bash nix.sh import-tarball 10.129.34.250 apache-kafka-2.12-1.1.0
bash nix.sh import-tarball 10.129.34.250 logstash-6.2.4

bash nix.sh start 10.129.34.250:logi_cores_pts logstash-6.2.4 --kafkas $KAFKA_ALL --type file:multiline --inputs "/app/bohr/logs/Pts2/cbsd.log,/app/bohr/logs/Pts2/ccfc.log,/app/bohr/logs/Pts2/gateway.log,/app/bohr/logs/Pts2/send.log,/app/bohr/logs/Pts2/INDEX.tmp"
bash nix.sh start 10.129.34.250:logi_cores_pts_encrypt logstash-6.2.4 --kafkas $KAFKA_ALL --type file --inputs "/app/bohr/logs/Pts2/COMPRESS.tmp"

# mobile-bank
export my_user=wasadmin
ssh-copy-id -i nix.sh.out/key ${my_user}@10.128.165.149
bash nix.sh import 10.128.165.149 tgz.filebeat-6.2.4
bash nix.sh start 10.128.165.149:logi_pimp_protal filebeat-6.2.4 --kafkas $KAFKA_ALL --inputs "/was/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/portal-site/SystemOut.log" --pattern '\\['

# open-platform
bash nix.sh import 10.132.33.43 tgz.oraclejre-8u181b13
bash nix.sh import 10.132.33.43 tgz.apache-kafka-2.12-2.0.0
bash nix.sh import 10.132.33.43 tgz.logstash-6.2.4

# mcs
export my_user=wasadmin
ssh-copy-id -i nix.sh.out/key ${my_user}@10.132.33.163
bash nix.sh import 10.132.33.163 tgz.filebeat-6.2.4
bash nix.sh start 10.132.33.163:logi_mcs logstash-6.2.4 --kafkas $KAFKA_ALL --type file --inputs "/app/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/statistics/SystemOut.log"
bash nix.sh start 10.132.33.163:logi_mcs filebeat-6.2.4 --kafkas $KAFKA_ALL --inputs "/app/IBM/WebSphere/AppServer/profiles/AppSrv01/logs/statistics/SystemOut.log"

#========
# SERVER
#========
#curl -XDELETE 10.132.37.201:8083/connectors/elasticsearch_sink_LOGI_CORES_PTS_EXT

export KAFKA_CONNECT_HOST="10.132.37.201:8083"
export ES_HOST="http://10.132.37.201:9200,http://10.132.37.202:9200,http://10.132.37.203:9200"

export TABLE_NAME="logi_pimp_protal"
curl -X "POST" "http://$KAFKA_CONNECT_HOST/connectors/" \
     -H "Content-Type: application/json" \
     -d $'{
  "name": "elasticsearch_sink_'$TABLE_NAME'",
  "config": {
    "transforms":"routeTS",  
    "transforms.routeTS.type":"org.apache.kafka.connect.transforms.TimestampRouter",  
    "transforms.routeTS.topic.format":"monitor-${timestamp}",  
    "transforms.routeTS.timestamp.format":"YYYYMM",
    "name": "elasticsearch_sink_'$TABLE_NAME'",
    "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
    "tasks.max": "1",
    "topics": "'$TABLE_NAME'",
    "schema.ignore": "true",
    "key.converter": "org.apache.kafka.connect.storage.StringConverter",
    "key.ignore": "true",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter.schemas.enable": false,
    "type.name": "type.name=kafkaconnect",
    "connection.url": "'$ES_HOST'"
  }
}'
