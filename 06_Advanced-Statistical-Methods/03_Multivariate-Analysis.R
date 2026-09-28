# Multivariate Analysis
# This script introduces multivariate statistical analysis
# where several response variables are analysed simultaneously.
#
# The examples focus on:
# 1. Multivariate data structure
# 2. MANOVA
# 3. Multivariate test statistics
# 4. Post-hoc univariate analysis
# 5. Canonical correlation
# 6. Interpretation of multivariate results


# --------------------------------------------------
# 1. Create a sample dataset
# --------------------------------------------------

students <- data.frame(
  group = c(
    "Method_A", "Method_A", "Method_A", "Method_A", "Method_A",
    "Method_B", "Method_B", "Method_B", "Method_B", "Method_B",
    "Method_C", "Method_C", "Method_C", "Method_C", "Method_C"
  ),
  mathematics = c(
    72, 75, 78, 70, 74,
    80, 85, 82, 88, 84,
    90, 92, 87, 95, 91
  ),
  statistics = c(
    70, 76, 79, 72, 75,
    82, 86, 84, 89, 85,
    91, 94, 88, 96, 92
  )
)

students


# --------------------------------------------------
# 2. Explore the multivariate data
# --------------------------------------------------

summary(students)

str(students)

cor(
  students[
    c("mathematics", "statistics")
  ]
)


# --------------------------------------------------
# 3. Visualise multiple response variables
# --------------------------------------------------

boxplot(
  students$mathematics,
  students$statistics,
  names = c(
    "Mathematics",
    "Statistics"
  ),
  main = "Distribution of Response Variables",
  ylab = "Score"
)


# --------------------------------------------------
# 4. MANOVA
# --------------------------------------------------

# MANOVA = Multivariate Analysis of Variance.
#
# Unlike ANOVA, which analyses one response variable,
# MANOVA analyses multiple response variables jointly.
#
# Research question:
# Do the teaching methods differ in their combined
# effect on mathematics and statistics scores?


manova_model <- manova(
  cbind(
    mathematics,
    statistics
  ) ~ group,
  data = students
)

summary(
  manova_model
)


# --------------------------------------------------
# 5. Wilks' Lambda
# --------------------------------------------------

# Wilks' Lambda is one of the common multivariate
# test statistics used in MANOVA.

summary(
  manova_model,
  test = "Wilks"
)


# --------------------------------------------------
# 6. Pillai's Trace
# --------------------------------------------------

summary(
  manova_model,
  test = "Pillai"
)


# --------------------------------------------------
# 7. Hotelling-Lawley Trace
# --------------------------------------------------

summary(
  manova_model,
  test = "Hotelling-Lawley"
)


# --------------------------------------------------
# 8. Roy's Largest Root
# --------------------------------------------------

summary(
  manova_model,
  test = "Roy"
)


# --------------------------------------------------
# 9. Follow-up univariate ANOVA
# --------------------------------------------------

# If the overall MANOVA is statistically significant,
# individual response variables can be examined
# using follow-up ANOVA models.

summary.aov(
  manova_model
)


# --------------------------------------------------
# 10. Separate ANOVA models
# --------------------------------------------------

math_model <- aov(
  mathematics ~ group,
  data = students
)

stats_model <- aov(
  statistics ~ group,
  data = students
)

summary(
  math_model
)

summary(
  stats_model
)


# --------------------------------------------------
# 11. Post-hoc comparisons
# --------------------------------------------------

# If an individual ANOVA is significant,
# post-hoc comparisons can be performed.

TukeyHSD(
  math_model
)

TukeyHSD(
  stats_model
)


# --------------------------------------------------
# 12. Multivariate response means
# --------------------------------------------------

aggregate(
  cbind(
    mathematics,
    statistics
  ) ~ group,
  data = students,
  FUN = mean
)


# --------------------------------------------------
# 13. Visualise group profiles
# --------------------------------------------------

group_means <- aggregate(
  cbind(
    mathematics,
    statistics
  ) ~ group,
  data = students,
  FUN = mean
)

group_means


matplot(
  t(
    group_means[
      ,
      c(
        "mathematics",
        "statistics"
      )
    ]
  ),
  type = "b",
  pch = 19,
  xaxt = "n",
  xlab = "Response Variable",
  ylab = "Mean Score",
  main = "Group Profiles"
)

axis(
  1,
  at = 1:2,
  labels = c(
    "Mathematics",
    "Statistics"
  )
)

legend(
  "topleft",
  legend = group_means$group,
  lty = 1,
  pch = 19
)


# --------------------------------------------------
# 14. Understanding MANOVA assumptions
# --------------------------------------------------

# Important assumptions include:
#
# 1. Independence of observations
# 2. Multivariate normality
# 3. Homogeneity of covariance matrices
# 4. Appropriate measurement of response variables
#
# MANOVA assumptions are more complex than
# ordinary one-way ANOVA because several response
# variables are analysed jointly.


# --------------------------------------------------
# 15. Box's M test
# --------------------------------------------------

# Box's M test can be used to assess equality
# of covariance matrices.
#
# The biotools package provides boxM().
#
# Install once if necessary:
# install.packages("biotools")

library(biotools)

boxM(
  students[
    c(
      "mathematics",
      "statistics"
    )
  ],
  students$group
)


# Important:
#
# Box's M test can be sensitive to deviations from
# multivariate normality and sample size.
#
# It should therefore be interpreted together with
# graphical and substantive evidence.


# --------------------------------------------------
# 16. MANOVA and multiple testing
# --------------------------------------------------

# MANOVA first tests the combined response vector.
#
# If the multivariate test is significant,
# follow-up univariate tests can help determine
# which response variables contribute to the result.
#
# Appropriate control of multiple comparisons
# should be considered when many follow-up tests
# are performed.


# --------------------------------------------------
# 17. Canonical correlation analysis
# --------------------------------------------------

# Canonical correlation examines relationships between
# two sets of variables.
#
# Example:
#
# Set 1:
# Mathematics
# Statistics
#
# Set 2:
# Study hours
# Attendance
#
# The method seeks linear combinations of each
# variable set that are maximally correlated.
#
# The CCA package can be used for canonical
# correlation analysis.
#
# Install once if necessary:
# install.packages("CCA")

library(CCA)

set.seed(123)

study_data <- data.frame(
  study_hours = c(
    2, 4, 3, 5, 6,
    4, 5, 2, 6, 3,
    7, 4, 8, 3, 6
  ),
  attendance = c(
    70, 85, 75, 90, 95,
    82, 88, 68, 92, 78,
    96, 80, 98, 72, 91
  )
)

achievement_data <- students[
  c(
    "mathematics",
    "statistics"
  )
]


# Canonical correlation

cca_result <- cc(
  study_data,
  achievement_data
)

cca_result


# Canonical correlations

cca_result$cor


# --------------------------------------------------
# 18. Canonical weights
# --------------------------------------------------

cca_result$xcoef

cca_result$ycoef


# Canonical weights describe the linear combinations
# used to construct the canonical variates.


# --------------------------------------------------
# 19. Multivariate statistical thinking
# --------------------------------------------------

# Multivariate analysis becomes useful when:
#
# - Several outcomes are related
# - Analysing each outcome separately may ignore
#   relationships among outcomes
# - The research question concerns a combined
#   multivariate response
#
# Examples:
#
# Education:
# Mathematics + Statistics + Programming
#
# Health:
# Blood pressure + Cholesterol + Glucose
#
# Environment:
# PM2.5 + PM10 + NO2 + SO2
#
# Finance:
# Liquidity + Profitability + Leverage


# --------------------------------------------------
# 20. ANOVA vs MANOVA
# --------------------------------------------------

# ANOVA:
#
# One response variable
#        ↓
# Compare group means
#
#
# MANOVA:
#
# Multiple response variables
#        ↓
# Compare groups based on
# the combined response profile


# --------------------------------------------------
# 21. Statistical interpretation
# --------------------------------------------------

# A MANOVA result should be interpreted using:
#
# - Multivariate test statistic
# - Degrees of freedom
# - p-value
# - Effect size where appropriate
# - Follow-up univariate analyses
# - Post-hoc comparisons where appropriate
# - Assumption diagnostics
#
# A significant MANOVA indicates evidence that
# groups differ in their multivariate response
# profile.
#
# It does not automatically indicate that every
# individual response variable differs.


# Key idea:
#
# Univariate analysis
#        ↓
# One response variable
#
# Multivariate analysis
#        ↓
# Multiple response variables analysed jointly
#
# The key advantage of multivariate analysis is that
# relationships among response variables can be
# incorporated into the statistical analysis.
