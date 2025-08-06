--Combining Data

--Combining all the 12 months data tables into a single table containing data from Jan 2024 to Dec 2024.

CREATE TABLE `mycapstoneprojects.cyclistic.2024_combined` AS (
  SELECT * FROM `mycapstoneprojects.cyclistic.202401-divvy-tripdata`
    UNION ALL
  SELECT * FROM `mycapstoneprojects.cyclistic.202402-divvy-tripdata`
    UNION ALL
  SELECT * FROM `mycapstoneprojects.cyclistic.202403-divvy-tripdata`
    UNION ALL
  SELECT * FROM `mycapstoneprojects.cyclistic.202404-divvy-tripdata`
    UNION ALL
  SELECT * FROM `mycapstoneprojects.cyclistic.202405-divvy-tripdata`
    UNION ALL
  SELECT * FROM `mycapstoneprojects.cyclistic.202406-divvy-tripdata`
    UNION ALL
  SELECT * FROM `mycapstoneprojects.cyclistic.202407-divvy-tripdata`
    UNION ALL
  SELECT * FROM `mycapstoneprojects.cyclistic.202408-divvy-tripdata`
    UNION ALL
  SELECT * FROM `mycapstoneprojects.cyclistic.202409-divvy-tripdata`
    UNION ALL
  SELECT * FROM `mycapstoneprojects.cyclistic.202410-divvy-tripdata`
    UNION ALL
  SELECT * FROM `mycapstoneprojects.cyclistic.202411-divvy-tripdata`
    UNION ALL
  SELECT * FROM `mycapstoneprojects.cyclistic.202412-divvy-tripdata`
);

--Checking No: Of rows

SELECT COUNT(*)
FROM `mycapstoneprojects.cyclistic.2024_combined`;

--Exploring Data

--Checking The Datatype of All Comes

SELECT 
  column_name,
  data_type,
  FROM 
  `mycapstoneprojects.cyclistic.INFORMATION_SCHEMA.COLUMNS`
WHERE 
  table_name = '2024_combined';

--Cheking for No: of NULL values in all columns

SELECT COUNT(*) - COUNT(ride_id) ride_id,
 COUNT(*) - COUNT(rideable_type) rideable_type,
 COUNT(*) - COUNT(started_at) started_at,
 COUNT(*) - COUNT(ended_at) ended_at,
 COUNT(*) - COUNT(start_station_name) start_station_name,
 COUNT(*) - COUNT(start_station_id) start_station_id,
 COUNT(*) - COUNT(end_station_name) end_station_name,
 COUNT(*) - COUNT(end_station_id) end_station_id,
 COUNT(*) - COUNT(start_lat) start_lat,
 COUNT(*) - COUNT(start_lng) start_lng,
 COUNT(*) - COUNT(end_lat) end_lat,
 COUNT(*) - COUNT(end_lng) end_lng,
 COUNT(*) - COUNT(member_casual) member_casual
FROM `mycapstoneprojects.cyclistic.2024_combined`;

--Checking for duplicate rows

SELECT COUNT(ride_id) - COUNT(DISTINCT ride_id) AS duplicate_rows
FROM `mycapstoneprojects.cyclistic.2024_combined`;

--Creating a Cleaned Dataset

CREATE TABLE IF NOT EXISTS `mycapstoneprojects.cyclistic.2024_cleaned` AS (
  SELECT
    a.ride_id, rideable_type, started_at, ended_at,
     ride_length,
    CASE EXTRACT(DAYOFWEEK FROM started_at)
      WHEN 1 THEN 'SUN'
      WHEN 2 THEN 'MON'
      WHEN 3 THEN 'TUE'
      WHEN 4 THEN 'WED'
      WHEN 5 THEN 'THUR'
      WHEN 6 THEN 'FRI'
      WHEN 7 THEN 'SAT'
   END AS day_of_week,  
   CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'JAN'
      WHEN 2 THEN 'FEB'
      WHEN 3 THEN 'MAR'
      WHEN 4 THEN 'APR'
      WHEN 5 THEN 'MAY'
      WHEN 6 THEN 'JUN'
      WHEN 7 THEN 'JUL'
      WHEN 8 THEN 'AUG'
      WHEN 9 THEN 'SEP'
      WHEN 10 THEN 'OCT'
      WHEN 11 THEN 'NOV'
      WHEN 12 THEN 'DEC'
  END AS month,
  start_station_name, end_station_name, start_lat, start_lng, end_lat, end_lng, member_casual
FROM `mycapstoneprojects.cyclistic.2024_combined` a
JOIN(
  SELECT ride_id, (
    EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
    EXTRACT(MINUTE FROM (ended_at - started_at)) +
    EXTRACT(SECOND FROM (ended_at - started_at)) / 60) AS ride_length
  FROM `mycapstoneprojects.cyclistic.2024_combined`
  ) b
  ON a.ride_id = b.ride_id
  WHERE
  start_station_name IS NOT NULL AND
  end_station_name IS NOT NULL AND
  end_lat IS NOT NULL AND
  end_lng IS NOT NULL AND
  ride_length > 1 AND ride_length < 1440
);

--Setting ride_id as primary key

ALTER TABLE `mycapstoneprojects.cyclistic.2024_cleaned`
ADD PRIMARY KEY(ride_id)NOT ENFORCED;

--Adding month_num column
ALTER TABLE `mycapstoneprojects.cyclistic.2024_cleaned`
ADD COLUMN month_num INT64;

--Populating month_num column with correct values

UPDATE `mycapstoneprojects.cyclistic.2024_cleaned`
SET month_num = EXTRACT(MONTH FROM started_at)
WHERE TRUE;

--Adding week_num column and populating it with correct values

ALTER TABLE `mycapstoneprojects.cyclistic.2024_cleaned`
ADD COLUMN week_num INT64;

UPDATE `mycapstoneprojects.cyclistic.2024_cleaned`
SET week_num = EXTRACT(DAYOFWEEK FROM started_at)
WHERE TRUE;

--Removing Duplicates

CREATE OR REPLACE TABLE `mycapstoneprojects.cyclistic.2024_cleaned` AS (
  SELECT * EXCEPT(row_num)
  FROM (
    SELECT *,
      ROW_NUMBER() OVER (PARTITION BY ride_id ORDER BY started_at) AS row_num
    FROM `mycapstoneprojects.cyclistic.2024_cleaned`
  )
  WHERE row_num = 1
);
