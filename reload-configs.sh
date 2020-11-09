echo "Reloading configs"
# Apply patch to hadoop config files

# Update configs from the git
cd ~/ddps_1
git pull
cd ~

. ~/ddps_1/environmentvar.sh

# Copy over for hostnode
cp ~/ddps_1/hadoopconfig/* /local/$USER_TO_USE/hadoop-3.3.0/etc/hadoop

cp ~/ddps_1/hadoopconfig/hive-site.xml /local/ddps2018/apache-hive-3.1.2-bin/conf

# Copy over for every worker node
cat ~/ddps_1/hadoopconfig/workers | while read worker;
do
    # Copy newly pulled hadoopconfig to local dir
    echo "" | ssh $worker cp ~/ddps_1/hadoopconfig/* /local/$USER_TO_USE/hadoop-3.3.0/etc/hadoop
    echo "" | ssh $worker cp ~/ddps_1/hadoopconfig/hive-site.xml /local/$USER_TO_USE/apache-hive-3.1.2-bin/conf
done