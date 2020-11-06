rmf output/PIG_bench/html_join;
a = load '/data/uservisits/*' using PigStorage('|') as (sourceIP:chararray,destURL:chararray,visitDate:chararray,adRevenue:double,userAgent:chararray,countryCode:chararray,languageCode:chararray,searchWord:chararray,duration:int);
b = load '/data/rankings/*' using PigStorage('|') as (pagerank:int,pageurl:chararray,aveduration:int);
c = filter a by visitDate > '1999-01-01' AND visitDate < '2000-01-01';
d = JOIN c by destURL, b by pageurl;
e = group d by sourceIP parallel 60;
f = FOREACH e GENERATE group, AVG(d.pagerank), SUM(d.adRevenue);
store f into 'output/PIG_bench/html_join';

