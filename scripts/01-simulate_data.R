#### Preamble ####
# Purpose: Simulates an analysis dataset about unemployment rates. 
# Author: Fatimah Yunusa
# Date: 2 April 2024
# Contact: fatimah.yunusa@utoronto.ca
# License: MIT
# Pre-requisites: -
# Any other information needed? -


#### Workspace setup ####
library(tidyverse)
set.seed(400)
#### Simulate data ####
set.seed(400)

# Define the parameters used
years <- 2018:2023
age_groups <- c("15-24", "25-44", "45 and over")
sexes <- c("both sexes", "male", "female")

# Create simulated data
dataf <- expand.grid(Year=years, Sex=sexes, AgeGroup=age_groups)
dataf$UnemploymentRate <- NA 

# simulate unemployment rates
simulate_unemployment <- function(base_rate, years, fluctuation_range) {
  sapply(1:length(years), function(x) base_rate + sample(fluctuation_range, 1))
}

for(sex in sexes) {
  for(age_group in age_groups) {
    base_rate <- sample(5:25, 1)
    dataf$UnemploymentRate[dataf$Sex == sex & dataf$AgeGroup == age_group] <-
      simulate_unemployment(base_rate, years, -3:3)
  }
}

# Table rearrangements for aestetics!
dataf <- reshape(dataf, idvar = c("Sex", "Year"), timevar = "AgeGroup", direction = "wide")

names(dataf)[3:5] <- age_groups

# Print the data frame
print(dataf)







