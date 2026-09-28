# Analysis of Variance (ANOVA)
# This script demonstrates one-way ANOVA for comparing
# the means of three or more independent groups.


# --------------------------------------------------
# 1. Create a sample dataset
# --------------------------------------------------

students <- data.frame(
  group = c(
    "Method_A", "Method_A", "Method_A", "Method_A", "Method_A",
    "Method_B", "Method_B", "Method_B", "Method_B", "Method_B",
    "Method_C", "Method_C", "Method_C", "Method_C", "Method_C"
  ),
  score = c(
    72, 75, 78, 70, 74,
    80, 85, 82, 88, 84,
    90, 92, 87, 95, 91
  )
)

students


# --------------------------------------------------
# 2. Group descriptive statistics
# --------------------------------------------------

library(dplyr)

students %>%
  group_by(group) %>%
  summarise(
    n = n(),
    mean_score = mean(score),
    sd_score = sd(score),
    median_score = median(score),
    min_score = min(score),
    max_score = max(score),
    .groups = "drop"
  )


# --------------------------------------------------
# 3. Visualise the groups
# --------------------------------------------------

boxplot(
  score ~ group,
  data = students,
  main = "Score Distribution by Method",
  xlab = "Method",
  ylab = "Score"
)


# --------------------------------------------------
# 4. One-way ANOVA
# --------------------------------------------------

# Research question:
# Do the mean scores differ between the three methods?
#
# H0:
# All population means are equal.
#
# H1:
# At least one population mean differs.

anova_model <- aov(
  score ~ group,
  data = students
)

summary(anova_model)


# --------------------------------------------------
# 5. ANOVA table
# --------------------------------------------------

anova_table <- summary(
  anova_model
)

anova_table


# --------------------------------------------------
# 6. Extract important components
# --------------------------------------------------

# F-statistic

anova_table[[1]]$`F value`

# p-value

anova_table[[1]]$`Pr(>F)`


# --------------------------------------------------
# 7. Understanding the ANOVA decomposition
# --------------------------------------------------

# ANOVA separates total variability into:
#
# Between-group variability
# +
# Within-group variability
#
# Total variability
# =
# Between-group variability
# +
# Within-group variability


# --------------------------------------------------
# 8. Sum of squares
# --------------------------------------------------

anova_table[[1]]$`Sum Sq`


# --------------------------------------------------
# 9. Mean squares
# --------------------------------------------------

anova_table[[1]]$`Mean Sq`


# --------------------------------------------------
# 10. F-statistic
# --------------------------------------------------

# Conceptually:
#
# F =
# Between-group variability
# ------------------------
# Within-group variability
#
# A larger F-statistic provides stronger evidence
# that the group means are not all equal.


# --------------------------------------------------
# 11. Post-hoc analysis
# --------------------------------------------------

# A significant ANOVA tells us that at least
# one group mean differs.
#
# It does NOT tell us which groups differ.
#
# Tukey's HSD can be used for pairwise comparisons.

TukeyHSD(
  anova_model
)


# --------------------------------------------------
# 12. Visualise Tukey comparisons
# --------------------------------------------------

plot(
  TukeyHSD(anova_model)
)


# --------------------------------------------------
# 13. Model residuals
# --------------------------------------------------

anova_residuals <- residuals(
  anova_model
)

anova_fitted <- fitted(
  anova_model
)

anova_residuals

anova_fitted


# --------------------------------------------------
# 14. Residual diagnostic plots
# --------------------------------------------------

plot(
  anova_model,
  which = 1
)

plot(
  anova_model,
  which = 2
)


# --------------------------------------------------
# 15. Normality of residuals
# --------------------------------------------------

shapiro.test(
  anova_residuals
)


# --------------------------------------------------
# 16. Homogeneity of variance
# --------------------------------------------------

# Bartlett's test

bartlett.test(
  score ~ group,
  data = students
)


# --------------------------------------------------
# 17. Levene's test
# --------------------------------------------------

# Levene's test is often preferred when the data
# may not be normally distributed.

# The car package is required.
#
# Install once if necessary:
# install.packages("car")

library(car)

leveneTest(
  score ~ group,
  data = students
)


# --------------------------------------------------
# 18. Non-parametric alternative
# --------------------------------------------------

# If ANOVA assumptions are substantially violated,
# the Kruskal-Wallis test may be considered.

kruskal.test(
  score ~ group,
  data = students
)


# --------------------------------------------------
# 19. Effect size
# --------------------------------------------------

# Eta-squared:
#
# eta² =
# Between-group Sum of Squares
# ---------------------------
# Total Sum of Squares

ss_between <- anova_table[[1]]$`Sum Sq`[1]

ss_within <- anova_table[[1]]$`Sum Sq`[2]

ss_total <- ss_between + ss_within

eta_squared <- ss_between / ss_total

eta_squared


# --------------------------------------------------
# 20. Statistical interpretation
# --------------------------------------------------

# ANOVA tests whether population means are all equal.
#
# If p-value < alpha:
#
# → Reject H0
# → Evidence that at least one population mean differs
#
# If p-value >= alpha:
#
# → Fail to reject H0
# → Insufficient evidence that the population means differ
#
# If ANOVA is significant:
#
# → Perform appropriate post-hoc comparisons
#   to identify which groups differ.
#
# Effect size should also be considered because
# statistical significance does not indicate
# the magnitude of the group differences.


# --------------------------------------------------
# 21. Reporting ANOVA
# --------------------------------------------------

# A result can be reported as:
#
# "A one-way ANOVA was conducted to examine
# differences in mean scores across the three
# methods. The analysis produced an F-statistic
# of ..., with df = ... and p = ... .
# A post-hoc Tukey analysis was subsequently
# conducted to examine pairwise differences."
#
# Where appropriate, also report an effect size
# such as eta-squared.


# Key idea:
# ANOVA compares the means of three or more groups.
#
# ANOVA significant
#        ↓
# At least one mean differs
#        ↓
# Post-hoc analysis
#        ↓
# Identify which groups differ
#
# Always consider:
# - Independence
# - Normality of residuals
# - Homogeneity of variance
# - Effect size
# - Practical significance
