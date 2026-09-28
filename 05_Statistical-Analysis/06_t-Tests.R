# t-Tests
# This script demonstrates the three common forms
# of t-tests:
#
# 1. One-sample t-test
# 2. Independent two-sample t-test
# 3. Paired t-test


# --------------------------------------------------
# 1. One-sample t-test
# --------------------------------------------------

# Example:
# A lecturer wants to determine whether the
# average examination score differs from 75.
#
# H0: mu = 75
# H1: mu != 75

scores <- c(
  65, 85, 72, 90, 95,
  78, 88, 70, 92, 80
)

one_sample_test <- t.test(
  scores,
  mu = 75
)

one_sample_test


# Extract important results

one_sample_test$statistic

one_sample_test$parameter

one_sample_test$p.value

one_sample_test$conf.int

one_sample_test$estimate


# --------------------------------------------------
# 2. Independent two-sample t-test
# --------------------------------------------------

# Example:
# Compare examination scores between
# two independent groups.

group_A <- c(
  65, 72, 78, 70, 80
)

group_B <- c(
  85, 90, 95, 88, 92
)


# H0:
# Mean score of Group A = Mean score of Group B
#
# H1:
# Mean score of Group A != Mean score of Group B


# By default, R performs Welch's t-test,
# which does not assume equal population variances.

independent_test <- t.test(
  group_A,
  group_B
)

independent_test


# --------------------------------------------------
# 3. Independent t-test using a data frame
# --------------------------------------------------

students <- data.frame(
  gender = c(
    "Male", "Male", "Male", "Male", "Male",
    "Female", "Female", "Female", "Female", "Female"
  ),
  score = c(
    65, 72, 78, 70, 80,
    85, 90, 95, 88, 92
  )
)

students


# Test scores between gender groups

t.test(
  score ~ gender,
  data = students
)


# --------------------------------------------------
# 4. Equal variance assumption
# --------------------------------------------------

# If equal population variances are justified,
# var.equal = TRUE can be specified.

t.test(
  score ~ gender,
  data = students,
  var.equal = TRUE
)

# Important:
# Do not automatically assume equal variances.
# The default Welch's t-test is often preferable
# when equal variance cannot be reasonably assumed.


# --------------------------------------------------
# 5. Paired t-test
# --------------------------------------------------

# Example:
# Students take a test before and after
# a training programme.

before <- c(
  60, 65, 70, 72, 68,
  75, 62, 71, 69, 66
)

after <- c(
  68, 72, 75, 78, 74,
  80, 70, 76, 75, 72
)


# H0:
# Mean difference = 0
#
# H1:
# Mean difference != 0


paired_test <- t.test(
  before,
  after,
  paired = TRUE
)

paired_test


# --------------------------------------------------
# 6. Calculate individual differences
# --------------------------------------------------

difference <- after - before

difference

mean(difference)

sd(difference)


# The paired t-test is equivalent to performing
# a one-sample t-test on the differences.

t.test(
  difference,
  mu = 0
)


# --------------------------------------------------
# 7. One-tailed t-tests
# --------------------------------------------------

# Example:
# Test whether the mean score is greater than 75.

t.test(
  scores,
  mu = 75,
  alternative = "greater"
)


# Test whether the mean score is less than 75.

t.test(
  scores,
  mu = 75,
  alternative = "less"
)


# --------------------------------------------------
# 8. Checking normality
# --------------------------------------------------

# For small samples, the distribution of the data
# or paired differences should be examined.

shapiro.test(scores)

shapiro.test(difference)


# --------------------------------------------------
# 9. Visual inspection
# --------------------------------------------------

hist(
  scores,
  main = "Distribution of Scores",
  xlab = "Score"
)

boxplot(
  group_A,
  group_B,
  names = c("Group A", "Group B"),
  main = "Comparison of Two Groups",
  ylab = "Score"
)

boxplot(
  difference,
  main = "Paired Differences",
  ylab = "Difference"
)


# --------------------------------------------------
# 10. Effect size
# --------------------------------------------------

# Statistical significance does not tell us
# how large the difference is.
#
# A simple standardised effect size for two
# independent groups can be calculated using
# Cohen's d.

mean_A <- mean(group_A)

mean_B <- mean(group_B)

sd_A <- sd(group_A)

sd_B <- sd(group_B)

n_A <- length(group_A)

n_B <- length(group_B)

pooled_sd <- sqrt(
  (
    (n_A - 1) * sd_A^2 +
    (n_B - 1) * sd_B^2
  ) /
    (n_A + n_B - 2)
)

cohens_d <- (
  mean_B - mean_A
) / pooled_sd

cohens_d


# --------------------------------------------------
# 11. Choosing the appropriate t-test
# --------------------------------------------------

# One-sample:
# One sample compared with a known/reference value
#
# Independent two-sample:
# Two independent groups
#
# Paired:
# Two measurements from the same subjects
# or naturally matched observations


# --------------------------------------------------
# 12. Statistical interpretation
# --------------------------------------------------

# A t-test should not be interpreted using
# the p-value alone.
#
# Consider:
#
# - Difference in means
# - Confidence interval
# - p-value
# - Effect size
# - Sample size
# - Study design
# - Assumptions
#
# Example:
#
# "The mean score differed between the two groups,
# with a 95% confidence interval of [..., ...]
# and p = ... . The estimated effect size was ... ."


# Key idea:
# The correct t-test depends on the study design.
#
# One-sample → One group vs reference value
# Independent → Two separate groups
# Paired → Matched or repeated measurements
#
# Always consider assumptions and effect size,
# not only statistical significance.
