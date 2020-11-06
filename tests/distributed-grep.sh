# Simple distributed grep action which can be executed on the cluster

# Copy files over to the nodes
$HADOOP_PATH/bin/hdfs dfs -mkdir input
$HADOOP_PATH/bin/hdfs dfs -put $HADOOP_PATH/etc/hadoop/*.xml input

# Remove output folders from previous things.
$HADOOP_PATH/bin/hdfs dfs -rm -r output
rm -r ~/ddps_1/output

# Run job
$HADOOP_PATH/bin/yarn jar $HADOOP_PATH/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.1.3.jar grep input output 'dfs[a-z.]+'


# Copy output files back over
mkdir output
$HADOOP_PATH/bin/hdfs dfs -get output output