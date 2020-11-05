# Simple distributed grep action which can be executed on the cluster

HADOOP_PATH=~/ddps_1/hadoop-3.3.0

# Run job
$HADOOP_PATH/bin/yarn jar $HADOOP_PATH/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar pi 16 100000000