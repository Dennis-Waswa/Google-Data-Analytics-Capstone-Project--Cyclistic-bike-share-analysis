# Setting working directory
getwd()
#setwd()
#Install packages

#install.packages("readr")
install.packages("tidyverse")
install.packages("tidyr")
install.packages("dplyr")
install.packages("lubridate")
install.packages("skimr")
install.packages("janitor")
install.packages("data.table")
install.packages("mapview")

# Load Packages
#library(readr)
library(tidyverse)
library(tidyr)
library(dplyr)
library(lubridate)
library(skimr)
library(janitor)
library(data.table)
library(mapview)


#import data sets for the last 12 months(August 2021-July 2022)
aug08_df <- read_csv("202108-divvy-tripdata.csv") 
sep09_df <- read_csv("202109-divvy-tripdata.csv") 
oct10_df <- read_csv("202110-divvy-tripdata.csv")
nov11_df <- read_csv("202111-divvy-tripdata.csv") 
dec12_df <- read_csv("202112-divvy-tripdata.csv")
jan01_df <- read_csv("202201-divvy-tripdata.csv") 
feb02_df <- read_csv("202202-divvy-tripdata.csv") 
mar03_df <- read_csv("202203-divvy-tripdata.csv")
apr04_df <- read_csv("202204-divvy-tripdata.csv")
may05_df <- read_csv("202205-divvy-tripdata.csv") 
jun06_df <- read_csv("202206-divvy-tripdata.csv") 
jul07_df <- read_csv("202207-divvy-tripdata.csv") 

#merge all of the data frames into one 
cyclistic_df <- rbind (aug08_df, sep09_df, oct10_df, nov11_df, dec12_df, jan01_df, feb02_df, mar03_df, apr04_df, may05_df, jun06_df, jul07_df)

#Understanding our data 
glimpse(cyclistic_df) #Rows: 5,901,463 and Columns: 13
head(cyclistic_df) #see the first 6 rows of the data frame
tail(cyclistic_df) #see the last 6 rows of the data frame
dim(cyclistic_df) #dimensions of the data frame
colnames(cyclistic_df)

#Data cleaning 
sum(is.na(cyclistic_df))#check for nulls (3572542 null values)

bike_data <- na.omit(cyclistic_df)#Dropping the missing values from the data set
#check again after dropping missing values 
sum(is.na(bike_data))
skimr::skim_without_charts(bike_data) 
glimpse(bike_data)
head(bike_data)

#remove unused columns and duplicates 
bike_data <- bike_data %>% select(-c(start_station_id, end_station_id))#  start_lat, start_lng, end_lat, end_lng))
bike_data <- distinct(bike_data) #remove duplicate rows 
glimpse(bike_data) #11 columns remain 


#Create additional columns like date, day, week, month for analysis 
bike_data$date <- as.Date(bike_data$ started_at)
bike_data$day <- format(as.Date(bike_data$date), "%D")
bike_data$week_day <- format(as.Date(bike_data$date), "%A")
bike_data$month <- format(as.Date(bike_data$date), "%b_%y")
bike_data$year<-format(bike_data$date,"%Y")
glimpse(bike_data) #Rows: 4,629,230 Columns: 16

#calculate trip duration in minutes. 
#Create a column for duration of rides calculated from start and end time of rides.

bike_data$trip_duration_minutes <- as.double(difftime(bike_data$ended_at,bike_data$started_at))/60
glimpse(bike_data) #17 columns(trip_duration_minutes added)

#remove negative trip duration time
bike_data <- bike_data[!(bike_data$trip_duration_minutes <= 0),] 

glimpse(bike_data) #rows reduced from 4,629,230 to  4,628,957

summary(bike_data) #to check the summarized details of the clean data frame
skimr::skim_without_charts(bike_data)
# Descriptive analysis on trip duration (all figures in minutes)

mean(bike_data$trip_duration_minutes) #straight average (trip_duration_minutes/ rides) 18.50598
median(bike_data$trip_duration_minutes) #midpoint number in the ascending array of trip_duration_minutes 11.21667
max(bike_data$trip_duration_minutes) #longest ride 41629.17
min(bike_data$trip_duration_minutes) #shortest ride 0.01666667 
summary(bike_data$trip_duration_minutes)

#Total number of customers by membership details
view(table(bike_data$member_casual)) #casual <-1949253(42.1%)#member <- 2679704(57.1%)

#compare members and casual members (descriptive comparison)
bike_data %>% 
  group_by(member_casual) %>%
  summarise(average_ride_length = mean(trip_duration_minutes), median_length = median(trip_duration_minutes), 
            max_ride_length = max(trip_duration_minutes), min_ride_length = min(trip_duration_minutes))
# A tibble: 2 x 5
#member_casual average_ride_length median_length max_ride_length min_ride_length
#<chr>                       <dbl>         <dbl>           <dbl>           <dbl>
#  1 casual                       26.6         15.1           41629.          0.0167
#2 member                       12.6          9.17           1493.          0.0167

# See the average ride time by each day for members vs casual users
aggregate(bike_data$trip_duration_minutes ~ bike_data$member_casual + bike_data$week_day, FUN = mean)
#bike_data$member_casual bike_data$week_day bike_data$trip_duration_minutes
#1                   casual             Sunday                        30.62619
#2                   member             Sunday                        14.34391
#3                   casual             Monday                        27.66440
#4                   member             Monday                        12.21676
#5                   casual            Tuesday                        23.20272
#6                   member            Tuesday                        11.75266
#7                   casual          Wednesday                        22.80599
#8                   member          Wednesday                        11.88951
#9                   casual           Thursday                        23.41151
#10                  member           Thursday                        12.06414
#11                  casual             Friday                        24.66222
#12                  member             Friday                        12.25425
#13                  casual           Saturday                        29.03979
#14                  member           Saturday                        14.22411

# Notice that the days of the week are out of order. Let's fix that.
bike_data$week_day <- ordered(bike_data$week_day, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"))
aggregate(bike_data$trip_duration_minutes ~ bike_data$member_casual + bike_data$week_day, FUN = mean)

# visualizing total number of rides
bike_data%>% group_by(member_casual)%>% summarise(n=n())%>% 
  mutate(percent = n*100/sum(n)) #percentages 
ggplot(data = bike_data,mapping= aes(x= member_casual)) +geom_bar() + labs(title="Count Member Vs Casual")
#visualized bike tpye preferrence 
bike_data%>% group_by(rideable_type) %>% summarise(n=n())%>% 
  mutate(percent = n*100/sum(n))
#1 classic_bike  3048843   65.9 
#2 docked_bike    224943    4.86
#3 electric_bike 1355171   29.3 
ggplot(data = bike_data,mapping= aes(x= rideable_type,fill=rideable_type)) +geom_bar() + labs(title="count of Bike Types used")

#Daily rides of members and casual riders

ggplot(data = bike_data,mapping= aes(x= week_day, fill = member_casual)) +geom_bar() +facet_wrap(~member_casual)+theme(axis.text.x = element_text(angle = 60, hjust =1))

#Rides per week for both members and casual riders 

bike_data %>%  
  group_by(member_casual, week_day) %>% 
  summarise(number_of_rides = n(), .groups="drop") %>% 
  arrange(member_casual, week_day) %>% 
  ggplot(aes(x = week_day, y = number_of_rides, fill = member_casual)) +
  labs(title ="total rides per week(member_casual)") +
  geom_col(width=0.5, position = position_dodge(width=0.5)) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

#rides per month for both members and casual riders 

bike_data %>%  
  group_by(member_casual, month) %>% 
  summarise(number_of_rides = n(), .groups="drop") %>% 
  arrange(member_casual, month) %>% 
  ggplot(aes(x = month, y = number_of_rides, fill = member_casual)) +
  labs(title ="total rides per month(member_casual)") +
  geom_col(width=0.5, position = position_dodge(width=0.5)) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

bike_data %>%
  group_by(rideable_type, member_casual) %>%
  dplyr::summarize(count_trips = n()) %>%  
  ggplot(aes(x= rideable_type, y=count_trips, fill=member_casual, color=member_casual)) +
  geom_bar(stat='identity', position = 'dodge') +
  theme_bw()+
  labs(title ="Count Bicycle Type Number by type of rider", x = "Bicycle Type", y = "Count")
#--------------stations---------------#
location_df = bike_data %>% 
  select(
    ride_id, start_station_name, end_station_name, start_lat, start_lng,
    end_lat, end_lng, member_casual, trip_duration_minutes
  ) %>% 
  drop_na(
    start_station_name, end_station_name
  )
head(location_df, 10)

#-----start station------#
start_station_df = location_df %>% 
  group_by(
    member_casual, start_station_name, start_lat, start_lng
  ) %>% 
  summarise(
    nr_rides_start = n()
  ) %>% 
  arrange(-nr_rides_start)
#popular start stations
head(start_station_df)
#Visualize top start stations 
start_station_df[1:10, ] %>% 
  ggplot(aes(start_station_name, nr_rides_start, fill = member_casual))+
  geom_col(position = "dodge")+
  coord_flip()+
  labs(
    title = "Most Popular Start Stations",
    subtitle = "Top 10 most popular start stations",
    x = "station name",
    y = "number of trips"
  )+
  theme()
#---------end station----------#
end_station_df = location_df %>% 
  group_by(
    member_casual, end_station_name, end_lat, end_lng
  ) %>% 
  summarise(
    nr_rides_end = n()
  ) %>% 
  arrange(-nr_rides_end)

head(end_station_df)
#visualize popular end stations
end_station_df[1:10,] %>% 
  ggplot(aes(end_station_name, nr_rides_end, fill = member_casual))+
  geom_col(position = "dodge")+
  coord_flip()+
  labs(
    title = "Most Popular End Stations",
    subtitle = "Top 10 most popular end stations",
    x = "station name",
    y = "number of trips"
  )+
  theme()
#TOP 20 start stations
start_station_df[1:20, ] %>%
  mapview(
    xcol = "start_lng", 
    ycol = "start_lat",
    cex = "nr_rides_start",
    alpha = 0.9, 
    crs = 4269,
    color = "#8b0000",
    grid = F, 
    legend = T,
    layer.name = "20 Most Popular Start Stations"
  )
#top 20 end stations 
end_station_df[1:20,] %>% 
  mapview(
    xcol = "end_lng",
    ycol = "end_lat",
    cex = "nr_rides_end", # size of circle based on value size
    alpha = 0.9,
    crs = 4269,
    color = "#8b0000",
    grid = F,
    legend = T,
    layer.name = "20 Most Popular End Stations"
  )
#write.csv(bike_data, file = 'C:/Users/Dennis Waswa/OneDrive - IMC/Desktop/Bike_project/bike_data.csv', row.names = FALSE)

