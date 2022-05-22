-- Write an SQL query to fetch the following monthly metrics from the dataset for the:
 

-- 1) The average number of trips on Saturdays

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
  
  
  
-- 2)The average fare (fare_amount) per trip on Saturdays

select avg(fare_amount) as "avg_fare_amount_per_trip", "day_name"
from
(select "fare_amount", "day_name"
from
(select "fare_amount", "tpep_dropoff_datetime", to_char(tpep_dropoff_datetime, 'Day') as "day_name"
from "yellow_tripdata_2015-01") as nt
where "day_name" like 'Satur%') as nt2
group by 2
order by 1



-- 3)  The average duration per trip on Saturdays

select avg(time_diff) as "avg_duration_per_trip", "day_name"
 from
 (select *
 from
 (select "VendorID", to_char(tpep_dropoff_datetime, 'day') as "day_name", "time_diff"
 from
 (select "VendorID", "tpep_dropoff_datetime", (tpep_dropoff_datetime - tpep_pickup_datetime) as time_diff
 from "yellow_tripdata_2015-01") as t1) as t2
 where "day_name" like 'satur%') as t3
 group by 2
 order by 2 desc;
 
--  OR


select avg(time_diff) as "avg_duration_per_trip", "trip_distance"
from
(select *
from
(select "VendorID", "trip_distance", "time_diff", to_char(tpep_dropoff_datetime, 'day') as "day_name"
from
(select "VendorID", "trip_distance", "tpep_dropoff_datetime", (tpep_dropoff_datetime - tpep_pickup_datetime) as time_diff
from "yellow_tripdata_2015-01") as t1) as t2
where "day_name" like 'satur%') as t3
group by 2
order by 1 DESC ;






-- 4) The average number of trips on Sundays

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


-- 5) The average fare (fare_amount) per trip on Sundays


select avg(fare_amount) as "avg_fare_amount"
from
(select "fare_amount", "tpep_dropoff_datetime", "trip_distance", to_char("tpep_dropoff_datetime", 'day') as "day_name"
from  "yellow_tripdata_2015-01") as ttt
where "day_name" like 'sun%'

--   OR
 
select avg(fare_amount) as "avgfaramt","trip_distance", "tpep_dropoff_datetime", "day_name"
from
(select "fare_amount", "tpep_dropoff_datetime", "trip_distance", to_char("tpep_dropoff_datetime", 'day') as "day_name"
 from  "yellow_tripdata_2015-01") as mm
where "day_name" like 'sun%'
 group by 2, 3, 4
 order by 3 desc
 
 

 

 
