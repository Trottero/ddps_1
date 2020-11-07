echo "Reloading configs"
# Apply patch to hadoop config files

# Update configs from the git
cd ~/ddps_1
git pull

. ~/ddps_1/environmentvar.sh

cp ~/ddps_1/hadoopconfig/* $HADOOP_HOME/etc/hadoop