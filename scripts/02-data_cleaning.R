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

#### read in unemployment data ####

unemployment_data <- read_csv("data/raw_data/unemployed.csv", skip = 11)
view(unemployed)

#### Clean data ####
unemployement_data <-unemployment_data %>% clean_names()


# Remove the bottom five rows (they are not useful to us )
unemployment_data <- unemployment_data %>%
  slice(1:(n() - 13))

unemployment_data <- unemployment_data %>%
  slice(-1:-2)  


#### Save data ####
write_csv(unemployment_data, here::here("data/analysis_data/cleaned_unemployment_data.csv"))
write_parquet(unemployment_data, here::here("data/analysis_data/cleaned_unemployment_data.parquet"))
