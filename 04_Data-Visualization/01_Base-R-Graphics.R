# Data Visualization: Base R Graphics
# This script demonstrates basic statistical graphics
# using base R functions.


# --------------------------------------------------
# 1. Create sample data
# --------------------------------------------------

students <- data.frame(
  name = c("Ali", "Siti", "John", "Mei", "Maria",
           "Adam", "Sara", "David"),
  gender = c("Male", "Female", "Male", "Female", "Female",
             "Male", "Female", "Male"),
  age = c(20, 21, 22, 20, 25, 21, 22, 23),
  score = c(65, 85, 72, 90, 95, 78, 88, 70)
)

students


# --------------------------------------------------
# 2. Scatter plot
# --------------------------------------------------

# Examine the relationship between age and score

plot(
  students$age,
  students$score,
  main = "Age vs Score",
  xlab = "Age",
  ylab = "Score"
)


# --------------------------------------------------
# 3. Histogram
# --------------------------------------------------

# Examine the distribution of scores

hist(
  students$score,
  main = "Distribution of Scores",
  xlab = "Score"
)


# --------------------------------------------------
# 4. Boxplot
# --------------------------------------------------

# Examine the distribution of scores

boxplot(
  students$score,
  main = "Boxplot of Scores",
  ylab = "Score"
)


# --------------------------------------------------
# 5. Boxplot by group
# --------------------------------------------------

# Compare scores between genders

boxplot(
  score ~ gender,
  data = students,
  main = "Scores by Gender",
  xlab = "Gender",
  ylab = "Score"
)


# --------------------------------------------------
# 6. Bar chart
# --------------------------------------------------

# Count observations by gender

gender_counts <- table(students$gender)

barplot(
  gender_counts,
  main = "Number of Students by Gender",
  xlab = "Gender",
  ylab = "Number of Students"
)


# --------------------------------------------------
# 7. Line plot
# --------------------------------------------------

# Example of observations recorded over time

year <- c(2021, 2022, 2023, 2024, 2025)
mean_score <- c(72, 75, 78, 82, 85)

plot(
  year,
  mean_score,
  type = "o",
  main = "Mean Score Over Time",
  xlab = "Year",
  ylab = "Mean Score"
)


# --------------------------------------------------
# 8. Q-Q plot
# --------------------------------------------------

# Assess whether scores approximately follow
# a normal distribution

qqnorm(
  students$score,
  main = "Normal Q-Q Plot of Scores"
)

qqline(
  students$score
)


# --------------------------------------------------
# Key idea
# --------------------------------------------------

# Different plots answer different questions:
#
# Scatter plot → relationship between numerical variables
# Histogram    → distribution of a numerical variable
# Boxplot      → distribution and group comparison
# Bar chart    → frequencies of categorical variables
# Line plot    → trends over time
# Q-Q plot     → assess distributional assumptions
#
# The appropriate plot depends on:
#
# - Type of variable
# - Research question
# - Statistical purpose
