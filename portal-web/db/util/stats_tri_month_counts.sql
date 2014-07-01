drop table if exists stats_tri_month_counts;

create table stats_tri_month_counts (tri char(100), count int(10));

insert into stats_tri_month_counts values ('dic 2012 - feb 2013', (select sum(count) from stats_month_counts where (year = 2012 and month = 12) or (year = 2013 and month = 01) or (year = 2013 and month = 02)));
insert into stats_tri_month_counts values ('mar 2013 - may 2013', (select sum(count) from stats_month_counts where (year = 2013 and month = 03) or (year = 2013 and month = 04) or (year = 2013 and month = 05)));
insert into stats_tri_month_counts values ('jun 2012 - ago 2013', (select sum(count) from stats_month_counts where (year = 2013 and month = 06) or (year = 2013 and month = 07) or (year = 2013 and month = 08)));
insert into stats_tri_month_counts values ('sep 2012 - nov 2013', (select sum(count) from stats_month_counts where (year = 2013 and month = 09) or (year = 2013 and month = 10) or (year = 2013 and month = 11)));
insert into stats_tri_month_counts values ('dic 2013 - feb 2014', (select sum(count) from stats_month_counts where (year = 2013 and month = 12) or (year = 2014 and month = 01) or (year = 2014 and month = 02)));
insert into stats_tri_month_counts values ('mar 2014 - may 2014', (select sum(count) from stats_month_counts where (year = 2014 and month = 03) or (year = 2014 and month = 04) or (year = 2014 and month = 05)));
