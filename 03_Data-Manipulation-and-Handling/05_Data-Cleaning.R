# Data Manipulation: Data Cleaning
# This script demonstrates common techniques for
# cleaning and standardising data in R.


# --------------------------------------------------
# 1. Load dplyr
# --------------------------------------------------

library(dplyr)


# --------------------------------------------------
# 2. Create a dataset with common data issues
# --------------------------------------------------

students <- data.frame(
  name = c(
    "Ali",
    " Siti",
    "John ",
    "Mei",
    "Maria"
  ),
  gender = c(
    "Male",
    "female",
    "MALE",
    "Female",
    "female"
  ),
  age = c(20, 21, 22, 20, 25),
  score = c(65, 85, 72, 90, 95)
)

students


# --------------------------------------------------
# 3. Remove unnecessary spaces
# --------------------------------------------------

students <- students %>%
  mutate(
    name = trimws(name)
  )

students


# --------------------------------------------------
# 4. Standardise text to lowercase
# --------------------------------------------------

students <- students %>%
  mutate(
    gender = tolower(gender)
  )

students


# --------------------------------------------------
# 5. Standardise categorical values
# --------------------------------------------------

students <- students %>%
  mutate(
    gender = case_when(
      gender == "male" ~ "Male",
      gender == "female" ~ "Female",
      TRUE ~ NA_character_
    )
  )

students


# --------------------------------------------------
# 6. Convert a variable to numeric
# --------------------------------------------------

students$age <- as.numeric(students$age)

class(students$age)


# --------------------------------------------------
# 7. Convert a variable to factor
# --------------------------------------------------

students$gender <- factor(students$gender)

class(students$gender)

levels(students$gender)


# --------------------------------------------------
# 8. Check for unexpected categories
# --------------------------------------------------

table(students$gender, useNA = "ifany")


# --------------------------------------------------
# 9. Check for impossible values
# --------------------------------------------------

# Example: age should be between 18 and 100

students %>%
  filter(age < 18 | age > 100)


# --------------------------------------------------
# 10. Check for invalid scores
# --------------------------------------------------

# Example: score should be between 0 and 100

students %>%
  filter(score < 0 | score > 100)


# --------------------------------------------------
# 11. Create a cleaned dataset
# --------------------------------------------------

students_clean <- students %>%
  mutate(
    name = trimws(name),
    gender = tolower(gender),
    gender = case_when(
      gender == "male" ~ "Male",
      gender == "female" ~ "Female",
      TRUE ~ NA_character_
    ),
    age = as.numeric(age),
    score = as.numeric(score)
  )

students_clean


# --------------------------------------------------
# 12. Final data quality check
# --------------------------------------------------

str(students_clean)

summary(students_clean)

colSums(is.na(students_clean))


# --------------------------------------------------
# Key idea
# --------------------------------------------------

# Data cleaning aims to improve the consistency,
# accuracy, and usability of a dataset.
#
# Common tasks include:
#
# - Removing unnecessary spaces
# - Standardising text
# - Recoding categories
# - Converting data types
# - Checking valid ranges
# - Identifying unexpected values
#
# Important:
#
# Do not automatically change or remove unusual values.
# Investigate the source and meaning of the data first.
