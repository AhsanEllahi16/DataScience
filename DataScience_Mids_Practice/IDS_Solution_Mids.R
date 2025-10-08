library(dplyr)
emp_data <- data.frame(
  Emp_ID = c("E1", "E2", "E3", "E4", "E5", "E6", "E7", "E8"),
  Name = c("X", "Y", "Z", "X", "Y", "Z", "X", "Y"),
  Age = c(34, 29, 40, 30, 35, 27, 41, 30),
  Dept = c("HR", "IT", "Finance", "Marketing", "HR", "IT", "Finance", "Marketing"),
  Salary = c(50000, 60000, 70000, 80000, 50000, 65000, 45000, 60000),
  Gender = c("Male", "Female", "Male", "Female", "Male", "Female", "Male", "Female"),
  Experience = c(5, 3, 10, 4, 2, 7, 9, 6)
)
salary_vector <- emp_data$Salary
average_salary <- mean(salary_vector)
print(paste("Average Salary:", average_salary))

min_age <- min(emp_data$Age)
max_age <- max(emp_data$Age)
print(paste("Minimum Age:", min_age))
print(paste("Maximum Age:", max_age))

employee_list <- list(
  Name = "X",
  Department = "HR",
  Age = 34,
  Salary = 50000
)

mean_salary <- mean(emp_data$Salary)
sd_salary <- sd(emp_data$Salary)
cor_age_salary <- cor(emp_data$Age, emp_data$Salary)

print(paste("Mean Salary:", mean_salary))
print(paste("Standard Deviation of Salary:", sd_salary))
print(paste("Correlation between Age and Salary:", cor_age_salary))
print(employee_list)

library(ggplot2)

# i. Scatter plot hp vs mpg
ggplot(mtcars, aes(x = hp, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Horsepower vs MPG", x = "hp", y = "mpg")

# ii. Box plot mpg across cylinders
ggplot(mtcars, aes(x = factor(cyl), y = mpg)) +
  geom_boxplot() +
  labs(title = "MPG by Cylinders", x = "Cylinders", y = "mpg")

# iii. Histogram of car weights
ggplot(mtcars, aes(x = wt)) +
  geom_histogram(bins = 10, color = "black") +
  labs(title = "Car Weights", x = "Weight", y = "Count")