# reload-configs.sh
# reloads configs on host aswell as all workers
. ~/ddps_1/environmentvar.sh

. ~/ddps_1/reload-configs-local.sh
# also apply it to all of the worker nodes
cat ~/ddps_1/hadoopconfig/workers | while read worker;
do
    # Run update script on every remote
    echo "$worker"
    ssh $worker < ~/ddps_1/reload-configs-local.sh 
done
