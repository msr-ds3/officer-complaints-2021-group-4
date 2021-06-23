
library(tidyverse)
library(lubridate)
library(dplyr)

#reading in the data
nypd_data <- read.csv("NYPD_data.csv", header = TRUE, sep = ",")

#cleaning the data to consist of only complaints from 2007-2017 
nypd_data<-nypd_data%>%
  mutate(ReceivedDate = as.Date(ReceivedDate, "%m/%d/%Y"))%>%
  filter(ReceivedDate >= "2007-01-01" & ReceivedDate < "2018-01-01")


#orgenizing the data into deciles with the percentage of complaints for each decile
nypd_data <- nypd_data%>%
  count(OfficerID)%>% 
  arrange(desc(n))%>%   #count = total complaints per officer
  mutate(percentage_per_officer = n/sum(n))%>%
  mutate(deciles = ntile(n,10))%>%
  group_by(deciles)%>%
  summarize(total_percentage_per_decile = sum(percentage_per_officer))
  
#graphing our results
  ggplot(nypd_data,aes(x= deciles, y = total_percentage_per_decile))+
    geom_histogram(stat = 'identity')+
    ylab("Proportion of complaints") + xlab("Decile")  
 

  
  

 
 
