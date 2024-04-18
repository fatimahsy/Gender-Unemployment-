#### Preamble ####
# Purpose: Models 
# Author: Fatimah Yunusa
# Date: 2 April2024
# Contact: fatimah.yunusa@utoronto.ca
# License: MIT
# Pre-requisites: first 00-packages_instalation.R, 02-data_cleaning.R and download the dataset. 
# Any other information needed?


#### Workspace setup ####
library(readr)
library(lubridate)
library(tidyverse)
library(tidyr)
library(dplyr)
library(knitr)
library(janitor)
library(scales)
library(RColorBrewer)
library(ggplot2)
library(kableExtra)
library(here)
library(arrow)
library(lme4)

set.seed(400)
#### Read data ####
unemployed <- read_csv("data/analysis_data/cleaned_unemployment_data.csv")

model <- lm(genz_unemployment ~ sex + reference_period + adult_unemployment + seniors_unemployment, data = unemploymed)

# Summary of the model
summary(model)

#### Save model ####
saveRDS(
  model,
  file = "models/first_model.rds"
)