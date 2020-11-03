# Setup.sh
# Creates required folders and sets up required permissions / properties

# script variables
USER_TO_USE=mewyu

# setup environment variables
export HDFS_NAMENODE_USER=$USER_TO_USE
export HDFS_DATANODE_USER=$USER_TO_USE
export HDFS_SECONDARYNAMENODE_USER=$USER_TO_USE
export YARN_RESOURCEMANAGER_USER=$USER_TO_USE
export YARN_NODEMANAGER_USER=$USER_TO_USE

export HADOOP_PATH=./hadoop-3.3.0

# Format the path for temp storage to set up HDFS
chmod a+x $HADOOP_PATH/bin/hdfs
$HADOOP_PATH/bin/hdfs namenode -format -nonInteractive

# Give permissions to HDFS temp folder
chmod -R 777 /tmp/hadoop-$USER_TO_USE/dfs

# Make sure all of the nodes have trusted SSH access
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys