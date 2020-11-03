# Simple distributed grep action which can be executed on the cluster

HADOOP_PATH=../hadoop-3.3.0

# Copy files over to the nodes
$HADOOP_PATH/bin/hdfs dfs -mkdir input
$HADOOP_PATH/bin/hdfs dfs -put $HADOOP_PATH/etc/hadoop/*.xml input

# Run job
$HADOOP_PATH/bin/hadoop jar $HADOOP_PATH/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.2.1.jar grep input output 'dfs[a-z.]+'

# Copy output files back over
mkdir output
$HADOOP_PATH/bin/hdfs dfs -get output output
cat output/*