echo "Reloading configs"
# Apply patch to hadoop config files
. ~/ddps_1/environmentvar.sh

cp ~/ddps_1/hadoopconfig/* $HADOOP_HOME/etc/hadoop