# deploy-hadoop.sh
# To be run on the main node, initializes all worker nodes with the proper hadoop binaries

# Make all scripts executable
# chmod a+x setup.sh
# chmod a+x start.sh
# chmod a+x stop.sh

# Load environment variables
chmod a+x ./ddps_1/environmentvar.sh
. ./ddps_1/environmentvar.sh

# First install this node
# chmod a+x ./ddps_1/install.sh
# . ./ddps_1/install.sh

# For every worker in the list, have them download the git repo.
# And execute install.sh aswell.
# DO NOT: add the namenode to the workers list.
cat /home/$USER_TO_USE/ddps_1/hadoopconfig/workers | while read worker;
do
  echo "$worker"
  # Remove all older folders which might still be on there.
  ssh $worker rm -r /home/$USER_TO_USE/ddps_1 -n

  # Clone the new repo in there.
  echo "Cloning repo"
  ssh $worker git clone https://github.com/Trottero/ddps_1 /home/$USER_TO_USE/ddps_1 -n
  echo "Setting permissions and downloading hadoop"
  ssh $worker chmod a+x /home/$USER_TO_USE/ddps_1/install.sh -n
  ssh $worker /home/$USER_TO_USE/ddps_1/install.sh -n
  echo "Starting next iteration"
done