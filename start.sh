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