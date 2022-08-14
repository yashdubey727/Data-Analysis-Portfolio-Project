select * from rainfall_data

--count the total no of rows
select count(*) from rainfall_data --115 rows

--show data only for 2000,2001
select * from rainfall_data where YEAR in (2000,2001)

--average  rainfall in jan = 19.76 vs in june = 168.36
select round(avg(JUN),2) avg_rainfall, round(avg(JAN),2) as avg_rainfall from rainfall_data 

-- add a column of average rainfall 
alter table rainfall_data add avg_rainfall int

--show the top 10 years with highest rainfall
select top 10 YEAR from rainfall_data order by ANNUAL desc 

--show the top 10 years with lowest rainfall
select top 10 YEAR from rainfall_data order by ANNUAL asc

-- show the top 3 and bottom 3 years in a single table
create table topnbottom
(
	years int,
	annual_rainfall int
)

insert into topnbottom select top 3 YEAR,annual from rainfall_data order by ANNUAL desc
insert into topnbottom select top 3 YEAR,annual from rainfall_data order by ANNUAL 

select * from topnbottom
drop table topnbottom 

--performing above operation using union 
--remember while using union the no of rows and the datatype should be the same  
select * from (select top 3 YEAR,annual from rainfall_data order by ANNUAL desc) as a
union 
select * from (select top 3 YEAR,annual from rainfall_data order by ANNUAL ) as b
order by annual 

--calculate the average annual rainfall after 2000 = 1114.4
select avg(annual) as avg_annual from rainfall_data where year>2000

with newtable as
(
	select * from topnbottom 
)
select * from newtable

alter table newtable add  statuss nvarchar(255) 


select * from rainfall_data
select * from dataset 

--joining both the tables
select * from rainfall_data as a 
inner join dataset as b on a.year = b.year

with joined_table as 
(
select a.year yr,a.jun,b.jul as bj,a.jul as aj,annual,jan,feb,mar,may from rainfall_data as a 
inner join dataset as b on a.year = b.year 
) 
select yr,round(jun,0) jun,bj,aj,round(((aj-bj)/bj)*100,2) as diff_percent,annual,jan from joined_table
--don't use select * in the subquery but write the names of columns u want else u will recieve an error


