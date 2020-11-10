# Environment
. ~/ddps_1/environmentvar.sh

cd $DERBY_HOME/bin/ 
# NetworkServer CP
. ./setNetworkServerCP
# startNetworkserver
. ./startNetworkServer &

# Schematool init 