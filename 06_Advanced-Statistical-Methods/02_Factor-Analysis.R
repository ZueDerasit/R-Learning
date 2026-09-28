# Factor Analysis
# This script introduces Exploratory Factor Analysis (EFA)
# for identifying underlying latent factors from observed
# variables.


# --------------------------------------------------
# 1. Create a sample dataset
# --------------------------------------------------

students <- data.frame(
  mathematics = c(
    75, 82, 68, 90, 88,
    72, 95, 70, 85, 78,
    80, 91, 73, 87, 84,
    76, 89, 71, 93, 81
  ),
  statistics = c(
    78, 85, 70, 92, 90,
    75, 94, 73, 88, 80,
    82, 93, 76, 89, 86,
    79, 91, 74, 95, 83
  ),
  programming = c(
    70, 80, 65, 88, 85,
    68, 92, 72, 82, 76,
    84, 90, 69, 86, 81,
    73, 88, 67, 91, 79
  ),
  research_methods = c(
    76, 84, 72, 91, 89,
    74, 93, 75, 86, 79,
    83, 92, 74, 88, 85,
    77, 90, 73, 94, 82
  ),
  communication = c(
    68, 75, 82, 78, 85,
    80, 72, 88, 76, 90,
    84, 79, 91, 73, 87,
    81, 77, 89, 74, 86
  ),
  presentation = c(
    70, 78, 85, 80, 88,
    82, 75, 90, 79, 92,
    86, 81, 93, 76, 89,
    84, 80, 91, 77, 88
  )
)

students


# --------------------------------------------------
# 2. Inspect the correlation structure
# --------------------------------------------------

correlation_matrix <- cor(
  students
)

correlation_matrix


# --------------------------------------------------
# 3. Visualise correlations
# --------------------------------------------------

# Install once if necessary:
# install.packages("corrplot")

library(corrplot)

corrplot(
  correlation_matrix,
  method = "number"
)


# --------------------------------------------------
# 4. Assess suitability for factor analysis
# --------------------------------------------------

# Factor analysis is appropriate when variables
# share sufficient common variance.

# Kaiser-Meyer-Olkin (KMO) measure and Bartlett's
# test of sphericity can be used for assessment.

# Install once if necessary:
# install.packages("psych")

library(psych)

KMO(
  correlation_matrix
)


# Bartlett's test

cortest.bartlett(
  correlation_matrix,
  n = nrow(students)
)


# --------------------------------------------------
# 5. Determine the number of factors
# --------------------------------------------------

# Parallel analysis can help determine the
# number of factors to retain.

fa.parallel(
  students,
  fa = "fa",
  fm = "minres"
)


# --------------------------------------------------
# 6. Exploratory Factor Analysis
# --------------------------------------------------

# Suppose two factors are retained.

efa_model <- fa(
  students,
  nfactors = 2,
  rotate = "varimax",
  fm = "minres"
)

efa_model


# --------------------------------------------------
# 7. Factor loadings
# --------------------------------------------------

efa_model$loadings


# Factor loadings describe the relationship
# between observed variables and latent factors.


# --------------------------------------------------
# 8. Communalities
# --------------------------------------------------

efa_model$communality


# Communality represents the proportion of
# variance in an observed variable explained
# by the retained common factors.


# --------------------------------------------------
# 9. Uniqueness
# --------------------------------------------------

efa_model$uniquenesses


# Uniqueness represents the proportion of variance
# not explained by the common factors.


# --------------------------------------------------
# 10. Factor scores
# --------------------------------------------------

factor_scores <- factor.scores(
  students,
  efa_model
)

factor_scores$scores


# --------------------------------------------------
# 11. Factor score plot
# --------------------------------------------------

plot(
  factor_scores$scores[, 1],
  factor_scores$scores[, 2],
  pch = 19,
  xlab = "Factor 1",
  ylab = "Factor 2",
  main = "Factor Score Plot"
)


# --------------------------------------------------
# 12. Rotation
# --------------------------------------------------

# Rotation is used to obtain a more interpretable
# factor structure.
#
# Varimax:
# → Orthogonal rotation
# → Factors remain uncorrelated
#
# Oblimin:
# → Oblique rotation
# → Factors are allowed to correlate


# Example of oblique rotation

efa_oblimin <- fa(
  students,
  nfactors = 2,
  rotate = "oblimin",
  fm = "minres"
)

efa_oblimin


# --------------------------------------------------
# 13. Compare rotations
# --------------------------------------------------

efa_model$loadings

efa_oblimin$loadings


# --------------------------------------------------
# 14. Choosing the number of factors
# --------------------------------------------------

# There is no single rule that should determine
# the number of factors.
#
# Consider:
#
# - Parallel analysis
# - Scree plot
# - Eigenvalues
# - Interpretability
# - Theoretical framework
# - Number of variables
# - Sample size


# --------------------------------------------------
# 15. PCA versus Factor Analysis
# --------------------------------------------------

# PCA:
#
# Purpose:
# Dimensionality reduction
#
# Components:
# Linear combinations of observed variables
#
# Focus:
# Total variance
#
#
# Factor Analysis:
#
# Purpose:
# Identify underlying latent factors
#
# Factors:
# Latent constructs inferred from observed variables
#
# Focus:
# Common variance


# --------------------------------------------------
# 16. Factor analysis assumptions and considerations
# --------------------------------------------------

# Important considerations include:
#
# - Adequate sample size
# - Sufficient correlations among variables
# - Appropriate measurement characteristics
# - Factorability of the correlation matrix
# - Appropriate factor extraction method
# - Appropriate rotation method
# - Interpretability of factor loadings


# --------------------------------------------------
# 17. Interpretation of factor loadings
# --------------------------------------------------

# A high absolute loading indicates that an
# observed variable is strongly associated
# with a factor.
#
# Example:
#
# If:
#
# mathematics       → high loading on Factor 1
# statistics        → high loading on Factor 1
# programming       → high loading on Factor 1
#
# Factor 1 may represent a quantitative
# academic ability construct.
#
# If:
#
# communication     → high loading on Factor 2
# presentation      → high loading on Factor 2
#
# Factor 2 may represent a communication-related
# construct.
#
# The actual interpretation must be supported
# by theory and the observed loading pattern.


# --------------------------------------------------
# 18. Statistical interpretation
# --------------------------------------------------

# Exploratory Factor Analysis can be used to:
#
# - Identify latent structures
# - Reduce a set of correlated variables
#   into interpretable factors
# - Explore dimensions underlying observed measures
# - Support scale development
# - Inform subsequent statistical modelling
#
# Factor analysis should not be interpreted as
# automatically discovering "true" hidden variables.
# Factor interpretation requires statistical evidence
# and substantive/theoretical justification.


# Key idea:
#
# Observed Variables
#        ↓
# Shared Variance
#        ↓
# Latent Factors
#
# PCA asks:
# "How can I reduce many variables into fewer
# dimensions while retaining variance?"
#
# Factor Analysis asks:
# "What underlying latent factors may explain
# the correlations among observed variables?"
