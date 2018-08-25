my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

echo -e "\n==== bash nix.sh start 192.168.56.101:6666 postgres-xl-10.0:gtm"
                bash nix.sh start 192.168.56.101:6666 postgres-xl-10.0:gtm
export GTM="192.168.56.101:6666"

export DATANODES="192.168.56.101:15432,192.168.56.102:15432,192.168.56.103:15432"
export COORDINATORS="192.168.56.101:5432,192.168.56.102:5432,192.168.56.103:5432"
#echo -e "\n==== bash nix.sh start 192.168.56.101:15432 postgres-xl-10.0:datanode --gtm ${GTM}"
#                bash nix.sh start 192.168.56.101:15432 postgres-xl-10.0:datanode --gtm ${GTM}
#echo -e "\n==== bash nix.sh start 192.168.56.102:15432 postgres-xl-10.0:datanode --gtm ${GTM}"
#                bash nix.sh start 192.168.56.102:15432 postgres-xl-10.0:datanode --gtm ${GTM}
#echo -e "\n==== bash nix.sh start 192.168.56.103:15432 postgres-xl-10.0:datanode --gtm ${GTM}"
#                bash nix.sh start 192.168.56.103:15432 postgres-xl-10.0:datanode --gtm ${GTM}
#echo -e "\n==== bash nix.sh start 192.168.56.101:5432 postgres-xl-10.0:coordinator --gtm ${GTM}"
#                bash nix.sh start 192.168.56.101:5432 postgres-xl-10.0:coordinator --gtm ${GTM}
#echo -e "\n==== bash nix.sh start 192.168.56.102:5432 postgres-xl-10.0:coordinator --gtm ${GTM}"
#                bash nix.sh start 192.168.56.102:5432 postgres-xl-10.0:coordinator --gtm ${GTM}
#echo -e "\n==== bash nix.sh start 192.168.56.103:5432 postgres-xl-10.0:coordinator --gtm ${GTM}"
#                bash nix.sh start 192.168.56.103:5432 postgres-xl-10.0:coordinator --gtm ${GTM}
#
#echo -e "\n==== sleep 10" && sleep 10

echo -e "\n==== bash nix.sh start 192.168.56.101:15432 postgres-xl-10.0:_connector --coordinators ${COORDINATORS} --datanodes ${DATANODES}"
                bash nix.sh start 192.168.56.101:15432 postgres-xl-10.0:_connector --coordinators ${COORDINATORS} --datanodes ${DATANODES}
echo -e "\n==== bash nix.sh start 192.168.56.102:15432 postgres-xl-10.0:_connector --coordinators ${COORDINATORS} --datanodes ${DATANODES}"
                bash nix.sh start 192.168.56.102:15432 postgres-xl-10.0:_connector --coordinators ${COORDINATORS} --datanodes ${DATANODES}
echo -e "\n==== bash nix.sh start 192.168.56.103:15432 postgres-xl-10.0:_connector --coordinators ${COORDINATORS} --datanodes ${DATANODES}"
                bash nix.sh start 192.168.56.103:15432 postgres-xl-10.0:_connector --coordinators ${COORDINATORS} --datanodes ${DATANODES}
echo -e "\n==== bash nix.sh start 192.168.56.101:5432 postgres-xl-10.0:_connector --coordinators ${COORDINATORS} --datanodes ${DATANODES}"
                bash nix.sh start 192.168.56.101:5432 postgres-xl-10.0:_connector --coordinators ${COORDINATORS} --datanodes ${DATANODES}
echo -e "\n==== bash nix.sh start 192.168.56.102:5432 postgres-xl-10.0:_connector --coordinators ${COORDINATORS} --datanodes ${DATANODES}"
                bash nix.sh start 192.168.56.102:5432 postgres-xl-10.0:_connector --coordinators ${COORDINATORS} --datanodes ${DATANODES}
echo -e "\n==== bash nix.sh start 192.168.56.103:5432 postgres-xl-10.0:_connector --coordinators ${COORDINATORS} --datanodes ${DATANODES}"
                bash nix.sh start 192.168.56.103:5432 postgres-xl-10.0:_connector --coordinators ${COORDINATORS} --datanodes ${DATANODES}

