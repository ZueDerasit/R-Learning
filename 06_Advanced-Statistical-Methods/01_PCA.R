# Principal Component Analysis (PCA)
# This script introduces Principal Component Analysis
# as a dimensionality reduction technique.
#
# PCA transforms correlated variables into a smaller
# number of uncorrelated components while preserving
# as much variation in the data as possible.


# --------------------------------------------------
# 1. Create a sample dataset
# --------------------------------------------------

students <- data.frame(
  mathematics = c(
    75, 82, 68, 90, 88,
    72, 95, 70, 85, 78
  ),
  statistics = c(
    78, 85, 70, 92, 90,
    75, 94, 73, 88, 80
  ),
  programming = c(
    70, 80, 65, 88, 85,
    68, 92, 72, 82, 76
  ),
  research_methods = c(
    76, 84, 72, 91, 89,
    74, 93, 75, 86, 79
  )
)

students


# --------------------------------------------------
# 2. Explore the variables
# --------------------------------------------------

summary(students)

str(students)

cor(students)


# --------------------------------------------------
# 3. Visualise the correlation matrix
# --------------------------------------------------

correlation_matrix <- cor(
  students
)

correlation_matrix

# A heatmap can be created using packages such as
# corrplot.
#
# Install once if necessary:
# install.packages("corrplot")

library(corrplot)

corrplot(
  correlation_matrix,
  method = "number"
)


# --------------------------------------------------
# 4. Standardise the variables
# --------------------------------------------------

# PCA is sensitive to differences in measurement scale.
#
# scale() standardises each variable to:
#
# Mean = 0
# Standard deviation = 1

students_scaled <- scale(
  students
)

students_scaled


# --------------------------------------------------
# 5. Perform PCA
# --------------------------------------------------

pca_model <- prcomp(
  students_scaled,
  center = TRUE,
  scale. = TRUE
)

pca_model


# --------------------------------------------------
# 6. PCA summary
# --------------------------------------------------

summary(
  pca_model
)


# The summary provides:
#
# Standard deviation of each component
# Proportion of variance explained
# Cumulative proportion of variance explained


# --------------------------------------------------
# 7. Standard deviations of components
# --------------------------------------------------

pca_model$sdev


# --------------------------------------------------
# 8. Variance explained
# --------------------------------------------------

variance_explained <- pca_model$sdev^2

variance_explained


# Proportion of variance explained

proportion_variance <- (
  variance_explained /
    sum(variance_explained)
)

proportion_variance


# Cumulative variance explained

cumulative_variance <- cumsum(
  proportion_variance
)

cumulative_variance


# --------------------------------------------------
# 9. Create a PCA summary table
# --------------------------------------------------

pca_summary <- data.frame(
  component = paste0(
    "PC",
    seq_along(proportion_variance)
  ),
  eigenvalue = variance_explained,
  proportion_variance =
    proportion_variance,
  cumulative_variance =
    cumulative_variance
)

pca_summary


# --------------------------------------------------
# 10. Scree plot
# --------------------------------------------------

plot(
  pca_model,
  type = "l",
  main = "Scree Plot"
)


# --------------------------------------------------
# 11. Cumulative variance plot
# --------------------------------------------------

plot(
  cumulative_variance,
  type = "b",
  pch = 19,
  xlab = "Number of Principal Components",
  ylab = "Cumulative Proportion of Variance",
  main = "Cumulative Variance Explained"
)

abline(
  h = 0.80,
  lty = 2
)


# --------------------------------------------------
# 12. PCA loadings
# --------------------------------------------------

pca_model$rotation


# Loadings indicate the contribution of the
# original variables to each principal component.


# --------------------------------------------------
# 13. Inspect the first principal component
# --------------------------------------------------

pca_model$rotation[, 1]


# --------------------------------------------------
# 14. Inspect the second principal component
# --------------------------------------------------

pca_model$rotation[, 2]


# --------------------------------------------------
# 15. Principal component scores
# --------------------------------------------------

pca_scores <- pca_model$x

pca_scores


# --------------------------------------------------
# 16. Use the first two principal components
# --------------------------------------------------

plot(
  pca_scores[, 1],
  pca_scores[, 2],
  pch = 19,
  xlab = "PC1",
  ylab = "PC2",
  main = "PCA Score Plot"
)


# --------------------------------------------------
# 17. Biplot
# --------------------------------------------------

biplot(
  pca_model,
  main = "PCA Biplot"
)


# --------------------------------------------------
# 18. Dimension reduction
# --------------------------------------------------

# Suppose the first two components explain
# a sufficiently large proportion of the total
# variance.
#
# We can represent the original four variables
# using two principal components.

reduced_data <- pca_scores[
  ,
  1:2
]

reduced_data


# --------------------------------------------------
# 19. Reconstructing the data conceptually
# --------------------------------------------------

# PCA represents the original variables as
# linear combinations of principal components.
#
# General form:
#
# PC1 =
# loading1(X1)
# + loading2(X2)
# + ...
#
# Each principal component is a linear combination
# of the original standardised variables.


# --------------------------------------------------
# 20. Eigenvalues
# --------------------------------------------------

# Eigenvalues represent the amount of variance
# explained by each principal component.

eigenvalues <- pca_model$sdev^2

eigenvalues


# Kaiser criterion:
#
# For standardised variables, components with
# eigenvalues greater than 1 are sometimes retained.
#
# This is a rule of thumb and should not be used
# automatically.


# --------------------------------------------------
# 21. Missing values
# --------------------------------------------------

# prcomp() does not directly handle missing values.
#
# Example:
#
# students_with_na <- students
# students_with_na[1, 1] <- NA
#
# pca_model <- prcomp(
#   students_with_na,
#   scale. = TRUE
# )
#
# This would produce an error because of NA values.
#
# Missing data should therefore be handled appropriately
# before PCA.


# --------------------------------------------------
# 22. Important considerations
# --------------------------------------------------

# PCA is generally appropriate when:
#
# - Several quantitative variables are available
# - Variables may be correlated
# - Dimensionality reduction is useful
# - A smaller set of components is desirable
#
# Important considerations include:
#
# - Variable scaling
# - Correlation structure
# - Sample size
# - Number of variables
# - Missing data
# - Interpretation of loadings
# - Number of components retained


# --------------------------------------------------
# 23. PCA interpretation
# --------------------------------------------------

# PCA does not automatically identify meaningful
# "latent factors".
#
# Principal components are mathematical
# transformations of the original variables.
#
# Interpretation depends on the loading pattern.
#
# For example:
#
# If PC1 has high positive loadings for:
#
# Mathematics
# Statistics
# Programming
# Research Methods
#
# PC1 may represent a general academic
# performance dimension.
#
# This interpretation must be supported by
# the loading structure and research context.


# --------------------------------------------------
# 24. PCA vs original variables
# --------------------------------------------------

# Original data:
#
# X1 X2 X3 X4
#
# PCA:
#
# PC1 PC2 PC3 PC4
#
# The principal components are:
#
# - Linear combinations of original variables
# - Ordered by variance explained
# - Orthogonal to one another
#
# Therefore, PCA can reduce dimensionality
# while retaining much of the information
# contained in the original variables.


# --------------------------------------------------
# 25. Statistical interpretation
# --------------------------------------------------

# PCA can be used to:
#
# - Reduce dimensionality
# - Handle correlated predictors
# - Create composite dimensions
# - Visualise high-dimensional data
# - Prepare data for subsequent modelling
#
# PCA is especially useful when many variables
# contain overlapping information.


# Key idea:
#
# PCA transforms:
#
# Many correlated variables
#          ↓
# Fewer principal components
#
# The goal is to retain as much variation
# as possible using fewer dimensions.
#
# Always interpret PCA using:
#
# - Variance explained
# - Loadings
# - Score structure
# - Research context
