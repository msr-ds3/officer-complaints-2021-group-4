library(tidyverse)
library(lubridate)
library(dplyr)

load('Philly_data')

#orgenizing the data into deciles with the percentage of complaints for each decile
plotting_data <- plotting_data%>%
  count(officer_id)%>% 
  arrange(desc(n))%>%            #count = total complaints per officer
  mutate(percentage_per_officer = n/sum(n))%>%
  mutate(deciles = ntile(n,10))%>%
  group_by(deciles)%>%
  summarize(total_percentage_per_decile = sum(percentage_per_officer))

#graphing our results
ggplot(plotting_data, aes(x= deciles, y = total_percentage_per_decile))+
  geom_bar(stat = 'identity')+
  ylab("Proportion of complaints") + xlab("Decile")  