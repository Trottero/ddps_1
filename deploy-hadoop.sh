# deploy-hadoop.sh
# To be run on the main node, initializes all worker nodes with the proper hadoop binaries

# Load environment variables
chmod a+x ./ddps_1/environmentvar.sh
. ~/ddps_1/environmentvar.sh

# rm old folders
rm -r /local/$USER_TO_USE/*
rm -r /tmp/hadoop-$USER_TO_USE

# First install hive and hadoop on this node
chmod a+x ./ddps_1/install.sh
. ~/ddps_1/install.sh

# Make new folders
mkdir /local/$USER_TO_USE/
mkdir /local/$USER_TO_USE/hadoop-3.3.0/
mkdir /local/$USER_TO_USE/apache-hive-3.1.2-bin/

# Move hadoop and hive installs for host
cp ~/ddps_1/hadoop-3.3.0/* /local/$USER_TO_USE/hadoop-3.3.0/
cp ~/ddps_1/apache-hive-3.1.2-bin/* /local/$USER_TO_USE/apache-hive-3.1.2-bin/

# For every worker in the list, copy over the hadoop and hive binaries
cat ~/ddps_1/hadoopconfig/workers | while read worker;
do
  echo "" | ssh $worker mkdir /local/$USER_TO_USE/hadoop-3.3.0/
  echo "" | ssh $worker mkdir /local/$USER_TO_USE/apache-hive-3.1.2-bin/
  echo "" | ssh $worker cp ~/ddps_1/hadoop-3.3.0/* /local/$USER_TO_USE/hadoop-3.3.0/
  echo "" | ssh $worker cp ~/ddps_1/apache-hive-3.1.2-bin/* /local/$USER_TO_USE/apache-hive-3.1.2-bin/
done

# Overwrite configs at every node
. ~/ddps_1/reload-configs.sh

# Initialize hive DB in /local/
cd /local/$USER_TO_USE
$HIVE_HOME/bin/schematool -dbType derby -initSchema
cd ~