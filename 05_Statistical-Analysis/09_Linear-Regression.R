# Linear Regression
# This script demonstrates simple and multiple linear
# regression using R.


# --------------------------------------------------
# 1. Create a sample dataset
# --------------------------------------------------

students <- data.frame(
  name = c(
    "Ali", "Siti", "John", "Mei", "Maria",
    "Adam", "Sara", "David", "Aina", "Daniel"
  ),
  study_hours = c(2, 4, 3, 5, 6, 4, 5, 2, 6, 3),
  attendance = c(70, 85, 75, 90, 95, 82, 88, 68, 92, 78),
  score = c(65, 85, 72, 90, 95, 78, 88, 70, 92, 80)
)

students


# --------------------------------------------------
# 2. Explore the relationship
# --------------------------------------------------

plot(
  students$study_hours,
  students$score,
  main = "Study Hours and Examination Score",
  xlab = "Study Hours",
  ylab = "Score",
  pch = 19
)


# --------------------------------------------------
# 3. Simple linear regression
# --------------------------------------------------

# Research question:
# Does study time predict examination score?
#
# Model:
#
# score = beta0 + beta1(study_hours) + error

simple_model <- lm(
  score ~ study_hours,
  data = students
)

simple_model


# --------------------------------------------------
# 4. Regression summary
# --------------------------------------------------

summary(simple_model)


# --------------------------------------------------
# 5. Regression coefficients
# --------------------------------------------------

coef(simple_model)

# Intercept

coef(simple_model)[1]

# Slope for study_hours

coef(simple_model)[2]


# --------------------------------------------------
# 6. Confidence intervals for coefficients
# --------------------------------------------------

confint(
  simple_model
)


# --------------------------------------------------
# 7. Add regression line
# --------------------------------------------------

plot(
  students$study_hours,
  students$score,
  main = "Linear Regression",
  xlab = "Study Hours",
  ylab = "Score",
  pch = 19
)

abline(
  simple_model
)


# --------------------------------------------------
# 8. Fitted values and residuals
# --------------------------------------------------

students$fitted_values <- fitted(
  simple_model
)

students$residuals <- residuals(
  simple_model
)

students


# --------------------------------------------------
# 9. Prediction
# --------------------------------------------------

# Predict examination score for a student
# who studies for 5 hours.

new_student <- data.frame(
  study_hours = 5
)

predict(
  simple_model,
  newdata = new_student
)


# Prediction interval

predict(
  simple_model,
  newdata = new_student,
  interval = "prediction"
)


# Confidence interval for the mean response

predict(
  simple_model,
  newdata = new_student,
  interval = "confidence"
)


# --------------------------------------------------
# 10. Multiple linear regression
# --------------------------------------------------

# Add attendance as another predictor.
#
# Model:
#
# score =
# beta0
# + beta1(study_hours)
# + beta2(attendance)
# + error

multiple_model <- lm(
  score ~ study_hours + attendance,
  data = students
)

summary(
  multiple_model
)


# --------------------------------------------------
# 11. Interpret regression coefficients
# --------------------------------------------------

# The coefficient for study_hours represents
# the expected change in score for a one-unit
# increase in study_hours, holding attendance
# constant.
#
# The coefficient for attendance represents
# the expected change in score for a one-unit
# increase in attendance, holding study_hours
# constant.


# --------------------------------------------------
# 12. R-squared
# --------------------------------------------------

summary(simple_model)$r.squared

summary(multiple_model)$r.squared


# Adjusted R-squared

summary(simple_model)$adj.r.squared

summary(multiple_model)$adj.r.squared


# --------------------------------------------------
# 13. Compare simple and multiple models
# --------------------------------------------------

anova(
  simple_model,
  multiple_model
)


# --------------------------------------------------
# 14. Model diagnostics
# --------------------------------------------------

# Four standard diagnostic plots

par(
  mfrow = c(2, 2)
)

plot(
  multiple_model
)

par(
  mfrow = c(1, 1)
)


# --------------------------------------------------
# 15. Residuals vs fitted values
# --------------------------------------------------

plot(
  multiple_model,
  which = 1
)


# --------------------------------------------------
# 16. Normal Q-Q plot
# --------------------------------------------------

plot(
  multiple_model,
  which = 2
)


# --------------------------------------------------
# 17. Scale-location plot
# --------------------------------------------------

plot(
  multiple_model,
  which = 3
)


# --------------------------------------------------
# 18. Residuals vs leverage
# --------------------------------------------------

plot(
  multiple_model,
  which = 5
)


# --------------------------------------------------
# 19. Formal tests for assumptions
# --------------------------------------------------

# Normality of residuals

shapiro.test(
  residuals(multiple_model)
)


# --------------------------------------------------
# 20. Heteroscedasticity
# --------------------------------------------------

# The lmtest package provides the Breusch-Pagan test.
#
# Install once if necessary:
# install.packages("lmtest")

library(lmtest)

bptest(
  multiple_model
)


# --------------------------------------------------
# 21. Multicollinearity
# --------------------------------------------------

# The car package provides the VIF function.
#
# Install once if necessary:
# install.packages("car")

library(car)

vif(
  multiple_model
)


# --------------------------------------------------
# 22. Influential observations
# --------------------------------------------------

# Cook's distance

cooks_distance <- cooks.distance(
  multiple_model
)

cooks_distance


plot(
  cooks_distance,
  type = "h",
  main = "Cook's Distance",
  ylab = "Cook's Distance"
)


# --------------------------------------------------
# 23. Statistical interpretation
# --------------------------------------------------

# Linear regression can be used to:
#
# - Quantify relationships between variables
# - Estimate regression coefficients
# - Test whether predictors are associated with
#   the response variable
# - Estimate expected outcomes
# - Generate predictions
#
# Important outputs include:
#
# Coefficients
# → Estimated effects of predictors
#
# Standard errors
# → Uncertainty of coefficient estimates
#
# t-statistics and p-values
# → Evidence against coefficient = 0
#
# Confidence intervals
# → Uncertainty around coefficient estimates
#
# R-squared
# → Proportion of sample variation explained
#   by the model
#
# Adjusted R-squared
# → R-squared adjusted for the number of predictors


# --------------------------------------------------
# 24. Important assumptions
# --------------------------------------------------

# Common linear regression assumptions include:
#
# 1. Linearity
# 2. Independence of observations
# 3. Homoscedasticity
# 4. Appropriate residual distribution for inference
# 5. No highly influential observations
#
# In multiple regression, multicollinearity should
# also be examined.


# --------------------------------------------------
# 25. Statistical interpretation
# --------------------------------------------------

# Example:
#
# "After controlling for attendance, study hours
# were associated with examination score.
# The estimated regression coefficient was ...
# with a 95% confidence interval of [..., ...]."
#
# The actual coefficient, confidence interval,
# p-value, and R-squared should be reported
# based on the fitted model.


# Key idea:
# Linear regression is not simply about fitting
# a straight line.
#
# A proper regression analysis involves:
#
# Research question
#       ↓
# Model specification
#       ↓
# Estimate coefficients
#       ↓
# Assess uncertainty
#       ↓
# Check assumptions
#       ↓
# Assess model adequacy
#       ↓
# Interpret coefficients
#       ↓
# Make predictions when appropriate
