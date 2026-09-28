# Confidence Intervals
# This script demonstrates how to calculate and interpret
# confidence intervals for population parameters.

# --------------------------------------------------
# 1. Create a sample dataset
# --------------------------------------------------

scores <- c(
  65, 85, 72, 90, 95,
  78, 88, 70, 92, 80
)

scores


# --------------------------------------------------
# 2. Sample mean and standard deviation
# --------------------------------------------------

sample_mean <- mean(scores)

sample_sd <- sd(scores)

sample_n <- length(scores)

sample_mean
sample_sd
sample_n


# --------------------------------------------------
# 3. Standard error of the mean
# --------------------------------------------------

standard_error <- sample_sd / sqrt(sample_n)

standard_error


# --------------------------------------------------
# 4. Calculate a 95% confidence interval
# --------------------------------------------------

# For a population mean with unknown population
# standard deviation, the t-distribution is used.

alpha <- 0.05

critical_value <- qt(
  1 - alpha / 2,
  df = sample_n - 1
)

critical_value


# Margin of error

margin_of_error <- critical_value * standard_error

margin_of_error


# Lower and upper confidence limits

lower_limit <- sample_mean - margin_of_error

upper_limit <- sample_mean + margin_of_error

lower_limit
upper_limit


# Complete confidence interval

confidence_interval <- c(
  lower_limit,
  upper_limit
)

confidence_interval


# --------------------------------------------------
# 5. Confidence interval using t.test()
# --------------------------------------------------

t.test(scores)


# Extract the confidence interval

t_test_result <- t.test(scores)

t_test_result$conf.int


# --------------------------------------------------
# 6. Confidence intervals at different levels
# --------------------------------------------------

# 90% confidence interval

t.test(
  scores,
  conf.level = 0.90
)$conf.int


# 95% confidence interval

t.test(
  scores,
  conf.level = 0.95
)$conf.int


# 99% confidence interval

t.test(
  scores,
  conf.level = 0.99
)$conf.int


# --------------------------------------------------
# 7. Confidence interval for a proportion
# --------------------------------------------------

# Example:
# 70 out of 100 students passed an examination.

successes <- 70

total <- 100

sample_proportion <- successes / total

sample_proportion


# Approximate 95% confidence interval
# using the normal approximation

se_proportion <- sqrt(
  sample_proportion *
    (1 - sample_proportion) /
    total
)

z_critical <- qnorm(0.975)

lower_proportion <- sample_proportion -
  z_critical * se_proportion

upper_proportion <- sample_proportion +
  z_critical * se_proportion

c(
  lower_proportion,
  upper_proportion
)


# --------------------------------------------------
# 8. Confidence interval for a proportion using prop.test()
# --------------------------------------------------

prop_test_result <- prop.test(
  x = successes,
  n = total,
  conf.level = 0.95
)

prop_test_result

prop_test_result$conf.int


# --------------------------------------------------
# 9. Confidence interval and sample size
# --------------------------------------------------

# A larger sample generally produces
# a smaller standard error.

sample_size_1 <- 30
sample_size_2 <- 100
sample_size_3 <- 500

standard_error_1 <- 10 / sqrt(sample_size_1)
standard_error_2 <- 10 / sqrt(sample_size_2)
standard_error_3 <- 10 / sqrt(sample_size_3)

c(
  n_30 = standard_error_1,
  n_100 = standard_error_2,
  n_500 = standard_error_3
)


# --------------------------------------------------
# 10. Statistical interpretation
# --------------------------------------------------

# A confidence interval provides a range of plausible
# values for an unknown population parameter,
# based on sample data.
#
# Important concepts:
#
# Point estimate
# → A single estimate of the population parameter
#
# Standard error
# → Measures the variability of an estimator
#
# Margin of error
# → Distance from the point estimate to the
#   confidence limit
#
# Confidence level
# → Determines the long-run coverage procedure
#
# Wider confidence interval
# → More uncertainty
#
# Narrower confidence interval
# → Greater precision
#
# Larger sample size
# → Usually produces a smaller standard error
#   and therefore a narrower confidence interval


# --------------------------------------------------
# 11. Important interpretation
# --------------------------------------------------

# Example:
#
# Suppose a 95% confidence interval for the
# population mean is:
#
# 75 to 85
#
# The correct interpretation is:
#
# "Using this confidence interval procedure,
# we are 95% confident that the population mean
# is between 75 and 85."
#
# It is NOT technically correct to say:
#
# "There is a 95% probability that the fixed
# population mean is between 75 and 85."
#
# The population parameter is treated as fixed;
# the interval-producing procedure has the
# 95% long-run coverage property.

# Key idea:
# Confidence intervals communicate both an estimate
# and its uncertainty.
