# deploy-hadoop.sh
# To be run on the main node, initializes all worker nodes with the proper hadoop binaries

# Load environment variables
chmod a+x ~/ddps_1/environmentvar.sh
. ~/ddps_1/environmentvar.sh


chmod a+x ~/ddps_1/makeexec.sh
. ~/ddps_1/makeexec.sh

# First install hive and hadoop on this node in the home direcotry

### Check if a directory does not exist ###
if [ ! -d "/home/${USER_TO_USE}/ddps_1/hadoop-3.3.0" ] 
then
  echo "Hadoop directory does not exist" 
  . ~/ddps_1/install-hadoop.sh
fi

. ~/ddps_1/init.sh

# copy over Derby to on host
echo "Copying Derby to localfolder"
mkdir /local/$USER_TO_USE/db-derby-10.14.1.0-bin
cp -a ~/ddps_1/db-derby-10.14.1.0-bin/* /local/$USER_TO_USE/db-derby-10.14.1.0-bin/

NODE_INIT_PIDS=()
NODE_N=0
# For every worker in the list, copy over the hadoop and hive binaries to /local/user/
cat ~/ddps_1/hadoopconfig/workers | while read worker;
do
  echo "Initializing worker: ${worker}"
  echo "" | ssh $worker ~/ddps_1/init.sh
  NODE_INIT_PIDS[$NODE_N]=$!
  let "NODE_N+=1" 
done

wait ${NODE_INIT_PIDS[@]}

# Overwrite configs at every node
. ~/ddps_1/reload-configs.sh

# Start derby server so we can create schema
. ~/ddps_1/startderbyserver.sh &!

# wait 5 seconds to be sure that the server is launched
sleep 5
# Initialize derby db/
$HIVE_HOME/bin/schematool -dbType derby -initSchema

# Stop derby server
. ~/ddps_1/stopderbyserver.sh