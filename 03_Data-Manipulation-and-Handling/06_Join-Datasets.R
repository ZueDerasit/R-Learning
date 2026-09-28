# Data Manipulation: Joining Datasets
# This script demonstrates how to combine datasets
# using dplyr join functions.


# --------------------------------------------------
# 1. Load dplyr
# --------------------------------------------------

library(dplyr)


# --------------------------------------------------
# 2. Create two datasets
# --------------------------------------------------

students <- data.frame(
  student_id = c(101, 102, 103, 104, 105),
  name = c("Ali", "Siti", "John", "Mei", "Maria"),
  age = c(20, 21, 22, 20, 25)
)

scores <- data.frame(
  student_id = c(101, 102, 103, 106),
  score = c(65, 85, 72, 90)
)

students

scores


# --------------------------------------------------
# 3. left_join()
# --------------------------------------------------

# Keep all observations from the left dataset.
# Add matching information from the right dataset.

left_join(
  students,
  scores,
  by = "student_id"
)


# --------------------------------------------------
# 4. right_join()
# --------------------------------------------------

# Keep all observations from the right dataset.
# Add matching information from the left dataset.

right_join(
  students,
  scores,
  by = "student_id"
)


# --------------------------------------------------
# 5. inner_join()
# --------------------------------------------------

# Keep only observations that exist
# in both datasets.

inner_join(
  students,
  scores,
  by = "student_id"
)


# --------------------------------------------------
# 6. full_join()
# --------------------------------------------------

# Keep all observations from both datasets.

full_join(
  students,
  scores,
  by = "student_id"
)


# --------------------------------------------------
# 7. Compare the different joins
# --------------------------------------------------

left_join(students, scores, by = "student_id")

inner_join(students, scores, by = "student_id")

full_join(students, scores, by = "student_id")


# --------------------------------------------------
# 8. Bind rows
# --------------------------------------------------

# bind_rows() is used when datasets have
# the same variables and need to be stacked vertically.

students_group_1 <- data.frame(
  student_id = c(101, 102),
  name = c("Ali", "Siti")
)

students_group_2 <- data.frame(
  student_id = c(103, 104),
  name = c("John", "Mei")
)

bind_rows(
  students_group_1,
  students_group_2
)


# --------------------------------------------------
# 9. Check the resulting dataset
# --------------------------------------------------

combined_data <- left_join(
  students,
  scores,
  by = "student_id"
)

str(combined_data)

dim(combined_data)

summary(combined_data)


# --------------------------------------------------
# Key idea
# --------------------------------------------------

# left_join()  → keep all rows from the left dataset
# right_join() → keep all rows from the right dataset
# inner_join() → keep matching rows only
# full_join()  → keep all rows from both datasets
# bind_rows()  → stack datasets vertically
#
# The joining variable should identify
# how observations correspond between datasets.
#
# Always check the resulting dataset after a join.
