# Google Data Analytics Capstone Case Study
Course: [Google Data Analytics Capstone: Complete a Case Study](https://www.coursera.org/learn/google-data-analytics-capstone)

### Introduction

In this case study, I perform the role of a junior data analyst at a fictional company, Cyclistic - a bike-share company in Chicago. The company's business goal is to increase the number of annual members. To achieve this, the marketing team believes there is a great opportunity to convert casual riders into annual members. This project analyzes trip data of a whole year to understand the behavioral differences between these two rider types. The insights from this analysis will be used to design a data-driven marketing strategy. The data for this project is public data provided by [Divvy](https://divvy-tripdata.s3.amazonaws.com/index.html) for the period of January to December 2024, and it is made available under this [license](https://www.divvybikes.com/data-license-agreement).

The analysis uses the following 12 monthly data files:

* 202401-divvy-tripdata
* 202402-divvy-tripdata
* 202403-divvy-tripdata
* 202404-divvy-tripdata
* 202405-divvy-tripdata
* 202406-divvy-tripdata
* 202407-divvy-tripdata
* 202408-divvy-tripdata
* 202409-divvy-tripdata
* 202410-divvy-tripdata
* 202411-divvy-tripdata
* 202412-divvy-tripdata

### Project Overview

Cyclistic is a bike-share program that launched in 2016. Since then, the program has grown to a fleet of more than 5,800 bicycles that are geotracked and locked into a network of over 600 docking stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime. Cyclistic sets itself apart by also offering reclining bikes, hand tricycles, and cargo bikes, making bike-share more inclusive to people with disabilities and riders who can’t use a standard two-wheeled bike. The majority of riders opt for traditional bikes. While Cyclistic users are more likely to ride for leisure, about 30% of them use the bikes to commute to work each day.

Until now, Cyclistic’s marketing strategy has focused on building general brand awareness. The company offers flexible pricing plans, including single-ride passes, full-day passes, and annual memberships. Customers who purchase single-ride or full-day passes are referred to as casual riders, while those who purchase annual memberships are Cyclistic members.

The company's finance analysts have concluded that annual members are significantly more profitable than casual riders. To drive future growth, the director of marketing, Moreno, believes there is a great opportunity to convert casual riders into annual members. She notes that casual riders are already aware of the program and have chosen Cyclistic for their mobility needs.

Moreno has set a clear goal: to design marketing strategies aimed at converting casual riders into annual members. To do this, the marketing team needs to better understand how annual members and casual riders differ, why casual riders might buy a membership, and how digital media could be used to influence their decisions. The team will analyze historical bike trip data to identify these trends.

### Project Scenario

I am a junior data analyst working on the marketing analyst team at Cyclistic, a bike-share company in Chicago. The director of marketing believes that the company's future success depends on maximizing the number of annual memberships. Therefore, my team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights, my team will design a new marketing strategy to convert casual riders into annual members. But first, Cyclistic executives must approve my recommendations, so they must be backed up with compelling data insights and professional data visualizations.

### Analysis Questions

Three questions will guide the future marketing program:

1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

### Analysis Process

### Process

BigQuery was used to manage, combine, and clean the data. As the dataset contained over 5 million rows, using a platform like BigQuery was essential for handling the large volume of data efficiently.

The following steps were performed to prepare the data for analysis:

* **Combining Data:** All 12 monthly CSV files were combined into a single table.
* **Data Cleaning and Transformation:** SQL queries were used to remove rows with missing values, and new columns were created for trip duration, day of the week, and month to aid in the analysis.
* **Primary Key:** The `ride_id` was identified as the primary key, and it was used to check for and remove any duplicate rows.
  
You can find the complete SQL script for these steps in the [SQL Queries](sql/data_cleaning_and_transformation.sql) section of this repository.
