# Data Manipulation: Mutate and Arrange
# This script demonstrates how to create and transform variables
# and arrange observations using dplyr.


# --------------------------------------------------
# 1. Load dplyr
# --------------------------------------------------

library(dplyr)


# --------------------------------------------------
# 2. Create a sample dataset
# --------------------------------------------------

students <- data.frame(
  name = c("Ali", "Siti", "John", "Mei", "Maria"),
  gender = c("Male", "Female", "Male", "Female", "Female"),
  age = c(20, 21, 22, 20, 25),
  score = c(65, 85, 72, 90, 95)
)

students


# --------------------------------------------------
# 3. Create a new variable using mutate() 
# --------------------------------------------------

students <- students %>%
  mutate(
    pass = score >= 50
  )

students


# --------------------------------------------------
# 4. Create a categorical variable
# --------------------------------------------------

students <- students %>%
  mutate(
    grade = case_when(
      score >= 80 ~ "A",
      score >= 70 ~ "B",
      score >= 60 ~ "C",
      TRUE ~ "Fail"
    )
  )

students


# --------------------------------------------------
# 5. Create a calculated variable
# --------------------------------------------------

students <- students %>%
  mutate(
    score_percentage = score / 100
  )

students


# --------------------------------------------------
# 6. Modify an existing variable
# --------------------------------------------------

students <- students %>%
  mutate(
    score = score + 5
  )

students


# --------------------------------------------------
# 7. Arrange observations in ascending order 
# --------------------------------------------------

arrange(students, score)


# --------------------------------------------------
# 8. Arrange observations in descending order
# --------------------------------------------------

arrange(students, desc(score))


# --------------------------------------------------
# 9. Arrange by multiple variables
# --------------------------------------------------

arrange(students, gender, score)


# --------------------------------------------------
# 10. Combine mutate() and arrange()
# --------------------------------------------------

students %>%
  mutate(
    score_percentage = score / 100
  ) %>%
  arrange(desc(score_percentage))


# --------------------------------------------------
# Key idea
# --------------------------------------------------

# mutate() = create or modify variables (columns)
#
# arrange() = sort observations (rows)
#
# A useful way to remember:
#
# mutate()  → change the variables
# arrange() → change the order of observations
