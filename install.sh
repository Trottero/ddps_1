# install.sh
# Everything that's required to initialize a node to be ready with hadoop

# Allow execution of all of the scripting files
chmod a+x ~/ddps_1/environmentvar.sh
chmod a+x ~/ddps_1/add-to-path.sh
chmod a+x ~/ddps_1/joblog.sh
chmod a+x ~/ddps_1/jobs.sh
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

mkdir /home/$USER_TO_USE/ddps_1/hadoopstorage
mkdir /home/$USER_TO_USE/ddps_1/hadoopstorage/data
mkdir /home/$USER_TO_USE/ddps_1/hadoopstorage/namenodedir

# Remove old data dir.
rm -r /tmp/hadoop-$USER_TO_USE

echo "Downloading Hadoop"
# Download hadoop
curl -o ~/ddps_1/hadoop.tar.gz https://ftp.nluug.nl/internet/apache/hadoop/common/hadoop-3.1.3/hadoop-3.1.3.tar.gz &

echo "Downloading Hive"
curl -o ~/ddps_1/hive.tar.gz https://ftp.nluug.nl/internet/apache/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz &

wait

echo "Unpacking hadoop"
# Unpack hadoop
mkdir ~/ddps_1/hadoop-3.1.3
tar -xzf ~/ddps_1/hadoop.tar.gz -C ~/ddps_1


echo "Unpacking Hive"
# Unpack Hive
mkdir ~/ddps_1/apache-hive-3.1.2-bin
tar -xzf ~/ddps_1/hive.tar.gz -C ~/ddps_1

# Reload configs
. ~/ddps_1/reload-configs.sh

echo "Copying over guava.jar to hive"
rm $HIVE_HOME/lib/guava-19.0.jar
cp $HADOOP_HOME/share/hadoop/common/lib/guava-27.0-jre.jar $HIVE_HOME/lib/

echo "Done installing!"