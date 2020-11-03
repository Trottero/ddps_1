# deploy-das.sh
# Deploys from local pc to given DAS5 Node


# Script variables
LEIDEN_USER_NAME=1234
DAS5_USER_NAME=12321
DAS5_MAIN_NODE=123

# First copy to LIACS machine
scp -r . $LEIDEN_USER_NAME@ssh.liacs.nl:/das5-deploy

# Next copy to das5 frontend
scp -r $LEIDEN_USER_NAME@ssh.liacs.nl:/das5-deploy DAS5_USER_NAME@fs1.das5.liacs.nl:/das5-deploy

# Next copy it from das5 frontend to node
scp -r DAS5_USER_NAME@fs1.das5.liacs.nl:/das5-deploy DAS5_USER_NAME@DAS5_MAIN_NODE:/