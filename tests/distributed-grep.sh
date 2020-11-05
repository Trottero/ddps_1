# Simple distributed grep action which can be executed on the cluster

HADOOP_PATH=~/ddps_1/hadoop-3.3.0

# Copy files over to the nodes
$HADOOP_PATH/bin/hdfs dfs -mkdir input
$HADOOP_PATH/bin/hdfs dfs -put $HADOOP_PATH/etc/hadoop/*.xml input

# Remove output folders from previous things.
$HADOOP_PATH/bin/hdfs dfs -rm -r output
rm -r ~/ddps_1/output

# Run job
$HADOOP_PATH/bin/hadoop jar $HADOOP_PATH/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar grep input output 'dfs[a-z.]+'

# $HADOOP_PATH/bin/yarn jar $HADOOP_PATH/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar pi 16 10000

# Copy output files back over
mkdir output
$HADOOP_PATH/bin/hdfs dfs -get output output