# start.sh
# Starts the cluster
# Both the HDFS and the YARN cluster need to be launched
# For both clusters, the convience start scripts are used.

# Script variables

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

# Make HDFS directories on workers to execute MapReduce jobs:
echo "Making new dirs"
$HADOOP_PATH/bin/hdfs dfs -mkdir -p /mr-history/tmp
$HADOOP_PATH/bin/hdfs dfs -mkdir -p /mr-history/done

$HADOOP_PATH/bin/hdfs dfs -mkdir /logs
$HADOOP_PATH/bin/hdfs dfs -chmod 1777 /logs

$HADOOP_PATH/bin/hdfs dfs -chmod 1777 /mr-history
$HADOOP_PATH/bin/hdfs dfs -chmod 1777 /mr-history/tmp
$HADOOP_PATH/bin/hdfs dfs -chmod 1777 /mr-history/done

$HADOOP_PATH/bin/hdfs dfs -mkdir /user
$HADOOP_PATH/bin/hdfs dfs -mkdir /user/$HDFS_DATANODE_USER

# History server
echo "Starting historyserver"
$HADOOP_HOME/bin/mapred --daemon start historyserver