create table fitbitdata(Id  varchar(50),	ActivityDate  varchar(50),	TotalSteps  varchar(50),	TotalDistance  varchar(50),	TrackerDistance  varchar(50),	LoggedActivitiesDistance  varchar(50),	VeryActiveDistance  varchar(50),	ModeratelyActiveDistance  varchar(50),	LightActiveDistance  varchar(50),	SedentaryActiveDistance  varchar(50),	VeryActiveMinutes  varchar(50),	FairlyActiveMinutes  varchar(50),	LightlyActiveMinutes  varchar(50),	SedentaryMinutes  varchar(50),	Calories  varchar(50) )

set sql_safe_updates=0

ALTER TABLE fitbitdata ADD column `new activity date` date after Calories
update fitbitdata set `new activity date` = str_to_date(ActivityDate, '%m/%d/%Y')
alter table fitbitdata drop column ActivityDate;

-------4 . Find out in this data that how many unique id'------------

select distinct (Id) from fitbitdata
select count(distinct (Id)) as count from fitbitdata

----5 . which id is one of the active id that you have in whole datase

select Id, max(SumOfActiveMinutes) as `max active minutes` from (select Id, sum(VeryActiveMinutes) as SumOfActiveMinutes  from fitbitdata group by Id) as sub 

-------6 . how many of them have not logged there activity find out in terms of number of ids------

select count(distinct Id) from fitbitdata where LoggedActivitiesDistance=0

--------7 . Find out who is the laziest person id that we have in dataset------

select Id, min(SumOfCalories) as `min Calories` from (select Id, sum(Calories) as SumOfCalories  from fitbitdata group by Id) as sub 

-------8 . Explore over an internet that how much calories burn is required for a healthy person and find out how many healthy person we have in our dataset-----------

select distinct (Id),Calories from fitbitdata where calories>=2500 group by Id

------9. how many person are not a regular person with respect to activity try to find out those-------

select Id,min(count) as `least active person` from (select Id,count(Id) as count from fitbitdata group by Id) as t2 

---------10 . who is the thired most active person in this dataset find out those in pandas and in sql both------

select Id , min(total_calorie) from (select Id,total_calorie from (select Id, sum(Calories) as total_calorie from fitbitdata group by Id) as sub  ORDER BY total_calorie DESC limit 3) as sub2 

-------11 . who is the 5th most laziest person avilable in dataset find it out ------


select Id,`t1` from (SELECT   Id, sum(Calories) as `t1`
FROM     fitbitdata group by Id) as sub
ORDER BY `t1` AESC
LIMIT    5

------------12 . what is a totla acumulative calories burn for a person find out ---------------
select Id, sum(Calories) as acumulative_calories from fitbitdata group by Id

