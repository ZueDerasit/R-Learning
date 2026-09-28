# Data Visualization: ggplot2 Basics
# This script introduces the grammar of graphics
# using ggplot2.


# --------------------------------------------------
# 1. Load ggplot2
# --------------------------------------------------

# Install ggplot2 once if necessary:
# install.packages("ggplot2")

library(ggplot2)


# --------------------------------------------------
# 2. Create sample data
# --------------------------------------------------

students <- data.frame(
  name = c("Ali", "Siti", "John", "Mei", "Maria",
           "Adam", "Sara", "David"),
  gender = c("Male", "Female", "Male", "Female", "Female",
             "Male", "Female", "Male"),
  age = c(20, 21, 22, 20, 25, 21, 22, 23),
  score = c(65, 85, 72, 90, 95, 78, 88, 70)
)


# --------------------------------------------------
# 3. Basic scatter plot
# --------------------------------------------------

ggplot(
  students,
  aes(x = age, y = score)
) +
  geom_point()


# --------------------------------------------------
# 4. Add labels and title
# --------------------------------------------------

ggplot(
  students,
  aes(x = age, y = score)
) +
  geom_point() +
  labs(
    title = "Age vs Score",
    x = "Age",
    y = "Score"
  )


# --------------------------------------------------
# 5. Colour points by gender
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = age,
    y = score,
    colour = gender
  )
) +
  geom_point()


# --------------------------------------------------
# 6. Add a trend line
# --------------------------------------------------

ggplot(
  students,
  aes(x = age, y = score)
) +
  geom_point() +
  geom_smooth(
    method = "lm",
    se = FALSE
  )


# --------------------------------------------------
# 7. Histogram
# --------------------------------------------------

ggplot(
  students,
  aes(x = score)
) +
  geom_histogram(
    bins = 5
  )


# --------------------------------------------------
# 8. Boxplot
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = gender,
    y = score
  )
) +
  geom_boxplot()


# --------------------------------------------------
# 9. Bar chart
# --------------------------------------------------

ggplot(
  students,
  aes(x = gender)
) +
  geom_bar()


# --------------------------------------------------
# 10. Basic theme
# --------------------------------------------------

ggplot(
  students,
  aes(x = age, y = score)
) +
  geom_point() +
  labs(
    title = "Age vs Score",
    x = "Age",
    y = "Score"
  ) +
  theme_minimal()


# --------------------------------------------------
# 11. Key idea
# --------------------------------------------------

# ggplot2 follows the Grammar of Graphics.
#
# Main components:
#
# ggplot()  → define the data
# aes()     → define how variables are mapped
# geom_*()  → define the type of graph
# labs()    → add titles and labels
# theme_*() → control the overall appearance
#
# A useful way to remember:
#
# Data + Aesthetics + Geometry = Graph
