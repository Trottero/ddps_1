# Setup.sh
# Creates required folders and sets up required permissions / properties

# Load in environment variables
chmod a+x environmentvar.sh
. ./environmentvar.sh

# Remove logs from previous setup
rm -R $HADOOP_HOME/logs

# Clean out data results from previous steps
rm -R /home/$USER_TO_USE/ddps_1/hadoopstorage

# Recreate working folders
mkdir /home/$USER_TO_USE/ddps_1/hadoopstorage
mkdir /home/$USER_TO_USE/ddps_1/hadoopstorage/data
mkdir /home/$USER_TO_USE/ddps_1/hadoopstorage/namenodedir

# Format the path for temp storage to set up HDFS
chmod a+x $HADOOP_PATH/bin/hdfs
$HADOOP_PATH/bin/hdfs namenode -format -nonInteractive -force

# Give permissions to HDFS temp folder
chmod -R 777 /home/$USER_TO_USE/ddps_1/hadoopstorage/namenodedir


# Make sure all of the nodes have trusted SSH access
# ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
# cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
# chmod 0600 ~/.ssh/authorized_keys