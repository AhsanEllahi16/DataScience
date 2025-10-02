# ============================================================
# ???? Phase 1 - R Environment Setup (World Bank Indicators)
# ============================================================

# 1. List all required packages
packages <- c(
  "tidyverse", "readr", "dplyr", "tidyr",
  "countrycode", "lubridate", "WDI"
)

# 2. Install any missing packages
new <- packages[!(packages %in% installed.packages()[, "Package"])]
if (length(new)) install.packages(new, dependencies = TRUE)

# 3. Some dependencies might have failed before (e.g. 'stringi')
#    So, we ensure key dependencies are also installed:
extra_pkgs <- c("stringi", "bslib", "data.table", "curl", "openssl", 
                "systemfonts", "textshaping", "rmarkdown", "broom",
                "dbplyr", "googledrive", "ragg")
extra_new <- extra_pkgs[!(extra_pkgs %in% installed.packages()[, "Package"])]
if (length(extra_new)) install.packages(extra_new, dependencies = TRUE)

# 4. Load all required libraries
library(tidyverse)
library(readr)
library(dplyr)
library(tidyr)
library(countrycode)
library(lubridate)
library(WDI)

# ============================================================
# ???? Phase 2 - Download World Bank Data
# ============================================================

# World Bank indicators:
# Inflation, consumer prices (annual %) = "FP.CPI.TOTL.ZG"
# Real interest rate (%)                = "FR.INR.RINR"

start_year <- 2000
end_year   <- 2024

# Get Inflation Data
inflation_raw <- WDI(
  country = "all",
  indicator = "FP.CPI.TOTL.ZG",
  start = start_year,
  end = end_year
)

# Get Interest Rate Data
interest_raw <- WDI(
  country = "all",
  indicator = "FR.INR.RINR",
  start = start_year,
  end = end_year
)

# ============================================================
# ???? Phase 3 - Clean & Combine Data
# ============================================================

inflation_clean <- inflation_raw %>%
  rename(country = country,
         year = year,
         inflation = FP.CPI.TOTL.ZG)

interest_clean <- interest_raw %>%
  rename(country = country,
         year = year,
         interest_rate = FR.INR.RINR)

# Merge the two datasets by country & year
combined_data <- merge(inflation_clean, interest_clean, 
                       by = c("country", "year"))

# ============================================================
# ???? Phase 4 - Quick Summary and Visualization
# ============================================================

# Show first few rows
head(combined_data)

# Summary statistics
summary(combined_data)

# Example plot: Inflation vs. Interest rate (for recent year)
latest_year <- max(combined_data$year, na.rm = TRUE)
plot_data <- combined_data %>% filter(year == latest_year)

ggplot(plot_data, aes(x = inflation, y = interest_rate)) +
  geom_point(color = "steelblue", alpha = 0.7) +
  labs(
    title = paste("Inflation vs. Real Interest Rate in", latest_year),
    x = "Inflation (annual %)",
    y = "Real Interest Rate (%)"
  ) +
  theme_minimal()

# ============================================================
# ??? Done!
# ============================================================
cat("\nAll libraries loaded successfully and World Bank data retrieved ???\n")
