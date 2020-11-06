# reload-configs.sh
# reloads configs on host aswell as all workers

. ~/ddps_1/reload-configs-local.sh
# also apply it to all of the worker nodes
cat ~/ddps_1/hadoopconfig/workers | while read worker;
do
    # Update git repos
    echo "" | ssh $worker "cd ~/ddps_1 && git pull"
    # Reload local configs
    echo "" | ssh $worker ~/ddps_1/reload-configs-local.sh
done
