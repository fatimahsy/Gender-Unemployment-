#### Preamble ####
# Purpose: Clean the raw data
# Author: Fatimah Yunusa
# Date: 2 April 2024
# Contact: fatimah.yunusa@utoronto.ca
# License: MIT
# Pre-requisites: run 00-packages_installation.R and download the dataset first
# Any other information needed? Dataset source: https://www150.statcan.gc.ca/t1/tbl1/en/cv.action?pid=1410032701

#### Workspace setup ####
library(readr)
library(lubridate)
library(tidyr)
library(tidyverse)
library(dplyr)
library(knitr)
library(janitor)
library(scales)
library(RColorBrewer)
library(ggplot2)
library(kableExtra)
library(here)
library(arrow)
set.seed(400)



write.csv(unemployment_dataz, "/Users/fatimahy/Desktop/Gender&Unemployment/data/unemployment_dataz.csv", row.names = FALSE)

#### read in unemployment data ####

unemployment_data <- read_csv("data/raw_data/unemployed.csv", skip = 11)
view(unemployed)

#### Clean data ####

unemployement_data <- unemployment_data %>% clean_names()

head((unemployment_data))
names(unemployement_data)

### Rename Columns ###
unemployment_data %>% rename(
  genz_unemployment = x3, 
  reference_period = reference_period,
  sex = sex,
  adult_unemployment = x4,
  seniors_unemployment = x5
)
# Remove the bottom five rows (they are not useful to us )
unemployment_data <- unemployment_data %>%
  slice(1:(n() - 13))

unemployment_data <- unemployment_data %>%
  slice(-1:-2)  


#### Save data ####
write_csv(unemployment_data, here::here("data/analysis_data/cleaned_unemployment_data.csv"))
write_parquet(unemployment_data, here::here("data/analysis_data/cleaned_unemployment_data.parquet"))



unemployment_dataz <- data.frame(
  Sex = c(rep("Both sexes", 6), rep("Males", 6), rep("Females", 6)),
  Reference_Period = c(2018:2023, 2018:2023, 2018:2023),
  genZ_unemployment = c(10.7, 10.7, 20.1, 13.5, 10.1, 10.8, 11.9, 12.1, 20.7, 14.5, 11.2, 11.5, 9.4, 9.3, 19.4, 12.5, 8.9, 10),
  adult_unemployment = c(5.1, 5.1, 8.5, 6.4, 4.6, 4.9, 5.2, 5.4, 8.7, 6.7, 4.5, 4.9, 5.0, 4.8, 8.2, 6.2, 4.6, 4.8),
  seniors_unemployment = c(4.9, 4.6, 7.4, 6.7, 4.4, 4.2, 5.1, 4.8, 7.4, 6.6, 4.5, 4.2, 4.7, 4.3, 7.5, 6.7, 4.4, 4.1)
)

print(unemployment_dataz)
write.csv(unemployment_dataz, "/Users/fatimahy/Desktop/Gender&Unemployment/data/unemployment_dataz.csv", row.names = FALSE)
