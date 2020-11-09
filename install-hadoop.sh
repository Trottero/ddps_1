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

echo "MySQL"
curl -s -o ~/ddps_1/mysql.tar.xz https://cdn.mysql.com//Downloads/MySQL-8.0/mysql-8.0.22-linux-glibc2.12-x86_64.tar.xz && echo "Finished downloading mysql" &

wait

echo "Unpacking hadoop"
# Unpack hadoop
mkdir ~/ddps_1/hadoop-3.3.0
tar -xzf ~/ddps_1/hadoop.tar.gz -C ~/ddps_1

echo "Unpacking Hive"
# Unpack Hive
mkdir ~/ddps_1/apache-hive-3.1.2-bin
tar -xzf ~/ddps_1/hive.tar.gz -C ~/ddps_1

echo "Unpacking MySQL"
# Unpack Hive
mkdir ~/ddps_1/mysql-8.0.22-linux-glibc2.12-x86_64
tar -xJf ~/ddps_1/mysql.tar.xz -C ~/ddps_1

echo "Copying over guava.jar to hive"
rm ~/ddps_1/apache-hive-3.1.2-bin/lib/guava-19.0.jar
cp  ~/ddps_1/hadoop-3.3.0/share/hadoop/common/lib/guava-27.0-jre.jar ~/ddps_1/apache-hive-3.1.2-bin/lib/


echo "Copying connector to hive folder"
cp  ~/ddps_1/sql/* ~/ddps_1/apache-hive-3.1.2-bin/lib/

# copy over MySQL to on host
echo "Copying mySQL to localfolder!"
mkdir /local/$USER_TO_USE/mysql-8.0.22-linux-glibc2.12-x86_64
cp -a ~/ddps_1/mysql-8.0.22-linux-glibc2.12-x86_64/* /local/$USER_TO_USE/mysql-8.0.22-linux-glibc2.12-x86_64

# Clean up tars which we dont need anymore
rm ~/ddps_1/hadoop.tar.gz
rm ~/ddps_1/hive.tar.gz
rm ~/ddps_1/mysql.tar.xz

. ~/ddps_1/add-to-path.sh
echo "Done installing!"
