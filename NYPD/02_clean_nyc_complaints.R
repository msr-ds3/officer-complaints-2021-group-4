
library(tidyverse)
library(lubridate)
library(dplyr)


#reading in the data
nypd_data <- read.csv("NYPD_data.csv", header = TRUE, sep = ",")

#cleaning the data to consist of only complaints from 2007-2017 
nypd_data<-nypd_data%>%
  mutate(ReceivedDate = as.Date(ReceivedDate, "%m/%d/%Y"))%>%
  filter(ReceivedDate >= "2007-01-01" & ReceivedDate < "2018-01-01")

save(nypd_data, file = 'nypd_data.RData')