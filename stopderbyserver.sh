# Environment
(. ~/ddps_1/environmentvar.sh

cd $DERBY_HOME/bin/ 
# NetworkServer CP
# startNetworkserver
. ./stopNetworkServer) &!

# Schematool init 