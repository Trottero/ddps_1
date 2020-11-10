# stop.sh
# Stops the cluster and clears up the processes.

# Script variables

# Stop derby server
. ~/ddps_1/stopderbyserver.sh

# Stop HDFS cluster
chmod a+x $HADOOP_PATH/sbin/stop-dfs.sh
$HADOOP_PATH/sbin/stop-dfs.sh

# Stop YARN cluster
chmod a+x $HADOOP_PATH/sbin/stop-yarn.sh
$HADOOP_PATH/sbin/stop-yarn.sh

# Stop history server
$HADOOP_HOME/bin/mapred --daemon stop historyserver