rmf output/PIG_bench/uservisits_aggre;
a = load '/data/uservisits/*' using PigStorage('|') as (sourceIP:chararray,destURL:chararray,visitDate:chararray,adRevenue:double,userAgent:chararray,countryCode:chararray,languageCode:chararray,searchWord:chararray,duration:int);
b = group a by sourceIP parallel 60;
c = FOREACH b GENERATE group, SUM(a. adRevenue);
store c into 'output/PIG_bench/uservisits_aggre';

