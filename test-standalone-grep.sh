HADOOP_PATH=./hadoop-3.3.0
mkdir input
mkdir output
cp $HADOOP_PATH/etc/hadoop/*.xml input
$HADOOP_PATH/bin/hadoop jar $HADOOP_PATH/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.0.jar grep input output 'dfs[a-z.]+'