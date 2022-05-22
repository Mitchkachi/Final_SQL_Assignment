-- Write an SQL query to fetch the following monthly metrics from the dataset for the:
 

-- 1) The average number of trips on Saturdays

--  this returns total count of the average number of records per trip on saturdays

select "day_name", count(avg_trip_distance) as "total_count_of_avg_trips"
from
(select "avg_trip_distance", "tpep_dropoff_datetime", "day_name"
from
(select avg("trip_distance") as "avg_trip_distance", "tpep_dropoff_datetime", "day_name"
from
(select "trip_distance", "tpep_dropoff_datetime", to_char(tpep_dropoff_datetime, 'Day') as "day_name"
from "yellow_tripdata_2015-01") as "days"
group by "tpep_dropoff_datetime", "day_name"
 order by "avg_trip_distance" desc) as tab
  where "day_name" like 'Satur%'
  group by 1, 2, 3) as tab2
  group by 1
  
  
  
--   or

--  this returns average number of records per trip on saturdays

select "avg_trip_distance", "day_name", "tpep_dropoff_datetime"
from
(select avg("trip_distance") as "avg_trip_distance", "tpep_dropoff_datetime", "day_name"
from
(select "trip_distance", "tpep_dropoff_datetime", to_char(tpep_dropoff_datetime, 'Day') as "day_name"
from "yellow_tripdata_2015-01") as "days"
group by "tpep_dropoff_datetime", "day_name"
 order by "avg_trip_distance" desc) as tab
  where "day_name" like 'Satur%'
  order by 1 desc


  
  
  
-- 2)The average fare (fare_amount) per trip on Saturdays

--  this returns average fare_amount of the total num of trips on saturdays

select avg(fare_amount) as "avg_fare_amount_per_trip", "day_name"
from
(select "fare_amount", "day_name"
from
(select "fare_amount", "tpep_dropoff_datetime", to_char(tpep_dropoff_datetime, 'Day') as "day_name"
from "yellow_tripdata_2015-01") as nt
where "day_name" like 'Satur%') as nt2
group by 2
order by 1


-- or

--  this returns average fare_amount per trip on saturdays

select avg(fare_amount) as "avg_fare_amount_per_trip", "day_name", "tpep_dropoff_datetime"  
from
(select "fare_amount", "day_name", "tpep_dropoff_datetime"
from
(select "fare_amount", "tpep_dropoff_datetime", to_char(tpep_dropoff_datetime, 'Day') as "day_name"
from "yellow_tripdata_2015-01") as nt
where "day_name" like 'Satur%') as nt2
group by 2, 3
order by 1 desc





-- 3)  The average duration per trip on Saturdays

-- this gives the average duration per trip on saturdays in minutes

select avg(df_of_time) as "avg_duration_per_trip_in_minutes", "trip_distance",  "day_name"
from
(select "VendorID", "trip_distance", extract(minute from "time_diff"  ) as "df_of_time", "day_name"
from
(select "VendorID", "trip_distance", "time_diff", to_char(tpep_dropoff_datetime, 'day') as "day_name"
from
(select "VendorID", "trip_distance", "tpep_dropoff_datetime", (tpep_dropoff_datetime - tpep_pickup_datetime) as time_diff
from "yellow_tripdata_2015-01") as t1) as t2
where "day_name" like 'satur%') as t3
group by 2, 3
order by 1 DESC ;

-- or

-- this gives the average duration for all saturdays in the month of January, 2015 in minutes

select avg(df_of_time) as "avg_duration_per_trip", "day_name"
 from
 (select *
 from
 (select "VendorID", to_char(tpep_dropoff_datetime, 'day') as "day_name", extract(minute from "time_diff"  ) as "df_of_time"
 from
 (select "VendorID", "tpep_dropoff_datetime", (tpep_dropoff_datetime - tpep_pickup_datetime) as time_diff
 from "yellow_tripdata_2015-01") as t1) as t2
 where "day_name" like 'satur%') as t3
 group by 2
 order by 2 desc;
 



-- 4) The average number of trips on Sundays

--   this gives an average count of trips per sundays by all yellow taxis

select count(avg_trip_distance) as "avg_no_of_trips", "day_name"
from
(select avg(trip_distance) as "avg_trip_distance", "day_name", "tpep_dropoff_datetime"
from
(select "trip_distance", "tpep_dropoff_datetime", to_char(tpep_dropoff_datetime, 'day') as "day_name"
from "yellow_tripdata_2015-01") as b1
where "day_name" like 'sund%'
group by 2, 3
order by 1) as b2
group by 2
order by 1 desc;


-- or

--  this gives gives an average number of trip by each yellow taxi driver on sundays

select avg(trip_distance) as "avg_trip_distance", "day_name"
from
(select "trip_distance", "tpep_dropoff_datetime", to_char(tpep_dropoff_datetime, 'day') as "day_name"
from "yellow_tripdata_2015-01") as b1
where "day_name" like 'sund%'
group by 2
order by 1;



-- 5) The average fare (fare_amount) per trip on Sundays

-- this gives the average fare_amount for all trips in a sunday

select avg(fare_amount) as "avg_fare_amount", "day_name"
from
(select "fare_amount", "tpep_dropoff_datetime", "trip_distance", to_char("tpep_dropoff_datetime", 'day') as "day_name"
from  "yellow_tripdata_2015-01") as ttt
where "day_name" like 'sun%'
group by 2
order by 1

--   OR

--  this gives the average fare_amount for each trip

select avg(fare_amount) as "avg_fare_amt","trip_distance", "tpep_dropoff_datetime", "day_name"
from
(select "fare_amount", "tpep_dropoff_datetime", "trip_distance", to_char("tpep_dropoff_datetime", 'day') as "day_name"
 from  "yellow_tripdata_2015-01") as mm
where "day_name" like 'sun%'
 group by 2, 3, 4
 order by 2 desc
 
 
 
-- 6)  The average duration per trip on Sundays

--  this gives the average duration in minutes for each trip at different time intervals on sundays

 select avg(dur_of_trip_in_min) as "avg_dur-of_trip_in_min", "day_name", "trip_distance"
 from
 (select extract(minute from "avg_duration_of_trip" ) as "dur_of_trip_in_min", "day_name", "trip_distance"
 from
(select (tpep_dropoff_datetime - tpep_pickup_datetime) as "avg_duration_of_trip", "day_name", "trip_distance"
from
(select "tpep_dropoff_datetime", "tpep_pickup_datetime", "trip_distance", to_char(tpep_dropoff_datetime, 'day') as "day_name"
from  "yellow_tripdata_2015-01") as ttttt
where "day_name" like 'sund%') as ttttt2) as ttttt3
 group by 2, 3
order by 1 desc

-- or

-- this gives the average duration of all trips at differnt time intervals on a particular sunday

 select avg(dur_of_trip_in_min) as "avg_dur-of_trip_in_min", "day_name"
 from
 (select extract(minute from "avg_duration_of_trip" ) as "dur_of_trip_in_min", "day_name"
 from
(select (tpep_dropoff_datetime - tpep_pickup_datetime) as "avg_duration_of_trip", "day_name"
from
(select "tpep_dropoff_datetime", "tpep_pickup_datetime", "trip_distance", to_char(tpep_dropoff_datetime, 'day') as "day_name"
from  "yellow_tripdata_2015-01") as ttttt
where "day_name" like 'sund%') as ttttt2) as ttttt3
 group by 2
order by 1
 
 

 
