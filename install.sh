# install.sh
# Everything that's required to initialize a node to be ready with hadoop

# Load environment variables
chmod a+x ./environmentvar.sh
. ./environmentvar.sh

# Download hadoop
# Unpack hadoop
wget -c https://apache.mirror.wearetriple.com/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz -O - | tar

# Apply patch to hadoop config files
cd hadoopconfig
cp * $HADOOP_HOME/etc/hadoop
cd ..
