# Data Visualization: Statistical Graphics
# This script demonstrates visualisations commonly used
# to support statistical analysis and model diagnostics.


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
  study_hours = c(2, 4, 3, 5, 6, 4, 5, 2, 6, 3),
  score = c(65, 85, 72, 90, 95, 78, 88, 70, 92, 80)
)

students


# --------------------------------------------------
# 3. Fit a simple linear regression model
# --------------------------------------------------

model <- lm(
  score ~ study_hours,
  data = students
)

summary(model)


# --------------------------------------------------
# 4. Extract fitted values and residuals
# --------------------------------------------------

students <- students %>%
  mutate(
    fitted_values = fitted(model),
    residuals = residuals(model)
  )

students


# --------------------------------------------------
# 5. Residuals vs fitted values
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = fitted_values,
    y = residuals
  )
) +
  geom_point() +
  geom_hline(
    yintercept = 0,
    linetype = "dashed"
  ) +
  labs(
    title = "Residuals vs Fitted Values",
    x = "Fitted Values",
    y = "Residuals"
  )


# --------------------------------------------------
# 6. Residual distribution
# --------------------------------------------------

ggplot(
  students,
  aes(x = residuals)
) +
  geom_histogram(
    bins = 5
  ) +
  labs(
    title = "Distribution of Residuals",
    x = "Residuals",
    y = "Frequency"
  )


# --------------------------------------------------
# 7. Normal Q-Q plot of residuals
# --------------------------------------------------

ggplot(
  students,
  aes(sample = residuals)
) +
  stat_qq() +
  stat_qq_line() +
  labs(
    title = "Normal Q-Q Plot of Residuals",
    x = "Theoretical Quantiles",
    y = "Sample Quantiles"
  )


# --------------------------------------------------
# 8. Boxplot for group comparison
# --------------------------------------------------

ggplot(
  students,
  aes(
    x = gender,
    y = score
  )
) +
  geom_boxplot() +
  geom_jitter(
    width = 0.1
  ) +
  labs(
    title = "Score Distribution by Gender",
    x = "Gender",
    y = "Score"
  )


# --------------------------------------------------
# 9. Calculate group means and confidence intervals
# --------------------------------------------------

group_summary <- students %>%
  group_by(gender) %>%
  summarise(
    n = n(),
    mean_score = mean(score),
    sd_score = sd(score),
    se = sd_score / sqrt(n),
    lower_ci = mean_score - qt(0.975, df = n - 1) * se,
    upper_ci = mean_score + qt(0.975, df = n - 1) * se,
    .groups = "drop"
  )

group_summary


# --------------------------------------------------
# 10. Plot group means with confidence intervals
# --------------------------------------------------

ggplot(
  group_summary,
  aes(
    x = gender,
    y = mean_score
  )
) +
  geom_point(size = 3) +
  geom_errorbar(
    aes(
      ymin = lower_ci,
      ymax = upper_ci
    ),
    width = 0.1
  ) +
  labs(
    title = "Mean Score with 95% Confidence Intervals",
    x = "Gender",
    y = "Mean Score"
  )


# --------------------------------------------------
# 11. Statistical graphics using base R
# --------------------------------------------------

# Regression diagnostic plots

par(
  mfrow = c(2, 2)
)

plot(model)


# Reset plotting layout

par(
  mfrow = c(1, 1)
)


# --------------------------------------------------
# Key idea
# --------------------------------------------------

# Statistical graphics can help us:
#
# - Examine model assumptions
# - Identify unusual observations
# - Assess residual behaviour
# - Compare groups
# - Communicate estimates and uncertainty
#
# Important examples:
#
# Residual plot
# → assess patterns in residuals
#
# Q-Q plot
# → assess whether observations approximately
#   follow a theoretical distribution
#
# Confidence interval plot
# → communicate an estimate together with uncertainty
#
# Good statistical graphics should support
# statistical reasoning and interpretation.
