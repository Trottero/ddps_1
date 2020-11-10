
jobid=0
JOB_ORDER=()
JOB_WAITS=()

JOBS=(1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 10 10 10 10 10 50 50 50 100 100 200 200 400 800 4800)
# JOBS=(1 2 10)

# First generate sql users
for d in {0..32}
do
# mysql -u root -p <Give password while installing DB>
# mysql> CREATE USER 'user1'@'%' IDENTIFIED BY 'user1pass';
# mysql> GRANT ALL PRIVILEGES ON *.* TO 'hduserdb'@'%' WITH GRANT OPTION;
# mysql> flush privileges;
    echo "${d}"
done

cd /local/$USER_TO_USE 
for i in ${JOBS[@]}
do
    if [[ "$1" == '' ]]; then
        perl ~/ddps_1/hive-benchmark/source_code/datagen/teragen/teragen.pl $i $jobid
    fi
    
    $HIVE_HOME/bin/hive -e \
        "CREATE TABLE grep_${jobid} ( key STRING, field STRING ) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE;\
        LOAD DATA INPATH '/data/grep-${jobid}/*' INTO TABLE grep_${jobid}; \
        CREATE TABLE grep_${jobid}_select ( key STRING, field STRING );" &
    JOB_WAITS[$jobid]=$!

    JOB_ORDER[$jobid]=$jobid
    let "jobid+=1" 
done
echo "Waiting for tasks to complete!"
wait ${JOB_WAITS[@]}

# 40, 80 | 6, 10, 20
JOB_ORDER=( $(echo "${JOB_ORDER[@]}" | sed -r 's/(.[^ ]* )/ \1 /g' | tr " " "\n" | shuf | tr -d " ") )

JOB_WAITS=()
jobid=0

echo  ${JOB_ORDER[@]}
for i in ${JOB_ORDER[@]}
do
    echo "Executing query: ${i}"
    $HIVE_HOME/bin/hive -e \
        "SET mapreduce.input.fileinputformat.split.maxsize=128000000;\
        SET mapred.max.split.size=134217728;\
        SET mapred.min.split.size=134217728;\
        INSERT OVERWRITE TABLE grep_${i}_select SELECT * FROM grep_${i} WHERE field LIKE '%XYZ%';" &
    JOB_WAITS[$jobid]=$!
    let "jobid+=1" 
    sleep 14
done
echo "Done iterating through tasks, waiting 10 minutes for the rest of the tasks to finish now."

wait ${JOB_WAITS[@]}
# sleep 600
cd ~