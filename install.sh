# install.sh
# Everything that's required to initialize a node to be ready with hadoop

# Load environment variables
chmod a+x ./ddps_1/environmentvar.sh
. ./ddps_1/environmentvar.sh

mkdir /home/$USER_TO_USE/ddps_1/hadoopstorage
mkdir /home/$USER_TO_USE/ddps_1/hadoopstorage/data
mkdir /home/$USER_TO_USE/ddps_1/hadoopstorage/namenodedir

# Download hadoop
curl -o /home/$USER_TO_USE/ddps_1/hadoop.tar.gz https://apache.mirror.wearetriple.com/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz

echo "Unpacking hadoop"
# Unpack hadoop
mkdir ./ddps_1/hadoop-3.3.0
tar -xzf ./ddps_1/hadoop.tar.gz -C ./ddps_1

chmod a+x ~/ddps_1/reload-configs.sh
. ~/ddps_1/reload-configs.sh

echo "Done installing!"