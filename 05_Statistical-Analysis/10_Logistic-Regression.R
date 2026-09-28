# Logistic Regression
# This script demonstrates binary logistic regression
# for modelling a binary outcome variable.


# --------------------------------------------------
# 1. Create a sample dataset
# --------------------------------------------------

students <- data.frame(
  name = c(
    "Ali", "Siti", "John", "Mei", "Maria",
    "Adam", "Sara", "David", "Aina", "Daniel",
    "Hana", "Farid", "Lina", "Jason", "Nadia"
  ),
  study_hours = c(
    2, 4, 3, 5, 6,
    4, 5, 2, 6, 3,
    7, 4, 8, 3, 6
  ),
  attendance = c(
    70, 85, 75, 90, 95,
    82, 88, 68, 92, 78,
    96, 80, 98, 72, 91
  ),
  score = c(
    65, 85, 72, 90, 95,
    78, 88, 70, 92, 80,
    97, 83, 99, 74, 94
  )
)

students


# --------------------------------------------------
# 2. Create a binary outcome
# --------------------------------------------------

# Example:
# Pass = 1
# Fail = 0
#
# A score of 75 or above is classified as Pass.

students$pass <- ifelse(
  students$score >= 75,
  1,
  0
)

students


# --------------------------------------------------
# 3. Convert the outcome to a factor
# --------------------------------------------------

students$pass_factor <- factor(
  students$pass,
  levels = c(0, 1),
  labels = c("Fail", "Pass")
)

students


# --------------------------------------------------
# 4. Examine the outcome
# --------------------------------------------------

table(
  students$pass_factor
)

prop.table(
  table(students$pass_factor)
)


# --------------------------------------------------
# 5. Binary logistic regression
# --------------------------------------------------

# Research question:
# Can study hours predict the probability
# that a student passes?
#
# Logistic regression models the log-odds
# of the probability of the outcome.

logistic_model <- glm(
  pass ~ study_hours,
  data = students,
  family = binomial
)

summary(
  logistic_model
)


# --------------------------------------------------
# 6. Multiple logistic regression
# --------------------------------------------------

# Add attendance as another predictor.

multiple_logistic_model <- glm(
  pass ~ study_hours + attendance,
  data = students,
  family = binomial
)

summary(
  multiple_logistic_model
)


# --------------------------------------------------
# 7. Regression coefficients
# --------------------------------------------------

coef(
  multiple_logistic_model
)


# --------------------------------------------------
# 8. Odds ratios
# --------------------------------------------------

# Logistic regression coefficients are expressed
# in log-odds units.
#
# Exponentiating the coefficients gives odds ratios.

odds_ratios <- exp(
  coef(multiple_logistic_model)
)

odds_ratios


# --------------------------------------------------
# 9. Confidence intervals for odds ratios
# --------------------------------------------------

coef_ci <- confint(
  multiple_logistic_model
)

odds_ratio_ci <- exp(
  coef_ci
)

odds_ratio_ci


# --------------------------------------------------
# 10. Combine odds ratios and confidence intervals
# --------------------------------------------------

odds_ratio_results <- data.frame(
  term = names(odds_ratios),
  odds_ratio = odds_ratios,
  lower_95_CI = odds_ratio_ci[, 1],
  upper_95_CI = odds_ratio_ci[, 2]
)

odds_ratio_results


# --------------------------------------------------
# 11. Predicted probabilities
# --------------------------------------------------

students$predicted_probability <- predict(
  multiple_logistic_model,
  type = "response"
)

students


# --------------------------------------------------
# 12. Predicted classes
# --------------------------------------------------

# A threshold of 0.50 is used here for illustration.

students$predicted_class <- ifelse(
  students$predicted_probability >= 0.50,
  "Pass",
  "Fail"
)

students$predicted_class <- factor(
  students$predicted_class,
  levels = c("Fail", "Pass")
)

students


# --------------------------------------------------
# 13. Confusion matrix
# --------------------------------------------------

confusion_matrix <- table(
  Actual = students$pass_factor,
  Predicted = students$predicted_class
)

confusion_matrix


# --------------------------------------------------
# 14. Classification accuracy
# --------------------------------------------------

accuracy <- mean(
  students$predicted_class ==
    students$pass_factor
)

accuracy


# --------------------------------------------------
# 15. Sensitivity and specificity
# --------------------------------------------------

# Extract confusion matrix components

true_negative <- confusion_matrix[
  "Fail",
  "Fail"
]

false_positive <- confusion_matrix[
  "Fail",
  "Pass"
]

false_negative <- confusion_matrix[
  "Pass",
  "Fail"
]

true_positive <- confusion_matrix[
  "Pass",
  "Pass"
]


# Sensitivity
#
# Sensitivity =
# True Positive / All Actual Positives

sensitivity <- true_positive /
  (true_positive + false_negative)

sensitivity


# Specificity
#
# Specificity =
# True Negative / All Actual Negatives

specificity <- true_negative /
  (true_negative + false_positive)

specificity


# --------------------------------------------------
# 16. ROC curve and AUC
# --------------------------------------------------

# The pROC package can be used to calculate
# the ROC curve and area under the curve (AUC).
#
# Install once if necessary:
# install.packages("pROC")

library(pROC)

roc_object <- roc(
  students$pass,
  students$predicted_probability
)

plot(
  roc_object,
  main = "ROC Curve"
)

auc(
  roc_object
)


# --------------------------------------------------
# 17. Compare nested logistic regression models
# --------------------------------------------------

anova(
  logistic_model,
  multiple_logistic_model,
  test = "Chisq"
)


# --------------------------------------------------
# 18. Model fit
# --------------------------------------------------

# AIC

AIC(
  logistic_model
)

AIC(
  multiple_logistic_model
)


# --------------------------------------------------
# 19. Statistical interpretation of odds ratios
# --------------------------------------------------

# Example:
#
# Suppose the odds ratio for study_hours is 1.50.
#
# An increase of one unit in study_hours is
# associated with 1.50 times the odds of the
# outcome, holding other predictors constant.
#
# If OR > 1:
# → Higher odds of the outcome
#
# If OR < 1:
# → Lower odds of the outcome
#
# If OR = 1:
# → No change in odds


# --------------------------------------------------
# 20. Important distinction
# --------------------------------------------------

# Logistic regression predicts the probability
# of a categorical outcome.
#
# Linear regression:
# → Continuous outcome
#
# Logistic regression:
# → Binary outcome
#
# Example:
#
# Linear regression:
# score ~ study_hours
#
# Logistic regression:
# pass ~ study_hours


# --------------------------------------------------
# 21. Statistical interpretation
# --------------------------------------------------

# Logistic regression can be used to:
#
# - Model binary outcomes
# - Estimate probabilities
# - Estimate odds ratios
# - Test predictor-outcome associations
# - Classify observations
# - Evaluate predictive performance
#
# Important outputs include:
#
# Coefficients
# → Effects on log-odds
#
# Odds ratios
# → Multiplicative change in odds
#
# Predicted probabilities
# → Estimated probability of the outcome
#
# AUC
# → Discrimination ability across thresholds
#
# Confusion matrix
# → Classification performance at a chosen threshold


# --------------------------------------------------
# 22. Important considerations
# --------------------------------------------------

# Logistic regression assumes:
#
# - Binary outcome for binary logistic regression
# - Independent observations
# - Appropriate functional form for continuous predictors
# - No severe multicollinearity
# - Adequate sample size
#
# Logistic regression does NOT require the
# outcome variable to be normally distributed.


# Key idea:
# Logistic regression models the probability of
# a categorical outcome.
#
# Coefficient
#      ↓
# Log-odds
#      ↓
# exp(coefficient)
#      ↓
# Odds ratio
#      ↓
# Predicted probability
#      ↓
# Classification / prediction
#
# Always distinguish statistical association
# from causal interpretation.
