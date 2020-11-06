echo "Making new dirs"
$HADOOP_PATH/bin/hdfs dfs -mkdir -p /mr-history/tmp
$HADOOP_PATH/bin/hdfs dfs -mkdir -p /mr-history/done

$HADOOP_PATH/bin/hdfs dfs -mkdir /logs
$HADOOP_PATH/bin/hdfs dfs -mkdir /logs/tmp
$HADOOP_PATH/bin/hdfs dfs -mkdir /logs/done

$HADOOP_PATH/bin/hdfs dfs -mkdir /tmp
$HADOOP_PATH/bin/hdfs dfs -mkdir /tmp/logs

$HADOOP_PATH/bin/hdfs dfs -chmod 1777 /logs
$HADOOP_PATH/bin/hdfs dfs -chmod 1777 /logs/tmp
$HADOOP_PATH/bin/hdfs dfs -chmod 1777 /logs/done

$HADOOP_PATH/bin/hdfs dfs -chmod 1777 /mr-history
$HADOOP_PATH/bin/hdfs dfs -chmod 1777 /mr-history/tmp
$HADOOP_PATH/bin/hdfs dfs -chmod 1777 /mr-history/done

$HADOOP_PATH/bin/hdfs dfs -mkdir /user
$HADOOP_PATH/bin/hdfs dfs -mkdir /user/$HDFS_DATANODE_USER

# Hive folders
$HADOOP_PATH/bin/hadoop fs -mkdir /tmp
$HADOOP_PATH/bin/hadoop fs -mkdir /user/hive
$HADOOP_PATH/bin/hadoop fs -mkdir /user/hive/warehouse
$HADOOP_PATH/bin/hadoop fs -chmod g+w /tmp
$HADOOP_PATH/bin/hadoop fs -chmod g+w /user/hive
$HADOOP_PATH/bin/hadoop fs -chmod g+w /user/hive/warehouse