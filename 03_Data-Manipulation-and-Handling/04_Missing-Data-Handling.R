# Data Manipulation: Missing Data Handling
# This script demonstrates how to identify, investigate,
# and handle missing values in R.


# --------------------------------------------------
# 1. Load dplyr
# --------------------------------------------------

library(dplyr)


# --------------------------------------------------
# 2. Create a dataset with missing values
# --------------------------------------------------

students <- data.frame(
  name = c("Ali", "Siti", "John", "Mei", "Maria",
           "Adam", "Sara", "David"),
  gender = c("Male", "Female", "Male", "Female", "Female",
             "Male", "Female", "Male"),
  age = c(20, 21, NA, 20, 25, 21, 22, NA),
  score = c(65, 85, 72, NA, 95, 78, NA, 70)
)

students


# --------------------------------------------------
# 3. Identify missing values
# --------------------------------------------------

is.na(students)


# --------------------------------------------------
# 4. Count total missing values
# --------------------------------------------------

sum(is.na(students))


# --------------------------------------------------
# 5. Count missing values by variable
# --------------------------------------------------

colSums(is.na(students))


# --------------------------------------------------
# 6. Calculate percentage of missing values
# --------------------------------------------------

missing_percentage <- colMeans(is.na(students)) * 100

missing_percentage


# --------------------------------------------------
# 7. Identify observations with missing values
# --------------------------------------------------

students %>%
  filter(if_any(everything(), is.na))


# --------------------------------------------------
# 8. Remove observations with missing values
# --------------------------------------------------

students_complete <- students %>%
  filter(complete.cases(.))

students_complete


# --------------------------------------------------
# 9. Remove missing values from a specific variable
# --------------------------------------------------

students %>%
  filter(!is.na(score))


# --------------------------------------------------
# 10. Calculate statistics while ignoring missing values
# --------------------------------------------------

mean(students$score, na.rm = TRUE)

median(students$score, na.rm = TRUE)

sd(students$score, na.rm = TRUE)


# --------------------------------------------------
# 11. Replace a missing value with a simple value
# --------------------------------------------------

students_example <- students

students_example$score[
  is.na(students_example$score)
] <- 0

students_example


# --------------------------------------------------
# 12. Replace missing values using the mean
# --------------------------------------------------

students_mean_imputed <- students

students_mean_imputed$score[
  is.na(students_mean_imputed$score)
] <- mean(
  students_mean_imputed$score,
  na.rm = TRUE
)

students_mean_imputed


# --------------------------------------------------
# 13. Compare the original and modified data
# --------------------------------------------------

students

students_complete

students_mean_imputed


# --------------------------------------------------
# Key idea
# --------------------------------------------------

# Missing data should not automatically be deleted.
#
# A statistical approach should consider:
#
# 1. How much data is missing?
# 2. Which variables contain missing values?
# 3. Why are the values missing?
# 4. Is the missingness systematic?
# 5. What is the appropriate method for handling it?
#
# Common approaches include:
#
# - Complete-case analysis
# - Mean/median imputation
# - Model-based imputation
# - Multiple imputation
#
# The appropriate method depends on the
# research question and missing-data mechanism.
