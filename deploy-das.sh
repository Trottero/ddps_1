# deploy-das.sh
# Deploys from local pc to given DAS5 Node


# Script variables
LEIDEN_USER_NAME=s2685620
DAS5_USER_NAME=ddps2018
DAS5_MAIN_NODE=node124

# First copy to LIACS machine
echo "Copying over to leiden machine"
scp -r tests/ $LEIDEN_USER_NAME@ssh.liacs.nl:/tests

# Next copy to das5 frontend
echo "Copying over to das5 front-end"
# scp -r $LEIDEN_USER_NAME@ssh.liacs.nl:/das5-deploy DAS5_USER_NAME@fs1.das5.liacs.nl:/das5-deploy

# Next copy it from das5 frontend to node
echo "Copying over to das5 node"
# scp -r DAS5_USER_NAME@fs1.das5.liacs.nl:/das5-deploy DAS5_USER_NAME@DAS5_MAIN_NODE:/

# 2fTpmPH6CYXfe
# FYcwp12q