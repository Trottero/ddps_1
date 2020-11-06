# Setup.sh
# Creates required folders and sets up required permissions / properties

# Load in environment variables
chmod a+x environmentvar.sh
. ./environmentvar.sh

# Give permissions to hive executable
chmod a+x $HIVE_HOME/bin/hive
chmod a+x $HADOOP_HOME/bin/mapred
chmod a+x $HADOOP_HOME/bin/yarn
chmod a+x $HADOOP_HOME/bin/hdfs

# Remove logs from previous setup
rm -R $HADOOP_HOME/logs

# Clean out data results from previous steps
# rm -R /home/$USER_TO_USE/ddps_1/hadoopstorage

# Delete the old namenode folder
rm -R /tmp/hadoop-$USER_TO_USE/


# Format the path for temp storage to set up HDFS
chmod a+x $HADOOP_PATH/bin/hdfs
$HADOOP_PATH/bin/hdfs namenode -format -nonInteractive -force

# Give permissions to HDFS temp folder
chmod -R 777 /home/$USER_TO_USE/ddps_1/hadoopstorage/namenodedir

# Make sure all of the nodes have trusted SSH access
# ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
# cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
# chmod 0600 ~/.ssh/authorized_keys