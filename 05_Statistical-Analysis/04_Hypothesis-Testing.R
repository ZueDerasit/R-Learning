# Hypothesis Testing
# This script introduces the basic framework of statistical
# hypothesis testing using examples in R.

# --------------------------------------------------
# 1. Basic hypothesis testing concepts
# --------------------------------------------------

# A statistical hypothesis test generally involves:
#
# H0 = Null hypothesis
# H1 = Alternative hypothesis
#
# The null hypothesis usually represents:
# - no difference
# - no association
# - no effect
#
# The alternative hypothesis represents:
# - a difference
# - an association
# - an effect


# --------------------------------------------------
# 2. Example data
# --------------------------------------------------

scores <- c(
  65, 85, 72, 90, 95,
  78, 88, 70, 92, 80
)

mean(scores)

sd(scores)


# --------------------------------------------------
# 3. One-sample hypothesis test
# --------------------------------------------------

# Research question:
# Is the population mean score different from 75?
#
# H0: mu = 75
# H1: mu != 75

t_test <- t.test(
  scores,
  mu = 75
)

t_test


# --------------------------------------------------
# 4. Extract important test results
# --------------------------------------------------

# Test statistic

t_test$statistic

# Degrees of freedom

t_test$parameter

# p-value

t_test$p.value

# Confidence interval

t_test$conf.int

# Sample mean

t_test$estimate


# --------------------------------------------------
# 5. Statistical decision
# --------------------------------------------------

alpha <- 0.05

if (t_test$p.value < alpha) {
  print("Reject the null hypothesis.")
} else {
  print("Fail to reject the null hypothesis.")
}


# --------------------------------------------------
# 6. One-tailed test
# --------------------------------------------------

# Research question:
# Is the population mean greater than 75?
#
# H0: mu <= 75
# H1: mu > 75

t.test(
  scores,
  mu = 75,
  alternative = "greater"
)


# Research question:
# Is the population mean less than 75?
#
# H0: mu >= 75
# H1: mu < 75

t.test(
  scores,
  mu = 75,
  alternative = "less"
)


# --------------------------------------------------
# 7. Two-tailed test
# --------------------------------------------------

# The default alternative hypothesis is:
#
# H1: mu != mu0

t.test(
  scores,
  mu = 75,
  alternative = "two.sided"
)


# --------------------------------------------------
# 8. p-value interpretation
# --------------------------------------------------

# The p-value measures how incompatible the observed
# data are with the null hypothesis, under the
# assumptions of the statistical test.
#
# Common decision rule:
#
# p-value < alpha
# → Reject H0
#
# p-value >= alpha
# → Fail to reject H0
#
# Important:
# "Fail to reject H0" does NOT mean that H0
# has been proven true.


# --------------------------------------------------
# 9. Statistical significance
# --------------------------------------------------

# Example:
#
# If p-value = 0.03 and alpha = 0.05:
#
# 0.03 < 0.05
#
# Therefore, the result is statistically significant
# at the 5% significance level.
#
# If p-value = 0.12:
#
# 0.12 >= 0.05
#
# Therefore, the result is not statistically significant
# at the 5% significance level.


# --------------------------------------------------
# 10. Type I and Type II errors
# --------------------------------------------------

# Type I Error:
# Rejecting H0 when H0 is actually true.
#
# Probability of Type I error = alpha
#
# Type II Error:
# Failing to reject H0 when H0 is actually false.
#
# Probability of Type II error = beta


# --------------------------------------------------
# 11. Statistical power
# --------------------------------------------------

# Statistical power is:
#
# Power = 1 - beta
#
# It represents the probability of detecting
# an effect when a specified effect truly exists.
#
# Power is affected by:
# - Sample size
# - Effect size
# - Significance level
# - Variability in the data


# --------------------------------------------------
# 12. Effect size
# --------------------------------------------------

# Statistical significance alone does not describe
# the magnitude of an effect.
#
# Effect size provides information about
# the practical magnitude of a difference or relationship.
#
# For a one-sample mean comparison, Cohen's d can be
# calculated as:

mu_0 <- 75

cohens_d <- (
  mean(scores) - mu_0
) / sd(scores)

cohens_d


# --------------------------------------------------
# 13. Multiple testing
# --------------------------------------------------

# When many hypothesis tests are performed,
# the probability of obtaining at least one
# false positive can increase.
#
# Common approaches include:
#
# - Bonferroni correction
# - Holm correction
# - False Discovery Rate (FDR)
#
# Example p-values:

p_values <- c(
  0.001,
  0.012,
  0.030,
  0.080,
  0.200
)

# Bonferroni adjustment

p.adjust(
  p_values,
  method = "bonferroni"
)

# Holm adjustment

p.adjust(
  p_values,
  method = "holm"
)


# --------------------------------------------------
# 14. Statistical interpretation
# --------------------------------------------------

# A hypothesis test should be interpreted using:
#
# 1. Research question
# 2. Null and alternative hypotheses
# 3. Significance level
# 4. Test statistic
# 5. p-value
# 6. Confidence interval
# 7. Effect size
# 8. Practical significance
#
# A statistically significant result does not
# necessarily imply a large or practically important effect.


# --------------------------------------------------
# 15. Recommended reporting structure
# --------------------------------------------------

# A statistical result can be reported as:
#
# "A one-sample t-test was conducted to determine
# whether the population mean differed from 75.
# The result was statistically significant,
# t(df) = ..., p = ..., with a 95% confidence
# interval of [..., ...]."
#
# Where appropriate, also report an effect size
# and explain its practical meaning.

# Key idea:
# Hypothesis testing provides evidence for or against
# a statistical hypothesis. It does not prove that
# a hypothesis is absolutely true or false.
