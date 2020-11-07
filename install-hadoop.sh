# install.sh
# Everything that's required to initialize a node to be ready with hadoop

# Allow execution of all of the scripting files
chmod a+x ~/ddps_1/environmentvar.sh
chmod a+x ~/ddps_1/add-to-path.sh
chmod a+x ~/ddps_1/reload-configs.sh
chmod a+x ~/ddps_1/report.sh
chmod a+x ~/ddps_1/setup.sh
chmod a+x ~/ddps_1/start.sh
chmod a+x ~/ddps_1/stop.sh
chmod a+x ~/ddps_1/tests/distributed-grep.sh
chmod a+x ~/ddps_1/hdfs-folders.sh

# Load environment variables
. ~/ddps_1/environmentvar.sh

# Add hadoop / yarn / mapred to path 
. ~/ddps_1/add-to-path.sh

# Remove old install dirs.
rm -r ~/ddps_1/hadoop-3.3.0
rm -r ~/ddps_1/apache-hive-3.1.2-bin


echo "Downloading Hadoop"
# Download hadoop
curl -o ~/ddps_1/hadoop.tar.gz https://ftp.nluug.nl/internet/apache/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz

echo "Unpacking hadoop"
# Unpack hadoop
mkdir ~/ddps_1/hadoop-3.3.0
tar -xzf ~/ddps_1/hadoop.tar.gz -C ~/ddps_1

# Download hive on the namenode
echo "Downloading Hive"
curl -o ~/ddps_1/hive.tar.gz https://ftp.nluug.nl/internet/apache/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz

echo "Unpacking Hive"
# Unpack Hive
mkdir ~/ddps_1/apache-hive-3.1.2-bin
tar -xzf ~/ddps_1/hive.tar.gz -C ~/ddps_1

echo "Copying over guava.jar to hive"
rm ~/ddps_1/apache-hive-3.1.2-bin/lib/guava-19.0.jar
cp  ~/ddps_1/hadoop-3.3.0/share/hadoop/common/lib/guava-27.0-jre.jar ~/ddps_1/apache-hive-3.1.2-bin/lib/

# Clean up tars which we dont need anymore
rm ~/ddps_1/hadoop.tar.gz
rm ~/ddps_1/hive.tar.gz

echo "Done installing!"