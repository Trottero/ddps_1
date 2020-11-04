# install.sh
# Everything that's required to initialize a node to be ready with hadoop

cd ddps_1

# Load environment variables
chmod a+x ./environmentvar.sh
. ./environmentvar.sh

# Download hadoop
curl -o /home/$USER_TO_USE/ddps_1/hadoop.tar.gz https://apache.mirror.wearetriple.com/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz

# Unpack hadoop
tar -xzf hadoop.tar.gz

# Apply patch to hadoop config files
cd ./hadoopconfig
cp * $HADOOP_HOME/etc/hadoop
cd ..
