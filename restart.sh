# Restart.sh
# Cold restarts the cluster, also reinitializes all of the folders.

. ~/ddps_1/environmentvar.sh

# First stop the cluster
. ~/ddps_1/stop.sh

# Re-setup the cluster
. ~/ddps_1/setup.sh

# Start the cluster
. ~/ddps_1/start.sh