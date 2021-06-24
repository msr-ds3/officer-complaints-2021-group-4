library(tidyverse)
library(lubridate)
library(dplyr)

#read in and clean data from  
chicago_complaint <- read.csv("complaints-complaints.csv", header = TRUE, sep = ",")%>%na.omit()
chicago_complaint <- chicago_complaint %>%
  mutate(complaint_date = as.Date(complaint_date))%>%
  filter(complaint_date >= "2007-01-01" & complaint_date < "2018-01-01")

chicago_accused <- read.csv("complaints-accused.csv", header = TRUE, sep = ",")%>%na.omit()
colnames(chicago_accused)[1] <- "officer_id"

chicago_data <- left_join(chicago_accused,chicago_complaint, by = "cr_id")

save(chicago_data, file = 'Chicago_data.RData')