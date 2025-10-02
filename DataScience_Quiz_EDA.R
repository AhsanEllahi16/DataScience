# ================================================================
# ???? EDA on Built-in Dataset: ChickWeight (Unique Dataset)
# ================================================================

# --- Load necessary libraries -----------------------------------
# Install missing packages once
# install.packages(c("ggplot2", "dplyr", "corrplot"))

library(ggplot2)
library(dplyr)
library(corrplot)

# --- Load dataset ------------------------------------------------
data("ChickWeight")
df <- ChickWeight

# --- Basic info --------------------------------------------------
cat("===== Structure =====\n")
str(df)

cat("\n===== First 6 Rows =====\n")
print(head(df))

cat("\n===== Summary Statistics =====\n")
print(summary(df))

# --- Missing values ----------------------------------------------
cat("\n===== Missing Values per Column =====\n")
print(colSums(is.na(df)))

# ================================================================
# ???? UNIVARIATE ANALYSIS
# ================================================================

cat("\n===== UNIVARIATE ANALYSIS =====\n")

# Summary of weight
cat("\nSummary of Chick Weights:\n")
print(summary(df$weight))

# Standard deviation and IQR
cat("\nStandard Deviation:", sd(df$weight))
cat("\nInterquartile Range (IQR):", IQR(df$weight), "\n")

# Histogram
ggplot(df, aes(x = weight)) +
  geom_histogram(binwidth = 20, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Chick Weights", x = "Weight (grams)", y = "Count")

# Boxplot for weight
boxplot(df$weight,
        main = "Boxplot of Chick Weights",
        ylab = "Weight (grams)",
        col = "orange")

# Count of chicks per diet
cat("\n===== Count of Chicks per Diet =====\n")
print(table(df$Diet))

# ================================================================
# ???? BIVARIATE ANALYSIS
# ================================================================

cat("\n===== BIVARIATE ANALYSIS =====\n")

# Scatterplot: Weight vs Time
ggplot(df, aes(x = Time, y = weight)) +
  geom_point(color = "blue", alpha = 0.6) +
  labs(title = "Chick Weight vs Time", x = "Days", y = "Weight (grams)")

# Boxplot: Weight vs Diet
ggplot(df, aes(x = Diet, y = weight, fill = Diet)) +
  geom_boxplot() +
  labs(title = "Weight by Diet Type", x = "Diet", y = "Weight (grams)")

# Correlation between Time and Weight
cat("\nCorrelation between Time and Weight:\n")
print(cor(df$Time, df$weight))

# Density plot of weight by Diet
ggplot(df, aes(x = weight, fill = Diet)) +
  geom_density(alpha = 0.5) +
  labs(title = "Weight Distribution by Diet", x = "Weight", y = "Density")

# ================================================================
# ???? MULTIVARIATE ANALYSIS
# ================================================================

cat("\n===== MULTIVARIATE ANALYSIS =====\n")

# Growth of each chick by diet
ggplot(df, aes(x = Time, y = weight, group = Chick, color = Diet)) +
  geom_line(alpha = 0.5) +
  labs(title = "Chick Growth Over Time by Diet", x = "Days", y = "Weight (grams)")

# Average weight per time and diet
df_avg <- df %>%
  group_by(Time, Diet) %>%
  summarise(mean_weight = mean(weight), .groups = "drop")

ggplot(df_avg, aes(x = Time, y = mean_weight, color = Diet)) +
  geom_line(size = 1.2) +
  labs(title = "Average Chick Weight Over Time by Diet", x = "Days", y = "Avg Weight (grams)")

# Standard deviation grouped by Time and Diet
df_sd <- df %>%
  group_by(Time, Diet) %>%
  summarise(sd_weight = sd(weight), .groups = "drop")

cat("\nStandard Deviation of Weight by Time and Diet (first few rows):\n")
print(head(df_sd))

# Correlation matrix for numeric variables
df_num <- df %>% select(weight, Time)
cor_matrix <- cor(df_num)
print(cor_matrix)

# Correlation plot
corrplot(cor_matrix, method = "color", addCoef.col = "black")

# ================================================================
cat("\n===== EDA COMPLETE ??? =====\n")
