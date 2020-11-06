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
chmod a+x ./ddps_1/install.sh
. ./ddps_1/install.sh &

# Download hive on the namenode
echo "Downloading Hive"
curl -o ~/ddps_1/hive.tar.gz https://ftp.nluug.nl/internet/apache/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz &

wait

echo "Unpacking Hive"
# Unpack Hive
mkdir ~/ddps_1/apache-hive-3.1.2-bin
tar -xzf ~/ddps_1/hive.tar.gz -C ~/ddps_1


# For every worker in the list, have them download the git repo.
# And execute install.sh aswell.
# DO NOT: add the namenode to the workers list.
cat ~/ddps_1/hadoopconfig/workers | while read worker;
do
  if [[ "$worker" == 'localhost' ]]; then
    echo "Skipping localhost initialization"
    continue
  fi
  
  echo "$worker"
  # Remove all older folders which might still be on there.
  echo "" | ssh $worker rm -r ~/ddps_1

  # Clone the new repo in there.
  echo "Cloning repo"
  echo "" | ssh $worker git clone https://github.com/Trottero/ddps_1 ~/ddps_1
  echo "Setting permissions and downloading hadoop"
  echo "" | ssh $worker chmod a+x ~/ddps_1/install.sh
  echo "" | ssh $worker ~/ddps_1/install.sh &
  echo "Finished configuring node $worker"
done

wait