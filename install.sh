# install.sh
# Everything that's required to initialize a node to be ready with hadoop

# Allow execution of all of the scripting files
chmod a+x ~/ddps_1/environmentvar.sh
chmod a+x ~/ddps_1/add-to-path.sh
chmod a+x ~/ddps_1/joblog.sh
chmod a+x ~/ddps_1/jobs.sh
chmod a+x ~/ddps_1/reload-configs.sh
chmod a+x ~/ddps_1/report.sh
chmod a+x ~/ddps_1/setup.sh
chmod a+x ~/ddps_1/start.sh
chmod a+x ~/ddps_1/stop.sh
chmod a+x ~/ddps_1/tests/distributed-grep.sh

# Load environment variables
. ~/ddps_1/environmentvar.sh

# Add hadoop / yarn / mapred to path 
. ~/ddps_1/add-to-path.sh

mkdir /home/$USER_TO_USE/ddps_1/hadoopstorage
mkdir /home/$USER_TO_USE/ddps_1/hadoopstorage/data
mkdir /home/$USER_TO_USE/ddps_1/hadoopstorage/namenodedir


# Download hadoop
curl -o /home/$USER_TO_USE/ddps_1/hadoop.tar.gz https://apache.mirror.wearetriple.com/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz

echo "Unpacking hadoop"
# Unpack hadoop
mkdir ./ddps_1/hadoop-3.3.0
tar -xzf ./ddps_1/hadoop.tar.gz -C ./ddps_1

# Reload configs
. ~/ddps_1/reload-configs.sh

echo "Done installing!"