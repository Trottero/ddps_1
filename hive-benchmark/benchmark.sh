#!/usr/bin/env bash

# set up configurations
source benchmark.conf;

recoverdata() {
	$HADOOP_CMD dfs -mv /user/hive/warehouse/grep/* /data/grep;
	$HADOOP_CMD dfs -mv /user/hive/warehouse/uservisits/* /data/uservisits;
	$HADOOP_CMD	dfs -mv /user/hive/warehouse/rankings/* /data/rankings;
}


if [ -e "$LOG_FILE" ]; then
	timestamp=`date "+%F-%R" --reference=$LOG_FILE`
	backupFile="$LOG_FILE.$timestamp"
	mv $LOG_FILE $backupFile
fi

trial=0
while [ $trial -lt $NUM_OF_TRIALS ]; do
	echo "Executing Trial #$trial..."
	
    # Hive queries
	for query in ${HIVE_BENCHMARKS[@]}; do
		echo "Running Hive query: $query" | tee -a $LOG_FILE
		$TIME_CMD $HIVE_CMD -f $BASE_DIR/$query 2>&1 | tee -a $LOG_FILE | grep '^Time:'
	done

	recoverdata;
	
	# PIG queries
	for query in ${PIG_BENCHMARKS[@]}; do
		echo "Running PIG query: $query" | tee -a $LOG_FILE
		$TIME_CMD $PIG_CMD $BASE_DIR/$query 2>&1 | tee -a $LOG_FILE | grep '^Time:'
	done

	# hadoop queries
	for query in ${!HADOOP_BENCHMARKS[*]}; do
		$HADOOP_CMD ${HADOOP_DATA_PREPARE[$query]} 2>&1 | tee -a $LOG_FILE > /dev/null 
		echo "Running hadoop query: ${HADOOP_BENCHMARKS[$query]}" | tee -a $LOG_FILE
		$TIME_CMD $HADOOP_CMD ${HADOOP_BENCHMARKS[$query]} 2>&1 | tee -a $LOG_FILE | grep '^Time:'
	done

	trial=`expr $trial + 1`
done # TRIAL
		  
