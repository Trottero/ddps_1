# deploy-hadoop.sh
# To be run on the main node, initializes all worker nodes with the proper hadoop binaries

# Make all scripts executable
# chmod a+x setup.sh
# chmod a+x start.sh
# chmod a+x stop.sh

# Load environment variables
# chmod a+x ./ddps_1/environmentvar.sh
# . ./ddps_1/environmentvar.sh

# First install this node
chmod a+x ./ddps_1/install.sh
. ./ddps_1/install.sh

deploy_to_node(){
  echo "$1"
  # Remove all older folders which might still be on there.
  echo "" | ssh $1 rm -r /home/$USER_TO_USE/ddps_1

  # Clone the new repo in there.
  echo "Cloning repo"
  echo "" | ssh $1 git clone https://github.com/Trottero/ddps_1 /home/$USER_TO_USE/ddps_1
  echo "Setting permissions and downloading hadoop"
  echo "" | ssh $1 chmod a+x /home/$USER_TO_USE/ddps_1/install.sh
  echo "" | ssh $1 /home/$USER_TO_USE/ddps_1/install.sh
  echo "Finished configuring node $1"
}

# For every worker in the list, have them download the git repo.
# And execute install.sh aswell.
# DO NOT: add the namenode to the workers list.
cat /home/$USER_TO_USE/ddps_1/hadoopconfig/workers | while read worker;
do
  deploy_to_node "$worker" &
done

wait