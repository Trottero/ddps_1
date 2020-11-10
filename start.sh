# start.sh
# Starts the cluster
# Both the HDFS and the YARN cluster need to be launched
# For both clusters, the convience start scripts are used.

# Script variables

# Derby server
. ~/ddps_1/startderbyserver.sh &!

# HDFS Cluster
chmod a+x $HADOOP_PATH/sbin/start-dfs.sh
$HADOOP_PATH/sbin/start-dfs.sh

# YARN Cluster
chmod a+x $HADOOP_PATH/sbin/start-yarn.sh
$HADOOP_PATH/sbin/start-yarn.sh

# Removing old working dirs
echo "Removing old dirs"
$HADOOP_PATH/bin/hdfs dfs -rm -r /user
$HADOOP_PATH/bin/hdfs dfs -rm -r /logs
$HADOOP_PATH/bin/hdfs dfs -rm -r /mr-history
$HADOOP_PATH/bin/hdfs dfs -rm -r /tmp


# Make HDFS directories on workers to execute MapReduce jobs:
. ~/ddps_1/hdfs-folders.sh

# History server
echo "Starting historyserver"
$HADOOP_HOME/bin/mapred --daemon start historyserver

# echo "Starting hiveserver"
# $HIVE_HOME/bin/hive --service hiveserver2 --hiveconf HIVE_SERVER2_THRIFT_BIND_HOST=localhost