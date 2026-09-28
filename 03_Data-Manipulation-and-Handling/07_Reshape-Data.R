# Data Manipulation: Reshape Data
# This script demonstrates how to convert data
# between wide and long formats using tidyr.


# --------------------------------------------------
# 1. Load tidyr
# --------------------------------------------------

# Install tidyr once if necessary:
# install.packages("tidyr")

library(tidyr)


# --------------------------------------------------
# 2. Create a wide-format dataset
# --------------------------------------------------

students_wide <- data.frame(
  student_id = c(101, 102, 103),
  name = c("Ali", "Siti", "Maria"),
  statistics = c(80, 85, 90),
  mathematics = c(75, 88, 92),
  programming = c(70, 82, 95)
)

students_wide


# --------------------------------------------------
# 3. Convert wide format to long format
# --------------------------------------------------

students_long <- students_wide %>%
  pivot_longer(
    cols = c(statistics, mathematics, programming),
    names_to = "subject",
    values_to = "score"
  )

students_long


# --------------------------------------------------
# 4. Inspect the long-format dataset
# --------------------------------------------------

str(students_long)

dim(students_long)

head(students_long)


# --------------------------------------------------
# 5. Convert long format back to wide format
# --------------------------------------------------

students_wide_again <- students_long %>%
  pivot_wider(
    names_from = subject,
    values_from = score
  )

students_wide_again


# --------------------------------------------------
# 6. Reshape using all columns except identifiers
# --------------------------------------------------

students_long <- students_wide %>%
  pivot_longer(
    cols = -c(student_id, name),
    names_to = "subject",
    values_to = "score"
  )

students_long


# --------------------------------------------------
# 7. Key idea
# --------------------------------------------------

# pivot_longer() → wide to long
#
# pivot_wider()  → long to wide
#
# Wide format:
#
# student | statistics | mathematics | programming
#
# Long format:
#
# student | subject      | score
# --------------------------------
# Ali     | statistics   | 80
# Ali     | mathematics  | 75
# Ali     | programming  | 70
#
# Long format is often useful for:
#
# - Data visualisation
# - Grouped analysis
# - Repeated measurements
# - Statistical modelling
