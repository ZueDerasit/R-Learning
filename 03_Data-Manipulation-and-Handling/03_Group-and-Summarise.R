# Data Manipulation: Group and Summarise
# This script demonstrates how to group observations
# and calculate summary statistics using dplyr.


# --------------------------------------------------
# 1. Load dplyr
# --------------------------------------------------

library(dplyr)


# --------------------------------------------------
# 2. Create a sample dataset
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
# 3. Calculate an overall summary
# --------------------------------------------------

students %>%
  summarise(
    mean_score = mean(score),
    median_score = median(score),
    minimum_score = min(score),
    maximum_score = max(score)
  )


# --------------------------------------------------
# 4. Count the number of observations
# --------------------------------------------------

students %>%
  summarise(
    number_of_students = n()
  )


# --------------------------------------------------
# 5. Group the data
# --------------------------------------------------

students %>%
  group_by(gender)


# --------------------------------------------------
# 6. Calculate the mean score by gender
# --------------------------------------------------

students %>%
  group_by(gender) %>%
  summarise(
    mean_score = mean(score)
  )


# --------------------------------------------------
# 7. Calculate multiple statistics by group
# --------------------------------------------------

students %>%
  group_by(gender) %>%
  summarise(
    number_of_students = n(),
    mean_score = mean(score),
    median_score = median(score),
    minimum_score = min(score),
    maximum_score = max(score)
  )


# --------------------------------------------------
# 8. Calculate the standard deviation by group
# --------------------------------------------------

students %>%
  group_by(gender) %>%
  summarise(
    mean_score = mean(score),
    sd_score = sd(score)
  )


# --------------------------------------------------
# 9. Group by more than one variable
# --------------------------------------------------

students %>%
  group_by(gender, age) %>%
  summarise(
    mean_score = mean(score),
    number_of_students = n(),
    .groups = "drop"
  )


# --------------------------------------------------
# 10. Arrange the summary results
# --------------------------------------------------

students %>%
  group_by(gender) %>%
  summarise(
    mean_score = mean(score),
    number_of_students = n(),
    .groups = "drop"
  ) %>%
  arrange(desc(mean_score))


# --------------------------------------------------
# Key idea
# --------------------------------------------------

# group_by()   = divide observations into groups
# summarise()  = calculate summary statistics
# n()          = count observations
#
# A useful way to remember:
#
# group_by() → Who should be compared?
# summarise() → What should be calculated?
