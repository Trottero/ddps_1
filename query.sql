CREATE TABLE `grep_${hivevar:i}` ( key STRING, field STRING ) ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t' STORED AS TEXTFILE;
LOAD DATA INPATH `/data/grep-${hivevari}/*` INTO TABLE `grep_${hivevar:i}`;
CREATE TABLE `grep_${hivevar:i}_select` ( key STRING, field STRING );
SET mapreduce.input.fileinputformat.split.maxsize;
SET mapreduce.input.fileinputformat.split.maxsize=134217728;
SET mapreduce.input.fileinputformat.split.maxsize;
SET dfs.blocksize;
INSERT OVERWRITE TABLE `grep_${hivevar:i}_select` SELECT * FROM `grep_${hivevar:i}` WHERE field LIKE '%XYZ%';