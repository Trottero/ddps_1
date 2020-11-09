# install.sh
# Everything that's required to initialize a node to be ready with hadoop

chmod a+x ~/ddps_1/makeexec.sh
. ~/ddps_1/makeexec.sh

# Load environment variables
. ~/ddps_1/environmentvar.sh

# Add hadoop / yarn / mapred to path 
. ~/ddps_1/add-to-path.sh

# Remove old install dirs.
rm -r ~/ddps_1/hadoop-3.3.0
rm -r ~/ddps_1/apache-hive-3.1.2-bin


echo "Downloading Hadoop"
# Download hadoop
curl -s -o ~/ddps_1/hadoop.tar.gz https://ftp.nluug.nl/internet/apache/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz && echo "Finished downloading hadoop" &

# Download hive on the namenode
echo "Downloading Hive"
curl -s -o ~/ddps_1/hive.tar.gz https://ftp.nluug.nl/internet/apache/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz && echo "Finished downloading hive" &

wait

echo "Unpacking hadoop"
# Unpack hadoop
mkdir ~/ddps_1/hadoop-3.3.0
tar -xzf ~/ddps_1/hadoop.tar.gz -C ~/ddps_1

echo "Unpacking Hive"
# Unpack Hive
mkdir ~/ddps_1/apache-hive-3.1.2-bin
tar -xzf ~/ddps_1/hive.tar.gz -C ~/ddps_1

echo "Copying over guava.jar to hive"
rm ~/ddps_1/apache-hive-3.1.2-bin/lib/guava-19.0.jar
cp  ~/ddps_1/hadoop-3.3.0/share/hadoop/common/lib/guava-27.0-jre.jar ~/ddps_1/apache-hive-3.1.2-bin/lib/


echo "Installing mysql server"
apt-get install mysql-server

echo "Copying connector to hive folder"
cp  ~/ddps_1/sql/* ~/ddps_1/apache-hive-3.1.2-bin/lib/

# Clean up tars which we dont need anymore
rm ~/ddps_1/hadoop.tar.gz
rm ~/ddps_1/hive.tar.gz

echo "Done installing!"
