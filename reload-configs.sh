echo "Reloading configs"
# Apply patch to hadoop config files

# Update configs from the git
cd ~/ddps_1
git pull
cd ~

. ~/ddps_1/environmentvar.sh

# Copy over for hostnode
cp ~/ddps_1/hadoopconfig/* /local/$USER_TO_USE/hadoop-3.3.0/etc/hadoop

# Copy over for every worker node
cat ~/ddps_1/hadoopconfig/workers | while read worker;
do
    # Copy newly pulled hadoopconfig to local dir
    echo "" | ssh $worker cp ~/ddps_1/hadoopconfig/* /local/$USER_TO_USE/hadoop-3.3.0/etc/hadoop
done