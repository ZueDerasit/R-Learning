# Data Manipulation: Select and Filter
# This script demonstrates how to select variables
# and filter observations using dplyr.


# --------------------------------------------------
# 1. Load dplyr
# --------------------------------------------------

# Install dplyr once if necessary:
# install.packages("dplyr")

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
# 3. Select variables
# --------------------------------------------------

# Select one variable
select(students, name)

# Select multiple variables
select(students, name, score)

# Select variables by their positions
select(students, 1, 4)


# --------------------------------------------------
# 4. Filter observations
# --------------------------------------------------

# Students with scores greater than 80
filter(students, score > 80)

# Students aged 20
filter(students, age == 20)

# Female students
filter(students, gender == "Female")


# --------------------------------------------------
# 5. Filter using multiple conditions
# --------------------------------------------------

# Female students with scores greater than 80
filter(
  students,
  gender == "Female" & score > 80
)


# Students who are either male or have a score above 90
filter(
  students,
  gender == "Male" | score > 90
)


# --------------------------------------------------
# 6. Combine select() and filter()
# --------------------------------------------------

# Select name and score for students with scores above 80

students %>%
  filter(score > 80) %>%
  select(name, score)


# --------------------------------------------------
# 7. Key idea
# --------------------------------------------------

# select() = choose variables (columns)
# filter() = choose observations (rows)
#
# A useful way to remember:
#
# select() → Which columns do I want?
# filter() → Which rows do I want?
