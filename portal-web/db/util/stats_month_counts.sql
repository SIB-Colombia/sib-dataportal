drop table if exists stats_month_counts;

create table stats_month_counts (year int(4), month int (2), count int(10), accumulative int(10));

insert into stats_month_counts (year, month, count) select 2012, 12, count(*) from raw_occurrence_record where created like '2012-12%' union all
select 2013, 01, count(*) from raw_occurrence_record where created like '2013-01%' union all
select 2013, 02, count(*) from raw_occurrence_record where created like '2013-02%' union all
select 2013, 03, count(*) from raw_occurrence_record where created like '2013-03%' union all
select 2013, 04, count(*) from raw_occurrence_record where created like '2013-04%' union all
select 2013, 05, count(*) from raw_occurrence_record where created like '2013-05%' union all
select 2013, 06, count(*) from raw_occurrence_record where created like '2013-06%' union all
select 2013, 07, count(*) from raw_occurrence_record where created like '2013-07%' union all
select 2013, 08, count(*) from raw_occurrence_record where created like '2013-08%' union all
select 2013, 09, count(*) from raw_occurrence_record where created like '2013-09%' union all
select 2013, 10, count(*) from raw_occurrence_record where created like '2013-10%' union all
select 2013, 11, count(*) from raw_occurrence_record where created like '2013-11%' union all
select 2013, 12, count(*) from raw_occurrence_record where created like '2013-12%' union all
select 2014, 01, count(*) from raw_occurrence_record where created like '2014-01%' union all
select 2014, 02, count(*) from raw_occurrence_record where created like '2014-02%' union all
select 2014, 03, count(*) from raw_occurrence_record where created like '2014-03%' union all
select 2014, 04, count(*) from raw_occurrence_record where created like '2014-04%' union all
select 2014, 05, count(*) from raw_occurrence_record where created like '2014-05%' union all
select 2014, 06, count(*) from raw_occurrence_record where created like '2014-06%';

update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-01-01') where year = 2012 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-02-01') where year = 2013 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-03-01') where year = 2013 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-04-01') where year = 2013 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-05-01') where year = 2013 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-06-01') where year = 2013 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-07-01') where year = 2013 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-08-01') where year = 2013 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-09-01') where year = 2013 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-10-01') where year = 2013 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-11-01') where year = 2013 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-12-01') where year = 2013 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-01-01') where year = 2013 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-02-01') where year = 2014 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-03-01') where year = 2014 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-04-01') where year = 2014 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-05-01') where year = 2014 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-06-01') where year = 2014 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-07-01') where year = 2014 and month = 06;