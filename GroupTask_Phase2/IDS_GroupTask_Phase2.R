# ==========================================
# IDS Group Task - Phase 2 (EDA + Visualization)
# ==========================================

library(dplyr)
library(ggplot2)
library(readr)

# ------------------------------------------
# STEP 1 - Load dataset from Phase 1
# ------------------------------------------
data <- read_csv("GroupTask_Phase1/Phase1_cleaned_data.csv")

# Preview the data
head(data)
summary(data)

# ------------------------------------------
# STEP 2 - Check Missing Values
# ------------------------------------------
colSums(is.na(data))

# ------------------------------------------
# STEP 3 - Basic EDA
# ------------------------------------------

# Histogram of Inflation
ggplot(data, aes(x = inflation)) +
  geom_histogram(bins = 30) +
  labs(title = "Distribution of Inflation Rates",
       x = "Inflation (%)", y = "Frequency")

# Histogram of Interest Rates
ggplot(data, aes(x = interest_rate)) +
  geom_histogram(bins = 30) +
  labs(title = "Distribution of Interest Rates",
       x = "Interest Rate (%)", y = "Frequency")

# Boxplot Inflation
ggplot(data, aes(y = inflation)) +
  geom_boxplot() +
  labs(title = "Boxplot of Inflation")

# Boxplot Interest Rates
ggplot(data, aes(y = interest_rate)) +
  geom_boxplot() +
  labs(title = "Boxplot of Interest Rates")

# ------------------------------------------
# STEP 4 - Scatter Plot (Relationship)
# ------------------------------------------
ggplot(data, aes(x = inflation, y = interest_rate)) +
  geom_point(alpha = 0.6) +
  labs(title = "Inflation vs Interest Rate",
       x = "Inflation (%)",
       y = "Interest Rate (%)")

# ------------------------------------------
# STEP 5 - Correlation
# ------------------------------------------
correlation_value <- cor(data$inflation, data$interest_rate)
correlation_value

# ------------------------------------------
# STEP 6 - Yearly Trend (Global Averages)
# ------------------------------------------
year_summary <- data %>%
  group_by(year) %>%
  summarise(
    avg_inflation = mean(inflation, na.rm = TRUE),
    avg_interest  = mean(interest_rate, na.rm = TRUE)
  )

# Plot global average trend of inflation
ggplot(year_summary, aes(x = year, y = avg_inflation)) +
  geom_line() +
  labs(title = "Global Average Inflation (2000-2024)",
       x = "Year", y = "Inflation (%)")

# Plot global average trend of interest rate
ggplot(year_summary, aes(x = year, y = avg_interest)) +
  geom_line() +
  labs(title = "Global Average Interest Rates (2000-2024)",
       x = "Year", y = "Interest Rate (%)")

# ------------------------------------------
# STEP 7 - Save EDA summary
# ------------------------------------------
write_csv(year_summary, "GroupTask_Phase2/Phase2_EDA_Summary.csv")

