# Data Visualization: Relationships
# This script demonstrates how to visualise
# relationships between numerical variables.


# --------------------------------------------------
# 1. Load required packages
# --------------------------------------------------

library(ggplot2)
library(dplyr)


# --------------------------------------------------
# 2. Create sample data
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
  age = c(20, 21, 22, 20, 25, 21, 22, 23, 21, 24),
  study_hours = c(2, 4, 3, 5, 6, 4, 5, 2, 6, 3),
  score = c(65, 85, 72, 90, 95, 78, 88, 70, 92, 80)
)

students


# --------------------------------------------------
# 3. Basic scatter plot
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = study_hours,
    y = score
  )
) +
  geom_point() +
  labs(
    title = "Study Hours vs Score",
    x = "Study Hours",
    y = "Score"
  )


# --------------------------------------------------
# 4. Colour points by gender
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = study_hours,
    y = score,
    colour = gender
  )
) +
  geom_point() +
  labs(
    title = "Study Hours vs Score by Gender",
    x = "Study Hours",
    y = "Score",
    colour = "Gender"
  )


# --------------------------------------------------
# 5. Add a linear trend line
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = study_hours,
    y = score
  )
) +
  geom_point() +
  geom_smooth(
    method = "lm",
    se = TRUE
  ) +
  labs(
    title = "Study Hours and Score",
    x = "Study Hours",
    y = "Score"
  )


# --------------------------------------------------
# 6. Add separate trend lines by gender
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = study_hours,
    y = score,
    colour = gender
  )
) +
  geom_point() +
  geom_smooth(
    method = "lm",
    se = TRUE
  ) +
  labs(
    title = "Study Hours and Score by Gender",
    x = "Study Hours",
    y = "Score",
    colour = "Gender"
  )


# --------------------------------------------------
# 7. Calculate Pearson correlation
# --------------------------------------------------

cor(
  students$study_hours,
  students$score
)


# --------------------------------------------------
# 8. Test Pearson correlation
# --------------------------------------------------

cor.test(
  students$study_hours,
  students$score
)


# --------------------------------------------------
# 9. Calculate correlation matrix
# --------------------------------------------------

numeric_data <- students %>%
  select(
    age,
    study_hours,
    score
  )

cor(numeric_data)


# --------------------------------------------------
# 10. Correlation matrix with missing-value handling
# --------------------------------------------------

cor(
  numeric_data,
  use = "complete.obs"
)


# --------------------------------------------------
# Key idea
# --------------------------------------------------

# Scatter plot → visualise relationships between
# numerical variables.
#
# geom_smooth(method = "lm")
# → add a fitted linear regression line.
#
# cor()
# → calculate a correlation coefficient.
#
# cor.test()
# → test the statistical significance of a correlation.
#
# Important:
#
# Correlation describes association.
# Correlation does not by itself establish causation.
