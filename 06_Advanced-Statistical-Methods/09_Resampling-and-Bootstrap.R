# Resampling and Bootstrap
# This script introduces resampling methods,
# bootstrap estimation, confidence intervals,
# permutation tests, and cross-validation.
#
# Resampling methods repeatedly use the observed
# sample to learn about sampling variability,
# uncertainty, or model performance.
#
# Important methods covered:
# - Bootstrap
# - Bootstrap confidence intervals
# - Permutation tests
# - Cross-validation


# --------------------------------------------------
# 1. Example data
# --------------------------------------------------

set.seed(123)

scores <- c(
  72, 75, 78, 80, 81,
  83, 85, 87, 90, 92
)

mean(scores)

median(scores)

sd(scores)


# --------------------------------------------------
# 2. Sampling with replacement
# --------------------------------------------------

# Bootstrap samples are created by repeatedly
# sampling observations WITH replacement.
#
# Because sampling is with replacement, the same
# observation may appear more than once.

bootstrap_sample <- sample(
  scores,
  size = length(scores),
  replace = TRUE
)

bootstrap_sample


# --------------------------------------------------
# 3. Bootstrap estimate of the mean
# --------------------------------------------------

set.seed(123)

B <- 5000

bootstrap_means <- numeric(B)

for (i in 1:B) {

  bootstrap_sample <- sample(
    scores,
    size = length(scores),
    replace = TRUE
  )

  bootstrap_means[i] <- mean(
    bootstrap_sample
  )
}

head(
  bootstrap_means
)


# --------------------------------------------------
# 4. Visualise the bootstrap distribution
# --------------------------------------------------

hist(
  bootstrap_means,
  breaks = 30,
  main = "Bootstrap Distribution of the Mean",
  xlab = "Bootstrap Mean"
)

abline(
  v = mean(scores),
  lwd = 2
)


# --------------------------------------------------
# 5. Bootstrap standard error
# --------------------------------------------------

bootstrap_se <- sd(
  bootstrap_means
)

bootstrap_se


# --------------------------------------------------
# 6. Compare with the classical standard error
# --------------------------------------------------

classical_se <- sd(scores) /
  sqrt(length(scores))

classical_se


# The bootstrap standard error estimates the
# sampling variability of the statistic using
# the observed sample.


# --------------------------------------------------
# 7. Percentile bootstrap confidence interval
# --------------------------------------------------

quantile(
  bootstrap_means,
  probs = c(
    0.025,
    0.975
  )
)


# --------------------------------------------------
# 8. Bootstrap confidence interval using
# the boot package
# --------------------------------------------------

# The boot package provides tools for systematic
# bootstrap analysis.
#
# Install once if necessary:
# install.packages("boot")

library(boot)


# Define a statistic function.

mean_function <- function(
  data,
  indices
) {

  sample_data <- data[
    indices
  ]

  return(
    mean(sample_data)
  )
}


# Run the bootstrap.

set.seed(123)

boot_mean <- boot(
  data = scores,
  statistic = mean_function,
  R = 5000
)

boot_mean


# --------------------------------------------------
# 9. Bootstrap confidence intervals
# --------------------------------------------------

# Percentile interval

boot.ci(
  boot_mean,
  type = "perc"
)


# Basic bootstrap interval

boot.ci(
  boot_mean,
  type = "basic"
)


# Normal approximation interval

boot.ci(
  boot_mean,
  type = "norm"
)


# --------------------------------------------------
# 10. Bootstrap confidence interval types
# --------------------------------------------------

# Common approaches include:
#
# - Normal approximation
# - Basic bootstrap
# - Percentile
# - BCa
#
# BCa = Bias-Corrected and Accelerated


boot.ci(
  boot_mean,
  type = "bca"
)


# --------------------------------------------------
# 11. Bootstrap median
# --------------------------------------------------

median_function <- function(
  data,
  indices
) {

  sample_data <- data[
    indices
  ]

  return(
    median(sample_data)
  )
}


set.seed(123)

boot_median <- boot(
  data = scores,
  statistic = median_function,
  R = 5000
)

boot_median


boot.ci(
  boot_median,
  type = "perc"
)


# --------------------------------------------------
# 12. Bootstrap correlation
# --------------------------------------------------

study_hours <- c(
  2, 3, 4, 5, 5,
  6, 7, 8, 9, 10
)

exam_score <- c(
  55, 60, 63, 68, 70,
  74, 78, 82, 88, 91
)

cor(
  study_hours,
  exam_score
)


cor_function <- function(
  data,
  indices
) {

  sample_data <- data[
    indices,
  ]

  return(
    cor(
      sample_data$study_hours,
      sample_data$exam_score
    )
  )
}


cor_data <- data.frame(
  study_hours,
  exam_score
)


set.seed(123)

boot_cor <- boot(
  data = cor_data,
  statistic = cor_function,
  R = 5000
)

boot_cor


boot.ci(
  boot_cor,
  type = "perc"
)


# --------------------------------------------------
# 13. Bootstrap regression coefficient
# --------------------------------------------------

# Bootstrap can also be used to estimate the
# uncertainty of regression coefficients.

regression_function <- function(
  data,
  indices
) {

  sample_data <- data[
    indices,
  ]

  model <- lm(
    exam_score ~ study_hours,
    data = sample_data
  )

  return(
    coef(model)[2]
  )
}


set.seed(123)

boot_slope <- boot(
  data = cor_data,
  statistic = regression_function,
  R = 5000
)

boot_slope


boot.ci(
  boot_slope,
  type = "perc"
)


# --------------------------------------------------
# 14. Bootstrap concept
# --------------------------------------------------

# Original sample
#       ↓
# Resample with replacement
#       ↓
# Bootstrap sample
#       ↓
# Calculate statistic
#       ↓
# Repeat many times
#       ↓
# Bootstrap distribution
#       ↓
# Estimate uncertainty


# --------------------------------------------------
# 15. Permutation test
# --------------------------------------------------

# A permutation test evaluates a null hypothesis
# by rearranging or permuting observations.
#
# It does not require the usual parametric
# distributional assumptions.


group_A <- c(
  72, 75, 78, 80, 82
)

group_B <- c(
  85, 87, 90, 92, 95
)


# Observed difference in means

observed_difference <- mean(group_A) -
  mean(group_B)

observed_difference


# --------------------------------------------------
# 16. Manual permutation test
# --------------------------------------------------

set.seed(123)

combined_scores <- c(
  group_A,
  group_B
)

n_A <- length(group_A)

B <- 5000

permuted_differences <- numeric(B)

for (i in 1:B) {

  shuffled <- sample(
    combined_scores
  )

  permuted_A <- shuffled[
    1:n_A
  ]

  permuted_B <- shuffled[
    (n_A + 1):length(shuffled)
  ]

  permuted_differences[i] <-
    mean(permuted_A) -
    mean(permuted_B)
}


# --------------------------------------------------
# 17. Visualise permutation distribution
# --------------------------------------------------

hist(
  permuted_differences,
  breaks = 30,
  main = "Permutation Distribution",
  xlab = "Difference in Means"
)

abline(
  v = observed_difference,
  lwd = 2
)

abline(
  v = -abs(observed_difference),
  lty = 2
)

abline(
  v = abs(observed_difference),
  lty = 2
)


# --------------------------------------------------
# 18. Permutation p-value
# --------------------------------------------------

permutation_p <- mean(
  abs(permuted_differences) >=
    abs(observed_difference)
)

permutation_p


# --------------------------------------------------
# 19. Permutation test using a function
# --------------------------------------------------

# A permutation test can also be implemented
# using specialised packages or custom functions.
#
# The main principle remains:
#
# Observed statistic
#       ↓
# Randomly rearrange data
#       ↓
# Recalculate statistic
#       ↓
# Repeat many times
#       ↓
# Compare observed statistic
# with the null distribution


# --------------------------------------------------
# 20. Bootstrap vs permutation
# --------------------------------------------------

# Bootstrap:
#
# Main purpose:
# Estimate sampling variability and uncertainty.
#
# Sampling:
# WITH replacement.
#
#
# Permutation:
#
# Main purpose:
# Test a null hypothesis.
#
# Sampling:
# Rearrangement WITHOUT replacement.


# --------------------------------------------------
# 21. Cross-validation
# --------------------------------------------------

# Cross-validation is another important
# resampling method.
#
# It is commonly used for:
#
# - Model evaluation
# - Model comparison
# - Hyperparameter selection
# - Estimating predictive performance


# --------------------------------------------------
# 22. Create a regression dataset
# --------------------------------------------------

set.seed(123)

model_data <- data.frame(
  study_hours = runif(
    100,
    1,
    10
  )
)

model_data$exam_score <-
  40 +
  5 * model_data$study_hours +
  rnorm(
    100,
    0,
    5
  )


# --------------------------------------------------
# 23. Train-test split
# --------------------------------------------------

set.seed(123)

train_index <- sample(
  1:nrow(model_data),
  size = 0.8 * nrow(model_data)
)

train_data <- model_data[
  train_index,
]

test_data <- model_data[
  -train_index,
]


# Fit model

model <- lm(
  exam_score ~ study_hours,
  data = train_data
)

summary(
  model
)


# Predictions

predictions <- predict(
  model,
  newdata = test_data
)


# RMSE

rmse <- sqrt(
  mean(
    (
      test_data$exam_score -
        predictions
    )^2
  )
)

rmse


# --------------------------------------------------
# 24. K-fold cross-validation
# --------------------------------------------------

# The rsample package can be used to create
# resampling folds.
#
# Install once if necessary:
# install.packages("rsample")

library(rsample)

set.seed(123)

folds <- vfold_cv(
  model_data,
  v = 5
)

folds


# --------------------------------------------------
# 25. Manual 5-fold cross-validation
# --------------------------------------------------

set.seed(123)

fold_id <- sample(
  rep(
    1:5,
    length.out = nrow(model_data)
  )
)

cv_results <- numeric(5)

for (k in 1:5) {

  train_data <- model_data[
    fold_id != k,
  ]

  validation_data <- model_data[
    fold_id == k,
  ]

  model <- lm(
    exam_score ~ study_hours,
    data = train_data
  )

  predictions <- predict(
    model,
    newdata = validation_data
  )

  cv_results[k] <- sqrt(
    mean(
      (
        validation_data$exam_score -
          predictions
      )^2
    )
  )
}


cv_results

mean(
  cv_results
)


# --------------------------------------------------
# 26. Cross-validation workflow
# --------------------------------------------------

# Original dataset
#       ↓
# Divide into folds
#       ↓
# Train model on training folds
#       ↓
# Evaluate on validation fold
#       ↓
# Repeat for every fold
#       ↓
# Average performance
#       ↓
# Estimate generalisation performance


# --------------------------------------------------
# 27. Why cross-validation matters
# --------------------------------------------------

# Training performance can be overly optimistic.
#
# A model may fit the training data very well
# but perform poorly on new observations.
#
# Cross-validation provides a more realistic
# estimate of predictive performance.


# --------------------------------------------------
# 28. Common performance measures
# --------------------------------------------------

# Regression:
#
# - RMSE
# - MAE
# - R-squared
#
#
# Classification:
#
# - Accuracy
# - Sensitivity
# - Specificity
# - Precision
# - Recall
# - F1-score
# - ROC-AUC


# --------------------------------------------------
# 29. Important distinction
# --------------------------------------------------

# Statistical inference:
#
# Focus:
# Estimating parameters and uncertainty.
#
# Examples:
# - Bootstrap confidence intervals
# - Standard errors
#
#
# Predictive modelling:
#
# Focus:
# How well a model predicts new observations.
#
# Examples:
# - Cross-validation
# - Test-set evaluation


# --------------------------------------------------
# 30. Resampling methods and research
# --------------------------------------------------

# Resampling methods are useful when:
#
# - Classical standard errors are unreliable
# - Sampling distributions are complicated
# - The statistic has no simple analytical formula
# - Predictive performance must be estimated
# - Model selection requires validation


# --------------------------------------------------
# 31. Important cautions
# --------------------------------------------------

# Bootstrap is not automatically valid for every
# data structure.
#
# Special approaches may be required for:
#
# - Time-series data
# - Clustered data
# - Hierarchical data
# - Dependent observations
#
# For example, ordinary bootstrap resampling of
# individual observations can break the temporal
# structure of a time series.


# --------------------------------------------------
# 32. Reproducibility
# --------------------------------------------------

# Always consider using set.seed() when performing
# random resampling.
#
# This makes the analysis reproducible.

set.seed(123)


# --------------------------------------------------
# 33. Recommended workflow
# --------------------------------------------------

# Research Question
#       ↓
# Identify target statistic/model
#       ↓
# Choose resampling strategy
#       ↓
# Generate resamples
#       ↓
# Calculate statistic/model performance
#       ↓
# Repeat many times
#       ↓
# Examine resampling distribution
#       ↓
# Estimate uncertainty or performance
#       ↓
# Interpret results


# --------------------------------------------------
# 34. Key idea
# --------------------------------------------------

# Bootstrap:
#
# Estimate uncertainty
# through repeated sampling
# with replacement.
#
#
# Permutation:
#
# Construct a null distribution
# by rearranging observations.
#
#
# Cross-validation:
#
# Estimate predictive performance
# on unseen data.
#
#
# Resampling provides a flexible framework
# for statistical inference and model evaluation.
