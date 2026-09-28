# Nonparametric Methods
# This script introduces common nonparametric
# statistical methods in R.
#
# Nonparametric methods are useful when:
# - Distributional assumptions are questionable
# - Data are ordinal
# - Sample sizes are small
# - Outliers strongly affect parametric methods
# - Data are not well represented by a normal model
#
# Nonparametric methods generally work with
# ranks rather than relying directly on the
# original numerical values.


# --------------------------------------------------
# 1. Create example data
# --------------------------------------------------

group_A <- c(
  12, 15, 14, 18, 20,
  16, 17, 13, 19, 21
)

group_B <- c(
  10, 11, 13, 14, 15,
  12, 16, 13, 14, 11
)

group_C <- c(
  18, 20, 22, 21, 19,
  23, 20, 24, 22, 21
)


# --------------------------------------------------
# 2. Descriptive statistics
# --------------------------------------------------

median(group_A)

median(group_B)

median(group_C)


IQR(group_A)

IQR(group_B)

IQR(group_C)


# --------------------------------------------------
# 3. Combine the data
# --------------------------------------------------

scores <- c(
  group_A,
  group_B,
  group_C
)

group <- factor(
  c(
    rep("A", length(group_A)),
    rep("B", length(group_B)),
    rep("C", length(group_C))
  )
)

nonparam_data <- data.frame(
  group,
  scores
)

head(
  nonparam_data
)


# --------------------------------------------------
# 4. Visualise the groups
# --------------------------------------------------

# install.packages("ggplot2")

library(ggplot2)

ggplot(
  nonparam_data,
  aes(
    x = group,
    y = scores
  )
) +
  geom_boxplot() +
  geom_jitter(
    width = 0.1
  ) +
  labs(
    title = "Scores by Group",
    x = "Group",
    y = "Score"
  ) +
  theme_minimal()


# --------------------------------------------------
# 5. Wilcoxon Signed-Rank Test
# --------------------------------------------------

# Used for paired or one-sample comparisons.
#
# Example:
# Compare paired measurements before and after
# an intervention.

before <- c(
  70, 72, 68, 75, 71,
  69, 74, 73, 70, 76
)

after <- c(
  74, 75, 70, 78, 75,
  72, 77, 76, 73, 79
)

wilcox.test(
  before,
  after,
  paired = TRUE
)


# --------------------------------------------------
# 6. Wilcoxon Signed-Rank Test
# one-sample example
# --------------------------------------------------

# Test whether the median differs from a
# hypothesised value.

wilcox.test(
  group_A,
  mu = 15
)


# --------------------------------------------------
# 7. Mann-Whitney U Test
# --------------------------------------------------

# In R, this is performed using wilcox.test().
#
# It is commonly used to compare two independent
# groups when a two-sample t-test is not appropriate.

wilcox.test(
  group_A,
  group_B,
  paired = FALSE
)


# --------------------------------------------------
# 8. Mann-Whitney U Test using formula syntax
# --------------------------------------------------

wilcox.test(
  scores ~ group,
  data = nonparam_data[
    nonparam_data$group %in% c("A", "B"),
  ]
)


# --------------------------------------------------
# 9. Kruskal-Wallis Test
# --------------------------------------------------

# Nonparametric alternative to one-way ANOVA.
#
# Used when comparing more than two independent
# groups.

kruskal_test <- kruskal.test(
  scores ~ group,
  data = nonparam_data
)

kruskal_test


# --------------------------------------------------
# 10. Post-hoc comparisons
# --------------------------------------------------

# A significant Kruskal-Wallis test tells us that
# at least one group differs.
#
# It does not tell us which groups differ.
#
# Pairwise Wilcoxon tests can be used for
# post-hoc comparisons.

pairwise.wilcox.test(
  nonparam_data$scores,
  nonparam_data$group,
  p.adjust.method = "bonferroni"
)


# --------------------------------------------------
# 11. Multiple-testing correction
# --------------------------------------------------

# Common methods include:
#
# - Bonferroni
# - Holm
# - Benjamini-Hochberg (BH)
#
# Holm is often less conservative than
# Bonferroni while controlling family-wise error.

pairwise.wilcox.test(
  nonparam_data$scores,
  nonparam_data$group,
  p.adjust.method = "holm"
)


# --------------------------------------------------
# 12. Friedman Test
# --------------------------------------------------

# Friedman test is a nonparametric alternative
# to repeated-measures ANOVA.
#
# It is used when the same subjects are measured
# under multiple conditions.

subject <- 1:10

condition_A <- c(
  10, 12, 11, 14, 13,
  15, 12, 11, 14, 13
)

condition_B <- c(
  12, 14, 13, 15, 14,
  16, 14, 13, 15, 15
)

condition_C <- c(
  15, 16, 15, 17, 16,
  18, 16, 15, 17, 17
)

repeated_data <- data.frame(
  subject,
  condition_A,
  condition_B,
  condition_C
)

repeated_data


# Convert to long format

# install.packages("tidyr")

library(tidyr)

repeated_long <- pivot_longer(
  repeated_data,
  cols = starts_with("condition"),
  names_to = "condition",
  values_to = "score"
)

repeated_long


# Friedman test

friedman.test(
  score ~ condition | subject,
  data = repeated_long
)


# --------------------------------------------------
# 13. Post-hoc analysis after Friedman test
# --------------------------------------------------

# Pairwise Wilcoxon signed-rank tests can be used
# to investigate which conditions differ.

pairwise.wilcox.test(
  repeated_long$score,
  repeated_long$condition,
  paired = TRUE,
  p.adjust.method = "holm"
)


# --------------------------------------------------
# 14. Spearman Rank Correlation
# --------------------------------------------------

# Spearman correlation measures the strength of
# a monotonic relationship using ranks.
#
# It is useful when:
# - Data are ordinal
# - Relationship is monotonic but not linear
# - Normality assumptions for Pearson correlation
#   are questionable

x <- c(
  10, 20, 30, 40, 50,
  60, 70, 80, 90, 100
)

y <- c(
  12, 18, 25, 42, 38,
  65, 72, 70, 95, 110
)

cor.test(
  x,
  y,
  method = "spearman"
)


# --------------------------------------------------
# 15. Kendall's Tau
# --------------------------------------------------

# Kendall's tau is another rank-based measure
# of association.

cor.test(
  x,
  y,
  method = "kendall"
)


# --------------------------------------------------
# 16. Spearman vs Kendall
# --------------------------------------------------

# Spearman:
#
# Based on ranked values and measures
# monotonic association.
#
#
# Kendall:
#
# Based on concordant and discordant pairs.
#
# Kendall's tau is often useful for smaller samples
# or when the data contain many tied ranks.


# --------------------------------------------------
# 17. Sign Test
# --------------------------------------------------

# The sign test focuses only on the direction
# of differences rather than their magnitude.
#
# It can be used as a very distribution-free
# alternative for paired or one-sample analysis.

# install.packages("BSDA")

# library(BSDA)

# Example:
#
# SIGN.test(
#   after,
#   md = 0
# )


# --------------------------------------------------
# 18. Rank transformation
# --------------------------------------------------

# Nonparametric methods often operate on ranks.

values <- c(
  15, 8, 20, 10, 12
)

rank(
  values
)


# --------------------------------------------------
# 19. Ranking with ties
# --------------------------------------------------

values_with_ties <- c(
  10, 20, 20, 30, 10
)

rank(
  values_with_ties
)


# --------------------------------------------------
# 20. Effect size
# --------------------------------------------------

# Statistical significance does not tell us
# how large an effect is.
#
# Effect size should also be considered.
#
# For nonparametric tests, possible effect-size
# measures include:
#
# - Rank-biserial correlation
# - Cliff's delta
# - Epsilon-squared
# - Kendall's W


# --------------------------------------------------
# 21. Cliff's Delta
# --------------------------------------------------

# install.packages("effsize")

library(effsize)

cliff.delta(
  group_A,
  group_B
)


# --------------------------------------------------
# 22. Epsilon-squared
# --------------------------------------------------

# A simple effect-size measure for
# Kruskal-Wallis analysis can be calculated from
# the test statistic.
#
# Formula:
#
# epsilon_squared =
# (H - k + 1) / (n - k)
#
# where:
#
# H = Kruskal-Wallis statistic
# k = number of groups
# n = total sample size

H <- as.numeric(
  kruskal_test$statistic
)

k <- length(
  unique(nonparam_data$group)
)

n <- nrow(
  nonparam_data
)

epsilon_squared <- (
  H - k + 1
) / (
  n - k
)

epsilon_squared


# --------------------------------------------------
# 23. Parametric vs nonparametric methods
# --------------------------------------------------

# Independent two-group comparison:
#
# Parametric:
# Independent t-test
#
# Nonparametric:
# Mann-Whitney U / Wilcoxon rank-sum test
#
#
# Paired comparison:
#
# Parametric:
# Paired t-test
#
# Nonparametric:
# Wilcoxon signed-rank test
#
#
# More than two independent groups:
#
# Parametric:
# One-way ANOVA
#
# Nonparametric:
# Kruskal-Wallis test
#
#
# More than two related conditions:
#
# Parametric:
# Repeated-measures ANOVA
#
# Nonparametric:
# Friedman test


# --------------------------------------------------
# 24. Choosing between parametric and
# nonparametric methods
# --------------------------------------------------

# Do not automatically use a nonparametric test
# simply because a normality test is significant.
#
# Consider:
#
# - Research question
# - Study design
# - Measurement scale
# - Distribution
# - Outliers
# - Sample size
# - Robustness of the parametric method
# - Scientific interpretation


# --------------------------------------------------
# 25. Important interpretation issue
# --------------------------------------------------

# Nonparametric tests are often described as
# "tests of medians".
#
# This interpretation is not always correct.
#
# For example, the Mann-Whitney test is generally
# a test about distributions.
#
# A median interpretation requires additional
# assumptions about the shapes of the distributions.


# --------------------------------------------------
# 26. Assumption considerations
# --------------------------------------------------

# Nonparametric methods are not completely
# assumption-free.
#
# For example:
#
# Mann-Whitney:
# - Independent observations
# - Appropriate measurement scale
#
# Wilcoxon signed-rank:
# - Paired observations
# - Differences are meaningfully ranked
#
# Kruskal-Wallis:
# - Independent observations
# - Appropriate group structure
#
# Friedman:
# - Related/repeated observations
# - Appropriate blocking structure


# --------------------------------------------------
# 27. Recommended workflow
# --------------------------------------------------

# Research Question
#       ↓
# Identify study design
#       ↓
# Identify variable types
#       ↓
# Explore distribution
#       ↓
# Check assumptions
#       ↓
# Select appropriate method
#       ↓
# Perform test
#       ↓
# Report effect size
#       ↓
# Interpret statistical and practical significance


# --------------------------------------------------
# 28. Key idea
# --------------------------------------------------

# Nonparametric methods provide useful alternatives
# when standard parametric assumptions are unsuitable.
#
# However:
#
# Nonparametric
# does NOT mean
# "no assumptions".
#
# Statistical method selection should be based on:
#
# Research question
# +
# Study design
# +
# Data characteristics
# +
# Assumptions
# +
# Interpretation
#
# rather than simply choosing a method because
# it is labelled "nonparametric".
