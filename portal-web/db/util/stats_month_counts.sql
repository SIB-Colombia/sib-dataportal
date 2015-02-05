
drop table if exists stats_month_counts;

create table stats_month_counts (year int(4), month int (2), count int(10), accumulative int(10));

insert into stats_month_counts (year, month, count) 
select 2012, 12, count(*) from raw_occurrence_record where created like '2012-12%' and deleted is null union all
select 2013, 01, count(*) from raw_occurrence_record where created like '2013-01%' and deleted is null union all
select 2013, 02, count(*) from raw_occurrence_record where created like '2013-02%' and deleted is null union all
select 2013, 03, count(*) from raw_occurrence_record where created like '2013-03%' and deleted is null union all
select 2013, 04, count(*) from raw_occurrence_record where created like '2013-04%' and deleted is null union all
select 2013, 05, count(*) from raw_occurrence_record where created like '2013-05%' and deleted is null union all
select 2013, 06, count(*) from raw_occurrence_record where created like '2013-06%' and deleted is null union all
select 2013, 07, count(*) from raw_occurrence_record where created like '2013-07%' and deleted is null union all
select 2013, 08, count(*) from raw_occurrence_record where created like '2013-08%' and deleted is null union all
select 2013, 09, count(*) from raw_occurrence_record where created like '2013-09%' and deleted is null union all
select 2013, 10, count(*) from raw_occurrence_record where created like '2013-10%' and deleted is null union all
select 2013, 11, count(*) from raw_occurrence_record where created like '2013-11%' and deleted is null union all
select 2013, 12, count(*) from raw_occurrence_record where created like '2013-12%' and deleted is null union all
select 2014, 01, count(*) from raw_occurrence_record where created like '2014-01%' and deleted is null union all
select 2014, 02, count(*) from raw_occurrence_record where created like '2014-02%' and deleted is null union all
select 2014, 03, count(*) from raw_occurrence_record where created like '2014-03%' and deleted is null union all
select 2014, 04, count(*) from raw_occurrence_record where created like '2014-04%' and deleted is null union all
select 2014, 05, count(*) from raw_occurrence_record where created like '2014-05%' and deleted is null union all
select 2014, 06, count(*) from raw_occurrence_record where created like '2014-06%' and deleted is null union all
select 2014, 07, count(*) from raw_occurrence_record where created like '2014-07%' and deleted is null union all
select 2014, 08, count(*) from raw_occurrence_record where created like '2014-08%' and deleted is null union all
select 2014, 09, count(*) from raw_occurrence_record where created like '2014-09%' and deleted is null union all
select 2014, 10, count(*) from raw_occurrence_record where created like '2014-10%' and deleted is null union all
select 2014, 11, count(*) from raw_occurrence_record where created like '2014-11%' and deleted is null union all
select 2014, 12, count(*) from raw_occurrence_record where created like '2014-12%' and deleted is null union all
select 2015, 01, count(*) from raw_occurrence_record where created like '2015-01%' and deleted is null union all
select 2015, 02, count(*) from raw_occurrence_record where created like '2015-02%' and deleted is null union all
select 2015, 03, count(*) from raw_occurrence_record where created like '2015-03%' and deleted is null union all
select 2015, 04, count(*) from raw_occurrence_record where created like '2015-04%' and deleted is null union all
select 2015, 05, count(*) from raw_occurrence_record where created like '2015-05%' and deleted is null union all
select 2015, 06, count(*) from raw_occurrence_record where created like '2015-06%' and deleted is null union all
select 2015, 07, count(*) from raw_occurrence_record where created like '2015-07%' and deleted is null union all
select 2015, 08, count(*) from raw_occurrence_record where created like '2015-08%' and deleted is null union all
select 2015, 09, count(*) from raw_occurrence_record where created like '2015-09%' and deleted is null union all
select 2015, 10, count(*) from raw_occurrence_record where created like '2015-10%' and deleted is null union all
select 2015, 11, count(*) from raw_occurrence_record where created like '2015-11%' and deleted is null union all
select 2015, 12, count(*) from raw_occurrence_record where created like '2015-12%' and deleted is null union all
select 2016, 01, count(*) from raw_occurrence_record where created like '2016-01%' and deleted is null union all
select 2016, 02, count(*) from raw_occurrence_record where created like '2016-02%' and deleted is null union all
select 2016, 03, count(*) from raw_occurrence_record where created like '2016-03%' and deleted is null union all
select 2016, 04, count(*) from raw_occurrence_record where created like '2016-04%' and deleted is null union all
select 2016, 05, count(*) from raw_occurrence_record where created like '2016-05%' and deleted is null union all
select 2016, 06, count(*) from raw_occurrence_record where created like '2016-06%' and deleted is null union all
select 2016, 07, count(*) from raw_occurrence_record where created like '2016-07%' and deleted is null union all
select 2016, 08, count(*) from raw_occurrence_record where created like '2016-08%' and deleted is null union all
select 2016, 09, count(*) from raw_occurrence_record where created like '2016-09%' and deleted is null union all
select 2016, 10, count(*) from raw_occurrence_record where created like '2016-10%' and deleted is null union all
select 2016, 11, count(*) from raw_occurrence_record where created like '2016-11%' and deleted is null union all
select 2016, 12, count(*) from raw_occurrence_record where created like '2016-12%' and deleted is null union all
select 2017, 01, count(*) from raw_occurrence_record where created like '2017-01%' and deleted is null union all
select 2017, 02, count(*) from raw_occurrence_record where created like '2017-02%' and deleted is null union all
select 2017, 03, count(*) from raw_occurrence_record where created like '2017-03%' and deleted is null union all
select 2017, 04, count(*) from raw_occurrence_record where created like '2017-04%' and deleted is null union all
select 2017, 05, count(*) from raw_occurrence_record where created like '2017-05%' and deleted is null union all
select 2017, 06, count(*) from raw_occurrence_record where created like '2017-06%' and deleted is null union all
select 2017, 07, count(*) from raw_occurrence_record where created like '2017-07%' and deleted is null union all
select 2017, 08, count(*) from raw_occurrence_record where created like '2017-08%' and deleted is null union all
select 2017, 09, count(*) from raw_occurrence_record where created like '2017-09%' and deleted is null union all
select 2017, 10, count(*) from raw_occurrence_record where created like '2017-10%' and deleted is null union all
select 2017, 11, count(*) from raw_occurrence_record where created like '2017-11%' and deleted is null union all
select 2017, 12, count(*) from raw_occurrence_record where created like '2017-12%' and deleted is null union all
select 2018, 01, count(*) from raw_occurrence_record where created like '2018-01%' and deleted is null union all
select 2018, 02, count(*) from raw_occurrence_record where created like '2018-02%' and deleted is null union all
select 2018, 03, count(*) from raw_occurrence_record where created like '2018-03%' and deleted is null union all
select 2018, 04, count(*) from raw_occurrence_record where created like '2018-04%' and deleted is null union all
select 2018, 05, count(*) from raw_occurrence_record where created like '2018-05%' and deleted is null union all
select 2018, 06, count(*) from raw_occurrence_record where created like '2018-06%' and deleted is null union all
select 2018, 07, count(*) from raw_occurrence_record where created like '2018-07%' and deleted is null union all
select 2018, 08, count(*) from raw_occurrence_record where created like '2018-08%' and deleted is null union all
select 2018, 09, count(*) from raw_occurrence_record where created like '2018-09%' and deleted is null union all
select 2018, 10, count(*) from raw_occurrence_record where created like '2018-10%' and deleted is null union all
select 2018, 11, count(*) from raw_occurrence_record where created like '2018-11%' and deleted is null union all
select 2018, 12, count(*) from raw_occurrence_record where created like '2018-12%' and deleted is null union all
select 2019, 01, count(*) from raw_occurrence_record where created like '2019-01%' and deleted is null union all
select 2019, 02, count(*) from raw_occurrence_record where created like '2019-02%' and deleted is null union all
select 2019, 03, count(*) from raw_occurrence_record where created like '2019-03%' and deleted is null union all
select 2019, 04, count(*) from raw_occurrence_record where created like '2019-04%' and deleted is null union all
select 2019, 05, count(*) from raw_occurrence_record where created like '2019-05%' and deleted is null union all
select 2019, 06, count(*) from raw_occurrence_record where created like '2019-06%' and deleted is null union all
select 2019, 07, count(*) from raw_occurrence_record where created like '2019-07%' and deleted is null union all
select 2019, 08, count(*) from raw_occurrence_record where created like '2019-08%' and deleted is null union all
select 2019, 09, count(*) from raw_occurrence_record where created like '2019-09%' and deleted is null union all
select 2019, 10, count(*) from raw_occurrence_record where created like '2019-10%' and deleted is null union all
select 2019, 11, count(*) from raw_occurrence_record where created like '2019-11%' and deleted is null union all
select 2019, 12, count(*) from raw_occurrence_record where created like '2019-12%' and deleted is null union all
select 2020, 01, count(*) from raw_occurrence_record where created like '2020-01%' and deleted is null union all
select 2020, 02, count(*) from raw_occurrence_record where created like '2020-02%' and deleted is null union all
select 2020, 03, count(*) from raw_occurrence_record where created like '2020-03%' and deleted is null union all
select 2020, 04, count(*) from raw_occurrence_record where created like '2020-04%' and deleted is null union all
select 2020, 05, count(*) from raw_occurrence_record where created like '2020-05%' and deleted is null union all
select 2020, 06, count(*) from raw_occurrence_record where created like '2020-06%' and deleted is null union all
select 2020, 07, count(*) from raw_occurrence_record where created like '2020-07%' and deleted is null union all
select 2020, 08, count(*) from raw_occurrence_record where created like '2020-08%' and deleted is null union all
select 2020, 09, count(*) from raw_occurrence_record where created like '2020-09%' and deleted is null union all
select 2020, 10, count(*) from raw_occurrence_record where created like '2020-10%' and deleted is null union all
select 2020, 11, count(*) from raw_occurrence_record where created like '2020-11%' and deleted is null union all
select 2020, 12, count(*) from raw_occurrence_record where created like '2020-12%' and deleted is null union all 
select 2021, 01, count(*) from raw_occurrence_record where created like '2021-01%' and deleted is null union all
select 2021, 02, count(*) from raw_occurrence_record where created like '2021-02%' and deleted is null union all
select 2021, 03, count(*) from raw_occurrence_record where created like '2021-03%' and deleted is null union all
select 2021, 04, count(*) from raw_occurrence_record where created like '2021-04%' and deleted is null union all
select 2021, 05, count(*) from raw_occurrence_record where created like '2021-05%' and deleted is null union all
select 2021, 06, count(*) from raw_occurrence_record where created like '2021-06%' and deleted is null union all
select 2021, 07, count(*) from raw_occurrence_record where created like '2021-07%' and deleted is null union all
select 2021, 08, count(*) from raw_occurrence_record where created like '2021-08%' and deleted is null union all
select 2021, 09, count(*) from raw_occurrence_record where created like '2021-09%' and deleted is null union all
select 2021, 10, count(*) from raw_occurrence_record where created like '2021-10%' and deleted is null union all
select 2021, 11, count(*) from raw_occurrence_record where created like '2021-11%' and deleted is null union all
select 2021, 12, count(*) from raw_occurrence_record where created like '2021-12%' and deleted is null union all
select 2022, 01, count(*) from raw_occurrence_record where created like '2022-01%' and deleted is null union all
select 2022, 02, count(*) from raw_occurrence_record where created like '2022-02%' and deleted is null union all
select 2022, 03, count(*) from raw_occurrence_record where created like '2022-03%' and deleted is null union all
select 2022, 04, count(*) from raw_occurrence_record where created like '2022-04%' and deleted is null union all
select 2022, 05, count(*) from raw_occurrence_record where created like '2022-05%' and deleted is null union all
select 2022, 06, count(*) from raw_occurrence_record where created like '2022-06%' and deleted is null union all
select 2022, 07, count(*) from raw_occurrence_record where created like '2022-07%' and deleted is null union all
select 2022, 08, count(*) from raw_occurrence_record where created like '2022-08%' and deleted is null union all
select 2022, 09, count(*) from raw_occurrence_record where created like '2022-09%' and deleted is null union all
select 2022, 10, count(*) from raw_occurrence_record where created like '2022-10%' and deleted is null union all
select 2022, 11, count(*) from raw_occurrence_record where created like '2022-11%' and deleted is null union all
select 2022, 12, count(*) from raw_occurrence_record where created like '2022-12%' and deleted is null union all
select 2023, 01, count(*) from raw_occurrence_record where created like '2023-01%' and deleted is null union all
select 2023, 02, count(*) from raw_occurrence_record where created like '2023-02%' and deleted is null union all
select 2023, 03, count(*) from raw_occurrence_record where created like '2023-03%' and deleted is null union all
select 2023, 04, count(*) from raw_occurrence_record where created like '2023-04%' and deleted is null union all
select 2023, 05, count(*) from raw_occurrence_record where created like '2023-05%' and deleted is null union all
select 2023, 06, count(*) from raw_occurrence_record where created like '2023-06%' and deleted is null union all
select 2023, 07, count(*) from raw_occurrence_record where created like '2023-07%' and deleted is null union all
select 2023, 08, count(*) from raw_occurrence_record where created like '2023-08%' and deleted is null union all
select 2023, 09, count(*) from raw_occurrence_record where created like '2023-09%' and deleted is null union all
select 2023, 10, count(*) from raw_occurrence_record where created like '2023-10%' and deleted is null union all
select 2023, 11, count(*) from raw_occurrence_record where created like '2023-11%' and deleted is null union all
select 2023, 12, count(*) from raw_occurrence_record where created like '2023-12%' and deleted is null union all
select 2024, 01, count(*) from raw_occurrence_record where created like '2024-01%' and deleted is null union all
select 2024, 02, count(*) from raw_occurrence_record where created like '2024-02%' and deleted is null union all
select 2024, 03, count(*) from raw_occurrence_record where created like '2024-03%' and deleted is null union all
select 2024, 04, count(*) from raw_occurrence_record where created like '2024-04%' and deleted is null union all
select 2024, 05, count(*) from raw_occurrence_record where created like '2024-05%' and deleted is null union all
select 2024, 06, count(*) from raw_occurrence_record where created like '2024-06%' and deleted is null union all
select 2024, 07, count(*) from raw_occurrence_record where created like '2024-07%' and deleted is null union all
select 2024, 08, count(*) from raw_occurrence_record where created like '2024-08%' and deleted is null union all
select 2024, 09, count(*) from raw_occurrence_record where created like '2024-09%' and deleted is null union all
select 2024, 10, count(*) from raw_occurrence_record where created like '2024-10%' and deleted is null union all
select 2024, 11, count(*) from raw_occurrence_record where created like '2024-11%' and deleted is null union all
select 2024, 12, count(*) from raw_occurrence_record where created like '2024-12%' and deleted is null union all
select 2025, 01, count(*) from raw_occurrence_record where created like '2025-01%' and deleted is null union all
select 2025, 02, count(*) from raw_occurrence_record where created like '2025-02%' and deleted is null union all
select 2025, 03, count(*) from raw_occurrence_record where created like '2025-03%' and deleted is null union all
select 2025, 04, count(*) from raw_occurrence_record where created like '2025-04%' and deleted is null union all
select 2025, 05, count(*) from raw_occurrence_record where created like '2025-05%' and deleted is null union all
select 2025, 06, count(*) from raw_occurrence_record where created like '2025-06%' and deleted is null union all
select 2025, 07, count(*) from raw_occurrence_record where created like '2025-07%' and deleted is null union all
select 2025, 08, count(*) from raw_occurrence_record where created like '2025-08%' and deleted is null union all
select 2025, 09, count(*) from raw_occurrence_record where created like '2025-09%' and deleted is null union all
select 2025, 10, count(*) from raw_occurrence_record where created like '2025-10%' and deleted is null union all
select 2025, 11, count(*) from raw_occurrence_record where created like '2025-11%' and deleted is null union all
select 2025, 12, count(*) from raw_occurrence_record where created like '2025-12%' and deleted is null union all
select 2026, 01, count(*) from raw_occurrence_record where created like '2026-01%' and deleted is null union all
select 2026, 02, count(*) from raw_occurrence_record where created like '2026-02%' and deleted is null union all
select 2026, 03, count(*) from raw_occurrence_record where created like '2026-03%' and deleted is null union all
select 2026, 04, count(*) from raw_occurrence_record where created like '2026-04%' and deleted is null union all
select 2026, 05, count(*) from raw_occurrence_record where created like '2026-05%' and deleted is null union all
select 2026, 06, count(*) from raw_occurrence_record where created like '2026-06%' and deleted is null union all
select 2026, 07, count(*) from raw_occurrence_record where created like '2026-07%' and deleted is null union all
select 2026, 08, count(*) from raw_occurrence_record where created like '2026-08%' and deleted is null union all
select 2026, 09, count(*) from raw_occurrence_record where created like '2026-09%' and deleted is null union all
select 2026, 10, count(*) from raw_occurrence_record where created like '2026-10%' and deleted is null union all
select 2026, 11, count(*) from raw_occurrence_record where created like '2026-11%' and deleted is null union all
select 2026, 12, count(*) from raw_occurrence_record where created like '2026-12%' and deleted is null union all
select 2027, 01, count(*) from raw_occurrence_record where created like '2027-01%' and deleted is null union all
select 2027, 02, count(*) from raw_occurrence_record where created like '2027-02%' and deleted is null union all
select 2027, 03, count(*) from raw_occurrence_record where created like '2027-03%' and deleted is null union all
select 2027, 04, count(*) from raw_occurrence_record where created like '2027-04%' and deleted is null union all
select 2027, 05, count(*) from raw_occurrence_record where created like '2027-05%' and deleted is null union all
select 2027, 06, count(*) from raw_occurrence_record where created like '2027-06%' and deleted is null union all
select 2027, 07, count(*) from raw_occurrence_record where created like '2027-07%' and deleted is null union all
select 2027, 08, count(*) from raw_occurrence_record where created like '2027-08%' and deleted is null union all
select 2027, 09, count(*) from raw_occurrence_record where created like '2027-09%' and deleted is null union all
select 2027, 10, count(*) from raw_occurrence_record where created like '2027-10%' and deleted is null union all
select 2027, 11, count(*) from raw_occurrence_record where created like '2027-11%' and deleted is null union all
select 2027, 12, count(*) from raw_occurrence_record where created like '2027-12%' and deleted is null union all
select 2028, 01, count(*) from raw_occurrence_record where created like '2028-01%' and deleted is null union all
select 2028, 02, count(*) from raw_occurrence_record where created like '2028-02%' and deleted is null union all
select 2028, 03, count(*) from raw_occurrence_record where created like '2028-03%' and deleted is null union all
select 2028, 04, count(*) from raw_occurrence_record where created like '2028-04%' and deleted is null union all
select 2028, 05, count(*) from raw_occurrence_record where created like '2028-05%' and deleted is null union all
select 2028, 06, count(*) from raw_occurrence_record where created like '2028-06%' and deleted is null union all
select 2028, 07, count(*) from raw_occurrence_record where created like '2028-07%' and deleted is null union all
select 2028, 08, count(*) from raw_occurrence_record where created like '2028-08%' and deleted is null union all
select 2028, 09, count(*) from raw_occurrence_record where created like '2028-09%' and deleted is null union all
select 2028, 10, count(*) from raw_occurrence_record where created like '2028-10%' and deleted is null union all
select 2028, 11, count(*) from raw_occurrence_record where created like '2028-11%' and deleted is null union all
select 2028, 12, count(*) from raw_occurrence_record where created like '2028-12%' and deleted is null union all
select 2029, 01, count(*) from raw_occurrence_record where created like '2029-01%' and deleted is null union all
select 2029, 02, count(*) from raw_occurrence_record where created like '2029-02%' and deleted is null union all
select 2029, 03, count(*) from raw_occurrence_record where created like '2029-03%' and deleted is null union all
select 2029, 04, count(*) from raw_occurrence_record where created like '2029-04%' and deleted is null union all
select 2029, 05, count(*) from raw_occurrence_record where created like '2029-05%' and deleted is null union all
select 2029, 06, count(*) from raw_occurrence_record where created like '2029-06%' and deleted is null union all
select 2029, 07, count(*) from raw_occurrence_record where created like '2029-07%' and deleted is null union all
select 2029, 08, count(*) from raw_occurrence_record where created like '2029-08%' and deleted is null union all
select 2029, 09, count(*) from raw_occurrence_record where created like '2029-09%' and deleted is null union all
select 2029, 10, count(*) from raw_occurrence_record where created like '2029-10%' and deleted is null union all
select 2029, 11, count(*) from raw_occurrence_record where created like '2029-11%' and deleted is null union all
select 2029, 12, count(*) from raw_occurrence_record where created like '2029-12%' and deleted is null union all
select 2030, 01, count(*) from raw_occurrence_record where created like '2030-01%' and deleted is null union all
select 2030, 02, count(*) from raw_occurrence_record where created like '2030-02%' and deleted is null union all
select 2030, 03, count(*) from raw_occurrence_record where created like '2030-03%' and deleted is null union all
select 2030, 04, count(*) from raw_occurrence_record where created like '2030-04%' and deleted is null union all
select 2030, 05, count(*) from raw_occurrence_record where created like '2030-05%' and deleted is null union all
select 2030, 06, count(*) from raw_occurrence_record where created like '2030-06%' and deleted is null union all
select 2030, 07, count(*) from raw_occurrence_record where created like '2030-07%' and deleted is null union all
select 2030, 08, count(*) from raw_occurrence_record where created like '2030-08%' and deleted is null union all
select 2030, 09, count(*) from raw_occurrence_record where created like '2030-09%' and deleted is null union all
select 2030, 10, count(*) from raw_occurrence_record where created like '2030-10%' and deleted is null union all
select 2030, 11, count(*) from raw_occurrence_record where created like '2030-11%' and deleted is null union all
select 2030, 12, count(*) from raw_occurrence_record where created like '2030-12%' and deleted is null ;

update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-01-01' and deleted is null) where year = 2012 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-02-01' and deleted is null) where year = 2013 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-03-01' and deleted is null) where year = 2013 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-04-01' and deleted is null) where year = 2013 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-05-01' and deleted is null) where year = 2013 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-06-01' and deleted is null) where year = 2013 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-07-01' and deleted is null) where year = 2013 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-08-01' and deleted is null) where year = 2013 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-09-01' and deleted is null) where year = 2013 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-10-01' and deleted is null) where year = 2013 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-11-01' and deleted is null) where year = 2013 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-12-01' and deleted is null) where year = 2013 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-01-01' and deleted is null) where year = 2013 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-02-01' and deleted is null) where year = 2014 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-03-01' and deleted is null) where year = 2014 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-04-01' and deleted is null) where year = 2014 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-05-01' and deleted is null) where year = 2014 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-06-01' and deleted is null) where year = 2014 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-07-01' and deleted is null) where year = 2014 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-08-01' and deleted is null) where year = 2014 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-09-01' and deleted is null) where year = 2014 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-10-01' and deleted is null) where year = 2014 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-11-01' and deleted is null) where year = 2014 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-12-01' and deleted is null) where year = 2014 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-01-01' and deleted is null) where year = 2014 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-02-01' and deleted is null) where year = 2015 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-03-01' and deleted is null) where year = 2015 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-04-01' and deleted is null) where year = 2015 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-05-01' and deleted is null) where year = 2015 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-06-01' and deleted is null) where year = 2015 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-07-01' and deleted is null) where year = 2015 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-08-01' and deleted is null) where year = 2015 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-09-01' and deleted is null) where year = 2015 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-10-01' and deleted is null) where year = 2015 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-11-01' and deleted is null) where year = 2015 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-12-01' and deleted is null) where year = 2015 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-01-01' and deleted is null) where year = 2015 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-02-01' and deleted is null) where year = 2016 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-03-01' and deleted is null) where year = 2016 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-04-01' and deleted is null) where year = 2016 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-05-01' and deleted is null) where year = 2016 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-06-01' and deleted is null) where year = 2016 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-07-01' and deleted is null) where year = 2016 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-08-01' and deleted is null) where year = 2016 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-09-01' and deleted is null) where year = 2016 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-10-01' and deleted is null) where year = 2016 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-11-01' and deleted is null) where year = 2016 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-12-01' and deleted is null) where year = 2016 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-01-01' and deleted is null) where year = 2016 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-02-01' and deleted is null) where year = 2017 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-03-01' and deleted is null) where year = 2017 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-04-01' and deleted is null) where year = 2017 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-05-01' and deleted is null) where year = 2017 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-06-01' and deleted is null) where year = 2017 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-07-01' and deleted is null) where year = 2017 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-08-01' and deleted is null) where year = 2017 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-09-01' and deleted is null) where year = 2017 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-10-01' and deleted is null) where year = 2017 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-11-01' and deleted is null) where year = 2017 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-12-01' and deleted is null) where year = 2017 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-01-01' and deleted is null) where year = 2017 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-02-01' and deleted is null) where year = 2018 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-03-01' and deleted is null) where year = 2018 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-04-01' and deleted is null) where year = 2018 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-05-01' and deleted is null) where year = 2018 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-06-01' and deleted is null) where year = 2018 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-07-01' and deleted is null) where year = 2018 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-08-01' and deleted is null) where year = 2018 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-09-01' and deleted is null) where year = 2018 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-10-01' and deleted is null) where year = 2018 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-11-01' and deleted is null) where year = 2018 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-12-01' and deleted is null) where year = 2018 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-01-01' and deleted is null) where year = 2018 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-02-01' and deleted is null) where year = 2019 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-03-01' and deleted is null) where year = 2019 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-04-01' and deleted is null) where year = 2019 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-05-01' and deleted is null) where year = 2019 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-06-01' and deleted is null) where year = 2019 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-07-01' and deleted is null) where year = 2019 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-08-01' and deleted is null) where year = 2019 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-09-01' and deleted is null) where year = 2019 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-10-01' and deleted is null) where year = 2019 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-11-01' and deleted is null) where year = 2019 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-12-01' and deleted is null) where year = 2019 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-01-01' and deleted is null) where year = 2019 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-02-01' and deleted is null) where year = 2020 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-03-01' and deleted is null) where year = 2020 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-04-01' and deleted is null) where year = 2020 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-05-01' and deleted is null) where year = 2020 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-06-01' and deleted is null) where year = 2020 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-07-01' and deleted is null) where year = 2020 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-08-01' and deleted is null) where year = 2020 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-09-01' and deleted is null) where year = 2020 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-10-01' and deleted is null) where year = 2020 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-11-01' and deleted is null) where year = 2020 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-12-01' and deleted is null) where year = 2020 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-01-01' and deleted is null) where year = 2020 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-02-01' and deleted is null) where year = 2021 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-03-01' and deleted is null) where year = 2021 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-04-01' and deleted is null) where year = 2021 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-05-01' and deleted is null) where year = 2021 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-06-01' and deleted is null) where year = 2021 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-07-01' and deleted is null) where year = 2021 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-08-01' and deleted is null) where year = 2021 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-09-01' and deleted is null) where year = 2021 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-10-01' and deleted is null) where year = 2021 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-11-01' and deleted is null) where year = 2021 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-12-01' and deleted is null) where year = 2021 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-01-01' and deleted is null) where year = 2021 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-02-01' and deleted is null) where year = 2022 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-03-01' and deleted is null) where year = 2022 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-04-01' and deleted is null) where year = 2022 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-05-01' and deleted is null) where year = 2022 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-06-01' and deleted is null) where year = 2022 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-07-01' and deleted is null) where year = 2022 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-08-01' and deleted is null) where year = 2022 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-09-01' and deleted is null) where year = 2022 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-10-01' and deleted is null) where year = 2022 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-11-01' and deleted is null) where year = 2022 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-12-01' and deleted is null) where year = 2022 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-01-01' and deleted is null) where year = 2022 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-02-01' and deleted is null) where year = 2023 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-03-01' and deleted is null) where year = 2023 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-04-01' and deleted is null) where year = 2023 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-05-01' and deleted is null) where year = 2023 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-06-01' and deleted is null) where year = 2023 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-07-01' and deleted is null) where year = 2023 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-08-01' and deleted is null) where year = 2023 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-09-01' and deleted is null) where year = 2023 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-10-01' and deleted is null) where year = 2023 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-11-01' and deleted is null) where year = 2023 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-12-01' and deleted is null) where year = 2023 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-01-01' and deleted is null) where year = 2023 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-02-01' and deleted is null) where year = 2024 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-03-01' and deleted is null) where year = 2024 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-04-01' and deleted is null) where year = 2024 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-05-01' and deleted is null) where year = 2024 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-06-01' and deleted is null) where year = 2024 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-07-01' and deleted is null) where year = 2024 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-08-01' and deleted is null) where year = 2024 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-09-01' and deleted is null) where year = 2024 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-10-01' and deleted is null) where year = 2024 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-11-01' and deleted is null) where year = 2024 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-12-01' and deleted is null) where year = 2024 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-01-01' and deleted is null) where year = 2024 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-02-01' and deleted is null) where year = 2025 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-03-01' and deleted is null) where year = 2025 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-04-01' and deleted is null) where year = 2025 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-05-01' and deleted is null) where year = 2025 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-06-01' and deleted is null) where year = 2025 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-07-01' and deleted is null) where year = 2025 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-08-01' and deleted is null) where year = 2025 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-09-01' and deleted is null) where year = 2025 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-10-01' and deleted is null) where year = 2025 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-11-01' and deleted is null) where year = 2025 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-12-01' and deleted is null) where year = 2025 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-01-01' and deleted is null) where year = 2025 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-02-01' and deleted is null) where year = 2026 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-03-01' and deleted is null) where year = 2026 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-04-01' and deleted is null) where year = 2026 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-05-01' and deleted is null) where year = 2026 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-06-01' and deleted is null) where year = 2026 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-07-01' and deleted is null) where year = 2026 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-08-01' and deleted is null) where year = 2026 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-09-01' and deleted is null) where year = 2026 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-10-01' and deleted is null) where year = 2026 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-11-01' and deleted is null) where year = 2026 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-12-01' and deleted is null) where year = 2026 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-01-01' and deleted is null) where year = 2026 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-02-01' and deleted is null) where year = 2027 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-03-01' and deleted is null) where year = 2027 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-04-01' and deleted is null) where year = 2027 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-05-01' and deleted is null) where year = 2027 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-06-01' and deleted is null) where year = 2027 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-07-01' and deleted is null) where year = 2027 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-08-01' and deleted is null) where year = 2027 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-09-01' and deleted is null) where year = 2027 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-10-01' and deleted is null) where year = 2027 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-11-01' and deleted is null) where year = 2027 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-12-01' and deleted is null) where year = 2027 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-01-01' and deleted is null) where year = 2027 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-02-01' and deleted is null) where year = 2028 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-03-01' and deleted is null) where year = 2028 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-04-01' and deleted is null) where year = 2028 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-05-01' and deleted is null) where year = 2028 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-06-01' and deleted is null) where year = 2028 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-07-01' and deleted is null) where year = 2028 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-08-01' and deleted is null) where year = 2028 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-09-01' and deleted is null) where year = 2028 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-10-01' and deleted is null) where year = 2028 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-11-01' and deleted is null) where year = 2028 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-12-01' and deleted is null) where year = 2028 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-01-01' and deleted is null) where year = 2028 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-02-01' and deleted is null) where year = 2029 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-03-01' and deleted is null) where year = 2029 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-04-01' and deleted is null) where year = 2029 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-05-01' and deleted is null) where year = 2029 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-06-01' and deleted is null) where year = 2029 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-07-01' and deleted is null) where year = 2029 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-08-01' and deleted is null) where year = 2029 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-09-01' and deleted is null) where year = 2029 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-10-01' and deleted is null) where year = 2029 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-11-01' and deleted is null) where year = 2029 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-12-01' and deleted is null) where year = 2029 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-01-01' and deleted is null) where year = 2029 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-02-01' and deleted is null) where year = 2030 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-03-01' and deleted is null) where year = 2030 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-04-01' and deleted is null) where year = 2030 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-05-01' and deleted is null) where year = 2030 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-06-01' and deleted is null) where year = 2030 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-07-01' and deleted is null) where year = 2030 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-08-01' and deleted is null) where year = 2030 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-09-01' and deleted is null) where year = 2030 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-10-01' and deleted is null) where year = 2030 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-11-01' and deleted is null) where year = 2030 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-12-01' and deleted is null) where year = 2030 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2031-01-01' and deleted is null) where year = 2030 and month = 12;