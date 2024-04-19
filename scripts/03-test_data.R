#### Preamble ####
# Purpose: Tests the data for any errors. 
# Author: Fatimah Yunusa
# Date: 2 April 2024
# Contact: fatimah.yunusa@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# Any other information needed? 

#### Workspace setup ####
library(tidyverse)
library(testthat)
set.seed(400)

#### Test data ####

years <- 2018:2023
age_groups <- c("15-24", "25-44", "45 and over")
sexes <- c("both sexes", "male", "female")

dataf <- expand.grid(Year=years, Sex=sexes, AgeGroup=age_groups)
dataf$UnemploymentRate <- NA 

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

dataf <- reshape(dataf, idvar = c("Sex", "Year"), timevar = "AgeGroup", direction = "wide")

names(dataf)[3:5] <- age_groups

 ## Test Cases 
# Test Case 1: Validate DataFrame Structure
test_that("Data frame has the correct structure", {
  expect_identical(sort(names(dataf)), sort(c('Sex', 'Year', '15-24', '25-44', '45 and over')))
})

# Test Case 2: Validate Data Types
test_that("Columns contain data of the correct type", {
  expect_true(all(sapply(dataf$Year, is.integer)))
  expect_true(all(sapply(dataf[, c('15-24', '25-44', '45 and over')], is.numeric)))
  expect_true(is.factor(dataf$Sex) || is.character(dataf$Sex))
})

# Test Case 3: Check for Missing Values
test_that("There are no missing values in the data frame", {
  expect_false(any(is.na(dataf)))
})

# Test Case 4: Validate Year Range
test_that("Years fall within the specified range", {
  expect_true(all(dataf$Year >= 2018 & dataf$Year <= 2023))
})

# Test Case 5: Validate Unemployment Rate Range
test_that("Unemployment rates are within plausible range", {
  expect_true(all(dataf[, c('15-24', '25-44', '45 and over')] >= 0))
  expect_true(all(dataf[, c('15-24', '25-44', '45 and over')] <= 100))
})

# Test Case 6: Check for Duplicates
test_that("There are no duplicate rows", {
  expect_false(any(duplicated(dataf)))
})

# Test Case 7: Validate Sex Categories
test_that("Sex column contains only specific categories", {
  expect_true(all(dataf$Sex %in% c('both sexes', 'male', 'female')))
})


# To run all tests
test_dir("tests")
