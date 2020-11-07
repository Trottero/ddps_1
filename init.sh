# Make sure that env variables are used:
chmod a+x ~/ddps_1/environmentvar.sh
. ~/ddps_1/environmentvar.sh


# rm old folders
rm -r /local/$USER_TO_USE/

# Make new folders
mkdir /local/$USER_TO_USE/
mkdir /local/$USER_TO_USE/hadoop-3.3.0/
mkdir /local/$USER_TO_USE/apache-hive-3.1.2-bin/
mkdir /local/$USER_TO_USE/hadoopstorage/
mkdir /local/$USER_TO_USE/hadoopstorage/namenode/
mkdir /local/$USER_TO_USE/hadoopstorage/datanode/

# Move hadoop and hive installs for host
cp -a ~/ddps_1/hadoop-3.3.0/* /local/$USER_TO_USE/hadoop-3.3.0/
cp -a ~/ddps_1/apache-hive-3.1.2-bin/* /local/$USER_TO_USE/apache-hive-3.1.2-bin/