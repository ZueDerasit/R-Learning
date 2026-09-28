# Chi-Square Tests
# This script demonstrates common chi-square tests
# for categorical data.
#
# 1. Chi-square goodness-of-fit test
# 2. Chi-square test of independence
# 3. Fisher's exact test


# --------------------------------------------------
# 1. Chi-square goodness-of-fit test
# --------------------------------------------------

# Example:
# A researcher wants to determine whether four
# response categories occur with equal proportions.
#
# H0:
# The four categories have equal proportions.
#
# H1:
# The category proportions are not equal.

observed <- c(
  25, 30, 20, 25
)

expected_probability <- c(
  0.25, 0.25, 0.25, 0.25
)

chisq.test(
  x = observed,
  p = expected_probability
)


# --------------------------------------------------
# 2. Extract important results
# --------------------------------------------------

goodness_test <- chisq.test(
  x = observed,
  p = expected_probability
)

goodness_test$statistic

goodness_test$parameter

goodness_test$p.value


# --------------------------------------------------
# 3. Expected frequencies
# --------------------------------------------------

goodness_test$expected


# --------------------------------------------------
# 4. Chi-square test of independence
# --------------------------------------------------

# Example:
# Is gender associated with preferred study mode?

study_mode <- matrix(
  c(
    20, 10,
    15, 25
  ),
  nrow = 2,
  byrow = TRUE
)

rownames(study_mode) <- c(
  "Male",
  "Female"
)

colnames(study_mode) <- c(
  "Online",
  "Face_to_Face"
)

study_mode


# H0:
# Gender and study mode are independent.
#
# H1:
# Gender and study mode are associated.

independence_test <- chisq.test(
  study_mode
)

independence_test


# --------------------------------------------------
# 5. Observed and expected frequencies
# --------------------------------------------------

# Observed frequencies

independence_test$observed

# Expected frequencies

independence_test$expected


# --------------------------------------------------
# 6. Calculate proportions
# --------------------------------------------------

# Row proportions

prop.table(
  study_mode,
  margin = 1
)

# Column proportions

prop.table(
  study_mode,
  margin = 2
)

# Overall proportions

prop.table(
  study_mode
)


# --------------------------------------------------
# 7. Chi-square residuals
# --------------------------------------------------

# Pearson residuals help identify cells that
# contribute strongly to the chi-square statistic.

independence_test$residuals


# Standardised residuals

independence_test$stdres


# --------------------------------------------------
# 8. Chi-square test using a data frame
# --------------------------------------------------

students <- data.frame(
  gender = c(
    "Male", "Male", "Male", "Male", "Male",
    "Female", "Female", "Female", "Female", "Female"
  ),
  study_mode = c(
    "Online", "Online", "Face_to_Face",
    "Online", "Face_to_Face",
    "Online", "Face_to_Face", "Face_to_Face",
    "Face_to_Face", "Online"
  )
)

students


# Create a contingency table

study_table <- table(
  students$gender,
  students$study_mode
)

study_table


# Perform chi-square test

chisq.test(
  study_table
)


# --------------------------------------------------
# 9. Fisher's exact test
# --------------------------------------------------

# Fisher's exact test is useful for small samples,
# particularly when expected frequencies are small.

small_table <- matrix(
  c(
    2, 8,
    7, 3
  ),
  nrow = 2,
  byrow = TRUE
)

rownames(small_table) <- c(
  "Group_A",
  "Group_B"
)

colnames(small_table) <- c(
  "Success",
  "Failure"
)

small_table


fisher.test(
  small_table
)


# --------------------------------------------------
# 10. Checking expected frequencies
# --------------------------------------------------

chi_result <- chisq.test(
  study_table
)

chi_result$expected


# A common rule of thumb is to examine whether
# expected frequencies are sufficiently large.
#
# If expected frequencies are very small,
# Fisher's exact test or another appropriate
# method may be considered.


# --------------------------------------------------
# 11. Visualise categorical frequencies
# --------------------------------------------------

barplot(
  study_table,
  beside = TRUE,
  legend = TRUE,
  main = "Study Mode by Gender",
  xlab = "Gender",
  ylab = "Frequency"
)


# --------------------------------------------------
# 12. Effect size: Phi coefficient
# --------------------------------------------------

# For a 2 x 2 contingency table, the phi coefficient
# can be used as an effect size.

chi_statistic <- as.numeric(
  independence_test$statistic
)

sample_size <- sum(study_mode)

phi <- sqrt(
  chi_statistic / sample_size
)

phi


# --------------------------------------------------
# 13. Interpretation
# --------------------------------------------------

# Chi-square goodness-of-fit:
#
# Used when one categorical variable is compared
# with a specified theoretical distribution.
#
#
# Chi-square test of independence:
#
# Used to determine whether two categorical
# variables are statistically associated.
#
#
# Fisher's exact test:
#
# Useful for small samples or situations where
# chi-square approximation may not be appropriate.
#
#
# Important:
# A statistically significant chi-square test
# indicates evidence of an association or
# difference in category proportions.
#
# It does not by itself establish causation.


# --------------------------------------------------
# 14. Statistical reporting
# --------------------------------------------------

# A result can be reported as:
#
# "A chi-square test of independence was conducted
# to examine the association between gender and
# study mode. The test produced a chi-square
# statistic of ..., with df = ... and p = ... ."
#
# For a 2 x 2 table, an appropriate effect size
# should also be considered.


# Key idea:
# Chi-square tests are designed for categorical data.
#
# Goodness-of-fit
# → One categorical variable vs expected proportions
#
# Test of independence
# → Association between two categorical variables
#
# Fisher's exact test
# → Exact test for small contingency tables
#
# Always examine expected frequencies and consider
# effect size when interpreting the result.
