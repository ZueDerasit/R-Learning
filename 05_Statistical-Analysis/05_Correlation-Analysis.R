# Correlation Analysis
# This script demonstrates how to measure and interpret
# the strength and direction of relationships between
# quantitative variables.

# --------------------------------------------------
# 1. Create a sample dataset
# --------------------------------------------------

students <- data.frame(
  name = c(
    "Ali", "Siti", "John", "Mei", "Maria",
    "Adam", "Sara", "David", "Aina", "Daniel"
  ),
  study_hours = c(2, 4, 3, 5, 6, 4, 5, 2, 6, 3),
  score = c(65, 85, 72, 90, 95, 78, 88, 70, 92, 80)
)

students


# --------------------------------------------------
# 2. Pearson correlation
# --------------------------------------------------

# Pearson correlation measures the strength and
# direction of a linear relationship between
# two quantitative variables.

cor(
  students$study_hours,
  students$score
)


# --------------------------------------------------
# 3. Spearman correlation
# --------------------------------------------------

# Spearman correlation is based on ranks.
# It is useful when the relationship is monotonic
# or when the assumptions of Pearson correlation
# are less appropriate.

cor(
  students$study_hours,
  students$score,
  method = "spearman"
)


# --------------------------------------------------
# 4. Kendall correlation
# --------------------------------------------------

# Kendall's tau is another rank-based measure
# of association.

cor(
  students$study_hours,
  students$score,
  method = "kendall"
)


# --------------------------------------------------
# 5. Correlation test
# --------------------------------------------------

# Test whether the population Pearson correlation
# differs from zero.

cor_test <- cor.test(
  students$study_hours,
  students$score,
  method = "pearson"
)

cor_test


# --------------------------------------------------
# 6. Extract important results
# --------------------------------------------------

# Correlation coefficient

cor_test$estimate

# p-value

cor_test$p.value

# Confidence interval

cor_test$conf.int


# --------------------------------------------------
# 7. Spearman correlation test
# --------------------------------------------------

spearman_test <- cor.test(
  students$study_hours,
  students$score,
  method = "spearman",
  exact = FALSE
)

spearman_test


# --------------------------------------------------
# 8. Correlation matrix
# --------------------------------------------------

# Select quantitative variables

numeric_data <- students[
  c("study_hours", "score")
]

correlation_matrix <- cor(
  numeric_data
)

correlation_matrix


# --------------------------------------------------
# 9. Correlation matrix with missing values
# --------------------------------------------------

data_with_na <- data.frame(
  study_hours = c(2, 4, 3, NA, 6),
  score = c(65, 85, 72, 90, NA)
)

# Pairwise complete observations

cor(
  data_with_na,
  use = "complete.obs"
)


# --------------------------------------------------
# 10. Interpretation of correlation coefficient
# --------------------------------------------------

# The correlation coefficient ranges from -1 to +1.
#
# r = +1
# → Perfect positive linear relationship
#
# r = 0
# → No linear correlation
#
# r = -1
# → Perfect negative linear relationship
#
# Positive correlation:
# As one variable increases, the other tends
# to increase.
#
# Negative correlation:
# As one variable increases, the other tends
# to decrease.


# --------------------------------------------------
# 11. Visualise the relationship
# --------------------------------------------------

plot(
  students$study_hours,
  students$score,
  main = "Study Hours and Score",
  xlab = "Study Hours",
  ylab = "Score",
  pch = 19
)

abline(
  lm(
    score ~ study_hours,
    data = students
  )
)


# --------------------------------------------------
# 12. Correlation is not causation
# --------------------------------------------------

# A correlation between two variables does not
# by itself establish that one variable causes
# the other.
#
# Possible explanations include:
#
# - Direct causal relationship
# - Reverse causality
# - Confounding variables
# - Coincidental association
#
# Therefore, causal conclusions require appropriate
# study design and additional statistical reasoning.


# --------------------------------------------------
# 13. Example of a confounding variable
# --------------------------------------------------

# Suppose:
#
# Study hours  → Score
#
# Both variables may also be affected by:
#
# Motivation
# Prior knowledge
# Study environment
# Socioeconomic background
#
# A simple correlation does not account for
# these additional variables.


# --------------------------------------------------
# 14. Statistical significance vs strength
# --------------------------------------------------

# A correlation can be statistically significant
# but weak in magnitude.
#
# Conversely, a moderately strong correlation may
# fail to reach statistical significance when the
# sample size is very small.
#
# Therefore, consider both:
#
# - Correlation coefficient
# - Confidence interval
# - p-value
# - Sample size
# - Practical meaning


# --------------------------------------------------
# 15. Important assumptions and considerations
# --------------------------------------------------

# Pearson correlation is most appropriate when:
#
# - Variables are quantitative
# - The relationship is approximately linear
# - Extreme outliers are not driving the relationship
#
# Spearman correlation can be useful when:
#
# - Data are ordinal or rank-based
# - The relationship is monotonic
# - Pearson assumptions are less suitable
#
# Always inspect the data visually before interpreting
# a correlation coefficient.


# --------------------------------------------------
# 16. Statistical interpretation
# --------------------------------------------------

# Example interpretation:
#
# "Study hours and examination score showed a
# positive correlation, indicating that students
# who studied more hours tended to have higher scores."
#
# If a hypothesis test is also performed:
#
# "The correlation was statistically significant
# at the 5% significance level (p < 0.05)."
#
# The actual correlation coefficient and confidence
# interval should also be reported.

# Key idea:
# Correlation measures association, not causation.
# The coefficient, uncertainty, sample size,
# graphical pattern, and research context should
# all be considered when interpreting a correlation.
