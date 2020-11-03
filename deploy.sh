# deploy.sh
# To be run on the main node, initializes all worker nodes with the proper hadoop binaries

HADOOP_PATH=./hadoop-3.3.0

# Make all scripts executable
chmod a+x setup.sh
chmod a+x start.sh
chmod a+x stop.sh

# For every worker in the list, copy over the files.
while read worker; do
  echo "$worker"
  scp -p . $worker/
done <$HADOOP_PATH/etc/hadoop/workers