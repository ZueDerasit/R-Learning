# Descriptive Statistics
# This script demonstrates common descriptive statistics
# used to summarise quantitative data.

# --------------------------------------------------
# 1. Create a sample dataset
# --------------------------------------------------

students <- data.frame(
  name = c(
    "Ali", "Siti", "John", "Mei", "Maria",
    "Adam", "Sara", "David", "Aina", "Daniel"
  ),
  gender = c(
    "Male", "Female", "Male", "Female", "Female",
    "Male", "Female", "Male", "Female", "Male"
  ),
  study_hours = c(2, 4, 3, 5, 6, 4, 5, 2, 6, 3),
  score = c(65, 85, 72, 90, 95, 78, 88, 70, 92, 80)
)

students


# --------------------------------------------------
# 2. Measures of central tendency
# --------------------------------------------------

# Mean
mean(students$score)

# Median
median(students$score)

# Mode
# R does not have a simple built-in mode function
# for statistical mode, so we can calculate it using table().

score_frequency <- table(students$score)

score_frequency

names(score_frequency)[
  which.max(score_frequency)
]


# --------------------------------------------------
# 3. Measures of dispersion
# --------------------------------------------------

# Minimum
min(students$score)

# Maximum
max(students$score)

# Range
range(students$score)

# Variance
var(students$score)

# Standard deviation
sd(students$score)

# Interquartile range
IQR(students$score)


# --------------------------------------------------
# 4. Five-number summary
# --------------------------------------------------

quantile(students$score)

# The five-number summary consists of:
# Minimum
# First Quartile (Q1)
# Median
# Third Quartile (Q3)
# Maximum


# --------------------------------------------------
# 5. Overall descriptive summary
# --------------------------------------------------

summary(students$score)


# --------------------------------------------------
# 6. Descriptive statistics by group
# --------------------------------------------------

# Mean score by gender

aggregate(
  score ~ gender,
  data = students,
  FUN = mean
)

# Standard deviation by gender

aggregate(
  score ~ gender,
  data = students,
  FUN = sd
)


# --------------------------------------------------
# 7. Descriptive statistics using dplyr
# --------------------------------------------------

library(dplyr)

students %>%
  summarise(
    n = n(),
    mean_score = mean(score),
    median_score = median(score),
    sd_score = sd(score),
    min_score = min(score),
    max_score = max(score),
    IQR_score = IQR(score)
  )


# --------------------------------------------------
# 8. Descriptive statistics by gender
# --------------------------------------------------

students %>%
  group_by(gender) %>%
  summarise(
    n = n(),
    mean_score = mean(score),
    median_score = median(score),
    sd_score = sd(score),
    min_score = min(score),
    max_score = max(score),
    IQR_score = IQR(score),
    .groups = "drop"
  )


# --------------------------------------------------
# 9. Descriptive statistics for multiple variables
# --------------------------------------------------

students %>%
  summarise(
    mean_study_hours = mean(study_hours),
    sd_study_hours = sd(study_hours),
    mean_score = mean(score),
    sd_score = sd(score)
  )


# --------------------------------------------------
# 10. Handling missing values
# --------------------------------------------------

score_with_na <- c(
  65, 85, 72, NA, 95,
  78, 88, 70, 92, 80
)

# Mean without handling NA
mean(score_with_na)

# Mean after removing NA
mean(
  score_with_na,
  na.rm = TRUE
)

# Number of missing observations
sum(is.na(score_with_na))


# --------------------------------------------------
# 11. Statistical interpretation
# --------------------------------------------------

# Descriptive statistics help answer questions such as:
#
# - What is the typical value?
# - How much do observations vary?
# - What are the minimum and maximum values?
# - Is the distribution concentrated or spread out?
# - Are there differences between groups?
#
# Mean → average value
# Median → middle value
# SD → typical spread around the mean
# Variance → squared measure of variability
# IQR → spread of the middle 50% of observations
# Range → difference between minimum and maximum

# Key idea:
# Descriptive statistics summarise the observed data.
# They describe what is present in the sample,
# but they do not by themselves establish causation
# or generalise findings to a population.
