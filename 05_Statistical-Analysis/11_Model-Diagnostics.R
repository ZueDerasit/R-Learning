# Model Diagnostics
# This script demonstrates common diagnostic techniques
# used to assess statistical regression models.
#
# Model diagnostics help determine whether the fitted
# model is appropriate for the data and whether important
# assumptions are reasonably satisfied.


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
# 2. Fit a multiple linear regression model
# --------------------------------------------------

model <- lm(
  score ~ study_hours + attendance,
  data = students
)

summary(model)


# --------------------------------------------------
# 3. Basic model information
# --------------------------------------------------

fitted_values <- fitted(model)

residuals_model <- residuals(model)

fitted_values

residuals_model


# --------------------------------------------------
# 4. Residuals vs fitted values
# --------------------------------------------------

plot(
  fitted_values,
  residuals_model,
  pch = 19,
  main = "Residuals vs Fitted Values",
  xlab = "Fitted Values",
  ylab = "Residuals"
)

abline(
  h = 0,
  lty = 2
)


# Interpretation:
#
# Ideally, residuals should be randomly scattered
# around zero.
#
# Potential warning signs:
#
# - Curved pattern
# - Funnel-shaped pattern
# - Clusters
# - Systematic structure
#
# These patterns may indicate that the model
# does not adequately represent the relationship
# between predictors and the response.


# --------------------------------------------------
# 5. Normal Q-Q plot
# --------------------------------------------------

qqnorm(
  residuals_model,
  pch = 19,
  main = "Normal Q-Q Plot"
)

qqline(
  residuals_model,
  lty = 2
)


# Interpretation:
#
# If residuals approximately follow a straight line,
# their distribution may be reasonably compatible
# with normality.
#
# Large systematic departures from the line may
# indicate non-normality.


# --------------------------------------------------
# 6. Histogram of residuals
# --------------------------------------------------

hist(
  residuals_model,
  main = "Distribution of Residuals",
  xlab = "Residuals"
)


# --------------------------------------------------
# 7. Shapiro-Wilk test
# --------------------------------------------------

shapiro.test(
  residuals_model
)


# Important:
#
# Formal normality tests can be sensitive to sample size.
# Therefore, combine the test with graphical diagnostics
# and substantive knowledge.


# --------------------------------------------------
# 8. Scale-location plot
# --------------------------------------------------

plot(
  model,
  which = 3
)


# This plot can help assess whether the spread
# of residuals changes across fitted values.
#
# A systematic increase or decrease in spread
# may indicate heteroscedasticity.


# --------------------------------------------------
# 9. Breusch-Pagan test
# --------------------------------------------------

# The lmtest package is required.
#
# Install once if necessary:
# install.packages("lmtest")

library(lmtest)

bptest(
  model
)


# Interpretation:
#
# H0:
# Constant error variance
#
# H1:
# Non-constant error variance
#
# A small p-value provides evidence against
# constant variance.


# --------------------------------------------------
# 10. White-type heteroscedasticity test
# --------------------------------------------------

# A general White-type approach can be implemented
# by including fitted values and their squared terms
# in an auxiliary regression.

auxiliary_model <- lm(
  residuals_model^2 ~ fitted_values +
    I(fitted_values^2)
)

summary(auxiliary_model)


# The auxiliary regression is used to examine whether
# squared residuals are systematically related to
# the fitted values.


# --------------------------------------------------
# 11. Multicollinearity
# --------------------------------------------------

# The car package provides the VIF function.
#
# Install once if necessary:
# install.packages("car")

library(car)

vif(
  model
)


# Interpretation:
#
# VIF measures how strongly a predictor is related
# to the other predictors in the model.
#
# Large VIF values may indicate problematic
# multicollinearity.
#
# There is no single universal cutoff that should
# be applied mechanically.


# --------------------------------------------------
# 12. Influence diagnostics
# --------------------------------------------------

# Cook's distance

cooks_d <- cooks.distance(
  model
)

cooks_d


plot(
  cooks_d,
  type = "h",
  main = "Cook's Distance",
  xlab = "Observation",
  ylab = "Cook's Distance"
)


# Large Cook's distance values may indicate
# observations that have substantial influence
# on the fitted model.


# --------------------------------------------------
# 13. Leverage
# --------------------------------------------------

leverage <- hatvalues(
  model
)

leverage


plot(
  leverage,
  type = "h",
  main = "Leverage Values",
  xlab = "Observation",
  ylab = "Leverage"
)


# High leverage observations have unusual
# predictor values relative to the rest of
# the dataset.


# --------------------------------------------------
# 14. Studentized residuals
# --------------------------------------------------

studentized_residuals <- rstudent(
  model
)

studentized_residuals


plot(
  studentized_residuals,
  type = "h",
  main = "Studentized Residuals",
  xlab = "Observation",
  ylab = "Studentized Residual"
)

abline(
  h = c(-2, 0, 2),
  lty = 2
)


# --------------------------------------------------
# 15. Influence measures
# --------------------------------------------------

influence.measures(
  model
)


# --------------------------------------------------
# 16. Complete diagnostic plots
# --------------------------------------------------

par(
  mfrow = c(2, 2)
)

plot(
  model
)

par(
  mfrow = c(1, 1)
)


# The standard diagnostic plots include:
#
# 1. Residuals vs Fitted
# 2. Normal Q-Q
# 3. Scale-Location
# 4. Residuals vs Leverage


# --------------------------------------------------
# 17. Model assumptions
# --------------------------------------------------

# Important regression assumptions include:
#
# 1. Linearity
# 2. Independence
# 3. Homoscedasticity
# 4. Appropriate residual distribution for inference
# 5. No highly influential observations
#
# For multiple regression:
#
# 6. No severe multicollinearity


# --------------------------------------------------
# 18. Diagnostic workflow
# --------------------------------------------------

# A useful diagnostic workflow is:
#
# Fit model
#     ↓
# Examine residuals
#     ↓
# Check linearity
#     ↓
# Check variance
#     ↓
# Check residual distribution
#     ↓
# Check multicollinearity
#     ↓
# Check influential observations
#     ↓
# Assess model adequacy
#     ↓
# Consider model refinement if necessary


# --------------------------------------------------
# 19. Important statistical principle
# --------------------------------------------------

# A model should not be modified simply because
# one diagnostic test produces a small p-value.
#
# Statistical diagnostics should be considered
# together with:
#
# - Graphical evidence
# - Study design
# - Subject-matter knowledge
# - Sample size
# - Research objectives
#
# The goal is not to make every diagnostic test
# "non-significant".
#
# The goal is to determine whether the model is
# reasonable for the research question and data.


# --------------------------------------------------
# 20. Statistical interpretation
# --------------------------------------------------

# Model diagnostics help answer questions such as:
#
# - Is the functional form appropriate?
# - Are residuals reasonably behaved?
# - Is the variance approximately constant?
# - Is multicollinearity problematic?
# - Are some observations highly influential?
# - Is the model adequate for the intended purpose?
#
# Diagnostics should be performed before making
# strong conclusions from a fitted model.


# Key idea:
# Model fitting is only one part of statistical analysis.
#
# Fit model
#     ↓
# Diagnose model
#     ↓
# Assess assumptions
#     ↓
# Evaluate adequacy
#     ↓
# Interpret results
#
# A statistically significant model is not necessarily
# an appropriate model.
