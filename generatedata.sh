
jobid=0


# JOBS=(2)
JOBS=(2 2 2 2 2 2 2 2 2 2 2 2 2 2 10 10 10 10 10 10 10 10 20 20 20 20 20 20 40 40 40 40 40 40 80 80 80 80 160 160 160 960 960 960 960)
for i in ${JOBS[@]}
do
    if [[ "$1" == '' ]]; then
        perl ~/ddps_1/hive-benchmark/source_code/datagen/teragen/teragen.pl $i $jobid
    fi
    JOB_ORDER[$jobid]=$jobid
    let "jobid+=1" 
done

JOB_ORDER=( $(echo "${JOB_ORDER[@]}" | sed -r 's/(.[^ ]* )/ \1 /g' | tr " " "\n" | shuf | tr -d " ") )

chmod a+x ~/ddps_1/executequery.sh

for i in ${JOB_ORDER[@]}
do
    echo "$i"
    $HIVE_HOME/bin/hive -e "CREATE TABLE grep_${i} ( key STRING, field STRING ) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE;"
    $HIVE_HOME/bin/hive -e "LOAD DATA INPATH '/data/grep-${i}/*' INTO TABLE grep_${i};"
    $HIVE_HOME/bin/hive -e "CREATE TABLE grep_${i}_select ( key STRING, field STRING );"
    $HIVE_HOME/bin/hive -e "SET mapreduce.input.fileinputformat.split.maxsize = 128000000;"
    $HIVE_HOME/bin/hive -e "INSERT OVERWRITE TABLE grep_${i}_select SELECT * FROM grep_${i} WHERE field LIKE '%XYZ%';" &
    sleep 14
done