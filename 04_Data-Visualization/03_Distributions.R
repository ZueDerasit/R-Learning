# Data Visualization: Distributions
# This script demonstrates different ways to visualise
# the distribution of numerical variables.


# --------------------------------------------------
# 1. Load ggplot2
# --------------------------------------------------

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
# 3. Histogram
# --------------------------------------------------

ggplot(
  students,
  aes(x = score)
) +
  geom_histogram(
    bins = 5
  ) +
  labs(
    title = "Distribution of Scores",
    x = "Score",
    y = "Frequency"
  )


# --------------------------------------------------
# 4. Histogram with a density curve
# --------------------------------------------------

ggplot(
  students,
  aes(x = score)
) +
  geom_histogram(
    aes(y = after_stat(density)),
    bins = 5
  ) +
  geom_density(
    linewidth = 1
  ) +
  labs(
    title = "Distribution of Scores",
    x = "Score",
    y = "Density"
  )


# --------------------------------------------------
# 5. Density plot
# --------------------------------------------------

ggplot(
  students,
  aes(x = score)
) +
  geom_density() +
  labs(
    title = "Density Plot of Scores",
    x = "Score",
    y = "Density"
  )


# --------------------------------------------------
# 6. Boxplot
# --------------------------------------------------

ggplot(
  students,
  aes(y = score)
) +
  geom_boxplot() +
  labs(
    title = "Boxplot of Scores",
    y = "Score"
  )


# --------------------------------------------------
# 7. Boxplot by gender
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = gender,
    y = score
  )
) +
  geom_boxplot() +
  labs(
    title = "Score Distribution by Gender",
    x = "Gender",
    y = "Score"
  )


# --------------------------------------------------
# 8. Violin plot
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = gender,
    y = score
  )
) +
  geom_violin() +
  labs(
    title = "Score Distribution by Gender",
    x = "Gender",
    y = "Score"
  )


# --------------------------------------------------
# 9. Violin plot with individual observations
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = gender,
    y = score
  )
) +
  geom_violin() +
  geom_jitter(
    width = 0.1
  ) +
  labs(
    title = "Score Distribution by Gender",
    x = "Gender",
    y = "Score"
  )


# --------------------------------------------------
# 10. Compare distribution statistics
# --------------------------------------------------

students %>%
  group_by(gender) %>%
  summarise(
    mean_score = mean(score),
    median_score = median(score),
    sd_score = sd(score),
    minimum_score = min(score),
    maximum_score = max(score)
  )


# --------------------------------------------------
# Key idea
# --------------------------------------------------

# Histogram  → shows the frequency distribution
# Density    → shows the estimated distribution shape
# Boxplot    → shows centre, spread and potential outliers
# Violin     → shows the distribution shape by group
#
# When examining a distribution, consider:
#
# - Centre
# - Spread
# - Shape
# - Skewness
# - Potential outliers
# - Differences between groups
