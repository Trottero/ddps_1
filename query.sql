SET job_id
SET hivevar:job_id
CREATE TABLE `grep_${hivevar:job_id}` ( key STRING, field STRING ) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE;
LOAD DATA INPATH `/data/grep-${hivevar:job_id}/*` INTO TABLE `grep_${hivevar:job_id}`;
CREATE TABLE `grep_${job_id}_select` ( key STRING, field STRING );
SET mapreduce.input.fileinputformat.split.maxsize;
SET mapreduce.input.fileinputformat.split.maxsize=134217728;
SET mapreduce.input.fileinputformat.split.maxsize;
SET dfs.blocksize;
INSERT OVERWRITE TABLE `grep_${hivevar:job_id}_select` SELECT * FROM `grep_${hivevar:job_id}` WHERE field LIKE '%XYZ%';