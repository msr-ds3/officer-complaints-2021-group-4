library(tidyverse)
library(lubridate)
library(dplyr)

#read in and clean data from open data philly  
philly_data <- read.csv("philadelphia_data.csv", header = TRUE, sep = ",")%>%
  subset(select=-summary)%>%
  mutate(date_received = as.Date(date_received))

philly_data_findings <- read.csv("philadelphia_data_findings.csv", header = TRUE, sep = ",")%>%na.omit()

#join data
combined_philly_data <- left_join(philly_data, philly_data_findings, by = "complaint_id")


#read in and clean data from sam learner
philly_findings <- read.csv("ppd_findings.csv", header = TRUE, sep = ",") %>% na.omit()

philly_complaint_7_18 <- read.csv("ppd_complaints_7-18.csv", header = TRUE, sep = ",")%>%
  mutate(date_received = as.Date(date_received))%>%
  filter(date_received >= "2015-04-01" & date_received < "2021-04-01")

#change the name of cap_number to complaint_id to match previous data
colnames(philly_complaint_7_18)[1] <- "complaint_id"

philly_sam_data <- inner_join(philly_complaint_7_18,philly_findings, by = "complaint_id")


#join both data sets
combined_philly_data <- combined_philly_data %>%
  select(complaint_id,officer_id,date_received) %>% filter()%>%na.omit()

philly_sam_data <- philly_sam_data%>%
  select(complaint_id,officer_id,date_received) %>% filter(date_received < "2016-01-01")

plotting_data <- full_join(combined_philly_data, philly_sam_data, by = c('date_received','officer_id','complaint_id'))

save(plotting_data, file = 'Philly_data.RData')