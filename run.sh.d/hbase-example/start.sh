my=$(cd -P -- "$(dirname -- "${BASH_SOURCE-$0}")" > /dev/null && pwd -P) && cd $my/../..

# start zookeeper
export ZK_ALL="192.168.56.101:2181,192.168.56.102:2181,192.168.56.103:2181"
# start zookeeper-3.4.12
echo -e "\n==== bash nix.sh start 192.168.56.101:2181 zookeeper-3.4.13 --all ${ZK_ALL}" && bash nix.sh start 192.168.56.101:2181 zookeeper-3.4.13 --all ${ZK_ALL}
echo -e "\n==== bash nix.sh start 192.168.56.102:2181 zookeeper-3.4.13 --all ${ZK_ALL}" && bash nix.sh start 192.168.56.102:2181 zookeeper-3.4.13 --all ${ZK_ALL}
echo -e "\n==== bash nix.sh start 192.168.56.103:2181 zookeeper-3.4.13 --all ${ZK_ALL}" && bash nix.sh start 192.168.56.103:2181 zookeeper-3.4.13 --all ${ZK_ALL}

# start hadoop-3.1.1
echo -e "\n==== bash nix.sh start 192.168.56.101:9000 hadoop-3.1.1:namenode" && bash nix.sh start 192.168.56.101:9000 hadoop-3.1.1:namenode
export HDFS_MASTER="192.168.56.101:9000"

echo -e "\n==== bash nix.sh start 192.168.56.101:5200 hadoop-3.1.1:datanode" && bash nix.sh start 192.168.56.101:5200 hadoop-3.1.1:datanode --master ${HDFS_MASTER}
echo -e "\n==== bash nix.sh start 192.168.56.102:5200 hadoop-3.1.1:datanode" && bash nix.sh start 192.168.56.102:5200 hadoop-3.1.1:datanode --master ${HDFS_MASTER}
echo -e "\n==== bash nix.sh start 192.168.56.103:5200 hadoop-3.1.1:datanode" && bash nix.sh start 192.168.56.103:5200 hadoop-3.1.1:datanode --master ${HDFS_MASTER}

# start hbase-2.1.0
echo -e "\n==== bash nix.sh start 192.168.56.101:16010 hbase-2.1.0:master --zookeepers ${ZK_ALL} --hdfs.master ${HDFS_MASTER}"
                bash nix.sh start 192.168.56.101:16010 hbase-2.1.0:master --zookeepers ${ZK_ALL} --hdfs.master ${HDFS_MASTER}

echo -e "\n==== bash nix.sh start 192.168.56.101:16030 hbase-2.1.0:regionserver --zookeepers ${ZK_ALL} --hdfs.master ${HDFS_MASTER}"
                bash nix.sh start 192.168.56.101:16030 hbase-2.1.0:regionserver --zookeepers ${ZK_ALL} --hdfs.master ${HDFS_MASTER}
echo -e "\n==== bash nix.sh start 192.168.56.102:16030 hbase-2.1.0:regionserver --zookeepers ${ZK_ALL} --hdfs.master ${HDFS_MASTER}"
                bash nix.sh start 192.168.56.102:16030 hbase-2.1.0:regionserver --zookeepers ${ZK_ALL} --hdfs.master ${HDFS_MASTER}
echo -e "\n==== bash nix.sh start 192.168.56.103:16030 hbase-2.1.0:regionserver --zookeepers ${ZK_ALL} --hdfs.master ${HDFS_MASTER}"
                bash nix.sh start 192.168.56.103:16030 hbase-2.1.0:regionserver --zookeepers ${ZK_ALL} --hdfs.master ${HDFS_MASTER}

