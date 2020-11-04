# deploy-hadoop.sh
# To be run on the main node, initializes all worker nodes with the proper hadoop binaries

# Make all scripts executable
chmod a+x setup.sh
chmod a+x start.sh
chmod a+x stop.sh

# First install this node
chmod a+x install.sh
. ./install.sh

# For every worker in the list, have them download the git repo.
# And execute install.sh aswell.
while read worker; do
  echo "$worker"
  ssh $worker git clone https://github.com/Trottero/ddps_1
  ssh $worker chmod a+x ddps_1/install.sh
  ssh $worker ddps_1/install.sh
done <$HADOOP_PATH/etc/hadoop/workers