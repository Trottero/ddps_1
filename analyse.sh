# Analyse.sh
# Analyzes all jobs in the history and outputs their data locality to a file



# Make working dir
mkdir tmp-analytics

# Make result dir
mkdir results

# First find all of the sorting jobs
mapred job -list all | grep grep-search | awk '{print $1}' >> tmp-analytics/jobs_to_analyze

# Then for every job, grab some statistics
cat tmp-analytics/jobs_to_analyze | while read job;
do
    # Analyze job history and grab amount of local tasks from it.
    data_local_tasks=$(mapred job -history $job | grep "Data-local map tasks" | awk '{print $8}')
    rack_local_tasks=$(mapred job -history $job | grep "Rack-local map tasks" | awk '{print $8}')

    launched_map_tasks=$(mapred job -history $job | grep "Launched map tasks" | awk '{print $8}')
    job_runtime=$(mapred job -history $job | grep "Finished At:" | awk '{print $5}')
    
    # Check for no locality
    if [ "$rack_local_tasks" = "" ];
    then
        rack_local_tasks="|0"
    fi
    if [ "$data_local_tasks" = "" ];
    then
        data_local_tasks="|0"
    fi
    echo $data_local_tasks $rack_local_tasks $launched_map_tasks $job_runtime >> results/job_result
done

# Remove old working dir
rm -r tmp-analytics