# Google-Data-Analytics-Capstone-Project--Cyclistic-bike-share-analysis
This Github repository contains my analysis of the Cyclistic capstone project from the This site was built using [Google Data Analytics Professional Course.
](https://www.coursera.org/professional-certificates/google-data-analytics).

## About the company 
In 2016, Cyclistic launched a successful bike-share offering. Since then, the program has grown to a fleet of more than 5,800 bicycles that are geotracked and locked into a network of more than 600 stations across Chicago. The bikes can be unlocked from one station and returned to any other station in the system anytime.
Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are Cyclistic members.
Cyclistic’s finance analysts have concluded that annual members are much more profitable than casual riders. Although the pricing flexibility helps Cyclistic attract more customers, the director of marketing believes that maximizing the number of annual members will be key to future growth. 
## Data analysis steps
Ask, Prepare, Process, Analyze, Share, Act
### 1.	Ask 
Key tasks
1. Identify the business objective and task
Business objective 
To increase profits by converting casual riders to annual members via a targeted marketing campaign 
Business task 
To Analyse bike usage patterns for annual members and casual rides 
### 2.	Prepare 
Key tasks
1. Download data and store it appropriately.
2. Identify how it’s organized.
3. Sort and filter the data.
The data used in this project was obtained from Motivate, a company employed by the City of Chicago to collect data on bike share usage. Here is the [link](https://divvy-tripdata.s3.amazonaws.com/index.html) for the datasets. 
The data is organized in monthly .csv files. The most recent twelve months of data (August 2021 – July 2022) will be used for this project. I download data from specified months and then combined them into a single worksheet in excel.
Data credibility was determined using the ROCCC criteria, 
Reliable – The data is complete and collected directly by Motivate International Inc, it is under this [license](https://ride.divvybikes.com/data-license-agreement) 
Original - Original public data is used as collected by Motivate International Inc.
Comprehensive - The data is comprehensive in that it consists of data for all the rides taken on the system and is not just a sample of the data.
Current - yes, the data is updated monthly
Cited – yes
### 3.	Process
Key tasks
1.	Choose tools to use
2.	Check the data for errors.
3.	Check for nulls and missing values 
I used Rstudio for combining all data into one .csv sheet, data wrangling, descriptive analysis, and initial visualizations because Rstudio is versatile and can handle huge datasets. 
### 4.	Analysis 
Key tasks
1. Aggregate data so it’s useful and accessible.
2. Organize and format data.
3. Perform calculations.
4. Identify trends and relationships.
Key findings 
I.	Members make 58% of total rides while casual riders take 43%
II.	Both members and casual riders have the same monthly trends, High peak months start in May and steadily increase through October. This suggests bikes are used more during the summer months because we have the lowest number of riders between January and April 
III.	Members take trips more evenly throughout the week with a notable increase between Tuesday and Thursday while casual riders use bikes more on weekends with Sundays registering the hights numbers. 
IV.	Riders start using the bikes around 4 am but we note that members have a high pick between 6 and 7 am and between 17 pm and 18 pm suggesting they probably use the bikes mainly.  17 pm is the time with the highest number of riders. 
V.	Classic bikes are the most used (66%) followed by electric bikes (29%) while docker bikes are used (5%) and by casual riders only. 
VI.	On average casual riders use the bikes longer (27 minutes) while members (13 minutes). 
VII.	Trip duration typically corresponds to the number of rides. 
### 5.	Share 
Key tasks
1. Determine the best way to share your findings.
2. Create effective data visualizations.
3. Present your findings.
I used tableau for visualization as it can handle vast volumes of data efficiently and it is intuitive. 
### 6.	Act
## Recommendations 
1.	Have a pricing plan that targets the high pick months. A summer-only member offer from May to October instead of the annual memberships. This can also be done for the high pick hours and weekends. 
2.	Marketing campaigns should focus on the high peak months (May-October), busy hours(afternoon), High peak hours (17 pm), and weekends. Possibly offer discounts in this period. 
3.	Increase renting prices for casual riders during peak hours, days, or months to entice them into getting an annual membership. Or rather offer discounts during the pick periods for casual riders who would want to convert to members.
4.	Offer free weekend rides for 1 extra person (friend or family) for every rider who is a member to encourage casual riders to become members.   
5.	Collecting data about the kind of riders would give more insight into the riders, for example, they can add additional columns to check if riders are Tourists or local, male or female, or age brackets which can play a big part in customizing advertising. 
6.	Have marketing fliers or posters in strategically the top start and end stations for wider reachability. 
