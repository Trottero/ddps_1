# deploy-hadoop.sh
# To be run on the main node, initializes all worker nodes with the proper hadoop binaries

# Make all scripts executable
# chmod a+x setup.sh
# chmod a+x start.sh
# chmod a+x stop.sh

# Load environment variables
chmod a+x ./ddps_1/environmentvar.sh
. ~/ddps_1/environmentvar.sh

# First install this node
chmod a+x ./ddps_1/install.sh
. ~/ddps_1/install.sh

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


# For every worker in the list, have them download the git repo.
# And execute install.sh aswell.
# DO NOT: add the namenode to the workers list.
cat ~/ddps_1/hadoopconfig/workers | while read worker;
do
  echo "" | ssh $worker cp ~/ddps_1/* /local/$USER_TO_USE
done

cd /local/$USER_TO_USE
$HIVE_HOME/bin/schematool -dbType derby -initSchema
cd ~