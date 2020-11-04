# script variables
export USER_TO_USE=ddps2018

# setup environment variables
export HDFS_NAMENODE_USER=$USER_TO_USE
export HDFS_DATANODE_USER=$USER_TO_USE
export HDFS_SECONDARYNAMENODE_USER=$USER_TO_USE
export YARN_RESOURCEMANAGER_USER=$USER_TO_USE
export YARN_NODEMANAGER_USER=$USER_TO_USE

export HADOOP_HOME=/home/$USER_TO_USE/ddps_1/hadoop-3.3.0
export HADOOP_PATH=$HADOOP_HOME