# deploy-hadoop.sh
# To be run on the main node, initializes all worker nodes with the proper hadoop binaries

# Load environment variables
chmod a+x ~/ddps_1/environmentvar.sh
. ~/ddps_1/environmentvar.sh

# rm old folders
rm -r /local/$USER_TO_USE/

# First install hive and hadoop on this node
chmod a+x ~/ddps_1/install-hadoop.sh
. ~/ddps_1/install-hadoop.sh

. ~/ddps_1/init.sh

# For every worker in the list, copy over the hadoop and hive binaries to /local/user/
cat ~/ddps_1/hadoopconfig/workers | while read worker;
do
  echo "" | ssh $worker ~/ddps_1/init.sh
done

# Overwrite configs at every node
. ~/ddps_1/reload-configs.sh

# Initialize hive DB in /local/
cd /local/$USER_TO_USE
$HIVE_HOME/bin/schematool -dbType derby -initSchema
cd ~