
jobid=0
JOB_ORDER=()

JOBS=(1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 10 10 10 10 10 50 50 50 100 100 200 200 400 800 4800)

for i in ${JOBS[@]}
do
    if [[ "$1" == '' ]]; then
        perl ~/ddps_1/hive-benchmark/source_code/datagen/teragen/teragen.pl $i $jobid
    fi
    JOB_ORDER[$jobid]=$jobid
    let "jobid+=1" 
done
# 40, 80 | 6, 10, 20
JOB_ORDER=( $(echo "${JOB_ORDER[@]}" | sed -r 's/(.[^ ]* )/ \1 /g' | tr " " "\n" | shuf | tr -d " ") )

echo  ${JOB_ORDER[@]}
cd /local/$USER_TO_USE 
for i in ${JOB_ORDER[@]}
do
    echo "$i"
    $HIVE_HOME/bin/hive -e "CREATE TABLE grep_${i} ( key STRING, field STRING ) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE;"
    $HIVE_HOME/bin/hive -e "LOAD DATA INPATH '/data/grep-${i}/*' INTO TABLE grep_${i};"
    $HIVE_HOME/bin/hive -e "CREATE TABLE grep_${i}_select ( key STRING, field STRING );"
    # $HIVE_HOME/bin/beeline -u jdbc:hive2:// --hivevar job_id="200" -f ~/ddps_1/query.sql
    $HIVE_HOME/bin/hive -e \
        "SET mapreduce.input.fileinputformat.split.maxsize=128000000;\
        SET mapred.max.split.size=134217728;\
        SET mapred.min.split.size=134217728;\
        SET mapreduce.input.fileinputformat.split.maxsize;\
        SET dfs.blocksize;\
        INSERT OVERWRITE TABLE grep_${i}_select SELECT * FROM grep_${i} WHERE field LIKE '%XYZ%';" &
    sleep 14
done
wait
cd ~