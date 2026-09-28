# Data Visualization: Categorical Data
# This script demonstrates different ways to visualise
# categorical variables using ggplot2.


# --------------------------------------------------
# 1. Load required packages
# --------------------------------------------------

library(ggplot2)
library(dplyr)


# --------------------------------------------------
# 2. Create sample data
# --------------------------------------------------

students <- data.frame(
  name = c("Ali", "Siti", "John", "Mei", "Maria",
           "Adam", "Sara", "David", "Aina", "Daniel"),
  gender = c(
    "Male", "Female", "Male", "Female", "Female",
    "Male", "Female", "Male", "Female", "Male"
  ),
  programme = c(
    "Statistics", "Statistics", "Data Science",
    "Statistics", "Data Science",
    "Data Science", "Statistics", "Data Science",
    "Statistics", "Data Science"
  ),
  score = c(65, 85, 72, 90, 95, 78, 88, 70, 92, 80)
)

students


# --------------------------------------------------
# 3. Basic bar chart
# --------------------------------------------------

ggplot(
  students,
  aes(x = gender)
) +
  geom_bar() +
  labs(
    title = "Number of Students by Gender",
    x = "Gender",
    y = "Frequency"
  )


# --------------------------------------------------
# 4. Bar chart by programme
# --------------------------------------------------

ggplot(
  students,
  aes(x = programme)
) +
  geom_bar() +
  labs(
    title = "Number of Students by Programme",
    x = "Programme",
    y = "Frequency"
  )


# --------------------------------------------------
# 5. Proportion bar chart
# --------------------------------------------------

ggplot(
  students,
  aes(x = gender)
) +
  geom_bar(
    aes(y = after_stat(count / sum(count)))
  ) +
  scale_y_continuous(
    labels = scales::percent
  ) +
  labs(
    title = "Proportion of Students by Gender",
    x = "Gender",
    y = "Proportion"
  )


# --------------------------------------------------
# 6. Grouped bar chart
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = programme,
    fill = gender
  )
) +
  geom_bar(
    position = "dodge"
  ) +
  labs(
    title = "Students by Programme and Gender",
    x = "Programme",
    y = "Frequency",
    fill = "Gender"
  )


# --------------------------------------------------
# 7. Stacked bar chart
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = programme,
    fill = gender
  )
) +
  geom_bar() +
  labs(
    title = "Students by Programme and Gender",
    x = "Programme",
    y = "Frequency",
    fill = "Gender"
  )


# --------------------------------------------------
# 8. Stacked proportion chart
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = programme,
    fill = gender
  )
) +
  geom_bar(
    position = "fill"
  ) +
  scale_y_continuous(
    labels = scales::percent
  ) +
  labs(
    title = "Gender Proportion within Each Programme",
    x = "Programme",
    y = "Proportion",
    fill = "Gender"
  )


# --------------------------------------------------
# 9. Create a frequency table
# --------------------------------------------------

table(students$gender)

table(
  students$programme,
  students$gender
)


# --------------------------------------------------
# 10. Calculate proportions
# --------------------------------------------------

prop.table(
  table(students$gender)
)


# Proportion within programme

prop.table(
  table(
    students$programme,
    students$gender
  ),
  margin = 1
)


# --------------------------------------------------
# Key idea
# --------------------------------------------------

# Bar chart          → compare frequencies
# Proportion chart   → compare percentages
# Grouped bar chart  → compare categories side by side
# Stacked bar chart  → show composition
# Stacked proportion → compare composition as percentages
#
# When visualising categorical data, consider:
#
# - Frequency
# - Proportion
# - Number of categories
# - Comparison between groups
# - Composition within groups
