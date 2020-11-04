# Restart.sh
# Cold restarts the cluster, also reinitializes all of the folders.

# First stop the cluster
. ./stop.sh

# Re-setup the cluster
. ./setup.sh

# Start the cluster
. ./start.sh