# ================================
# Phase 3: Modeling & Interpretation
# ================================

# Load required libraries
library(tidyverse)
# ??? Set correct working directory
setwd("C:/Users/SURFACE PRO4/OneDrive/Desktop/Documents/Data_Science")

# Check it
getwd()
# Load cleaned dataset from Phase 1
data <- read_csv("GroupTask_Phase3/data/combined_data_cleaned.csv")

# View data structure
str(data)

# Preview data
head(data)
# Remove rows with missing inflation or interest rate
model_data <- data %>%
  select(country, year, inflation, interest_rate) %>%
  drop_na()

# Check remaining rows
nrow(model_data)
# Linear Regression Model
model <- lm(inflation ~ interest_rate, data = model_data)

# Model summary
summary(model)

# ================================
# Diagnostic Plots
# ================================
par(mfrow = c(2, 2))  # 2x2 layout
plot(model)
par(mfrow = c(1, 1))  # Reset layout