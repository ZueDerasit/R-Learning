# Panel Data Analysis
# This script introduces panel data analysis using R.
#
# Panel data combine:
# - Cross-sectional information
# - Time-series information
#
# Example:
# Several countries observed over several years.
#
# Common panel-data models:
# - Pooled OLS
# - Fixed Effects Model (FEM)
# - Random Effects Model (REM)


# --------------------------------------------------
# 1. Create a panel dataset
# --------------------------------------------------

set.seed(123)

countries <- c(
  "Malaysia",
  "Singapore",
  "Thailand",
  "Indonesia",
  "Vietnam"
)

years <- 2018:2022

panel_data <- expand.grid(
  country = countries,
  year = years
)

panel_data <- panel_data[
  order(
    panel_data$country,
    panel_data$year
  ),
]

panel_data$income <- round(
  30000 +
    as.numeric(
      factor(panel_data$country)
    ) * 3000 +
    (panel_data$year - 2018) * 1200 +
    rnorm(
      nrow(panel_data),
      0,
      1500
    ),
  2
)

panel_data$investment <- round(
  5000 +
    0.25 * panel_data$income +
    rnorm(
      nrow(panel_data),
      0,
      1000
    ),
  2
)

panel_data$consumption <- round(
  10000 +
    0.45 * panel_data$income +
    0.30 * panel_data$investment +
    rnorm(
      nrow(panel_data),
      0,
      1200
    ),
  2
)

head(panel_data)


# --------------------------------------------------
# 2. Understand the panel structure
# --------------------------------------------------

str(panel_data)

summary(panel_data)

table(
  panel_data$country
)

table(
  panel_data$year
)


# --------------------------------------------------
# 3. Check the panel dimensions
# --------------------------------------------------

nrow(panel_data)

length(
  unique(panel_data$country)
)

length(
  unique(panel_data$year)
)


# Total observations should equal:
#
# Number of countries × Number of years
#
# In this example:
#
# 5 countries × 5 years = 25 observations


# --------------------------------------------------
# 4. Visualise the panel data
# --------------------------------------------------

# Install once if necessary:
# install.packages("ggplot2")

library(ggplot2)

ggplot(
  panel_data,
  aes(
    x = year,
    y = income,
    group = country,
    colour = country
  )
) +
  geom_line() +
  geom_point() +
  labs(
    title = "Income by Country Over Time",
    x = "Year",
    y = "Income",
    colour = "Country"
  ) +
  theme_minimal()


# --------------------------------------------------
# 5. Install and load plm
# --------------------------------------------------

# The plm package is commonly used for panel-data
# analysis.
#
# Install once if necessary:
# install.packages("plm")

library(plm)


# --------------------------------------------------
# 6. Convert data into a panel-data object
# --------------------------------------------------

pdata <- pdata.frame(
  panel_data,
  index = c(
    "country",
    "year"
  )
)

pdata


# --------------------------------------------------
# 7. Check panel structure
# --------------------------------------------------

pdim(
  pdata
)


# --------------------------------------------------
# 8. Pooled OLS
# --------------------------------------------------

# Pooled OLS treats all observations as one
# combined dataset and ignores country-specific
# effects.

pooled_model <- plm(
  consumption ~ income + investment,
  data = pdata,
  model = "pooling"
)

summary(
  pooled_model
)


# --------------------------------------------------
# 9. Fixed Effects Model
# --------------------------------------------------

# Fixed Effects Model (FEM) controls for
# time-invariant characteristics of each country.
#
# Conceptually:
#
# Y_it = beta1 X1_it + beta2 X2_it
#        + alpha_i + error_it
#
# where:
#
# alpha_i = individual-specific effect

fixed_model <- plm(
  consumption ~ income + investment,
  data = pdata,
  model = "within"
)

summary(
  fixed_model
)


# --------------------------------------------------
# 10. Fixed Effects with time effects
# --------------------------------------------------

# Two-way fixed effects control for:
#
# - Individual effects
# - Time effects

fixed_tw_model <- plm(
  consumption ~ income + investment,
  data = pdata,
  model = "within",
  effect = "twoways"
)

summary(
  fixed_tw_model
)


# --------------------------------------------------
# 11. Random Effects Model
# --------------------------------------------------

# Random Effects Model assumes that the
# individual-specific effect is random and
# uncorrelated with the explanatory variables.

random_model <- plm(
  consumption ~ income + investment,
  data = pdata,
  model = "random"
)

summary(
  random_model
)


# --------------------------------------------------
# 12. Compare pooled OLS and Fixed Effects
# --------------------------------------------------

# F test for individual effects.
#
# Null hypothesis:
# No individual effects are required.
#
# Alternative:
# Individual effects are present.

pFtest(
  fixed_model,
  pooled_model
)


# --------------------------------------------------
# 13. Breusch-Pagan Lagrange Multiplier Test
# --------------------------------------------------

# This test can be used to compare pooled OLS
# against a random-effects specification.

plmtest(
  pooled_model,
  type = "bp"
)


# --------------------------------------------------
# 14. Hausman Test
# --------------------------------------------------

# The Hausman test is commonly used to compare
# Fixed Effects and Random Effects.
#
# Null hypothesis:
# Random Effects is consistent.
#
# Alternative:
# Fixed Effects is preferred under the test
# assumptions.

hausman_test <- phtest(
  fixed_model,
  random_model
)

hausman_test


# --------------------------------------------------
# 15. Panel model comparison
# --------------------------------------------------

summary(
  pooled_model
)

summary(
  fixed_model
)

summary(
  random_model
)


# --------------------------------------------------
# 16. Country-specific effects
# --------------------------------------------------

# Fixed effects estimates can be interpreted
# after accounting for time-invariant
# country-specific characteristics.

fixef(
  fixed_model
)


# --------------------------------------------------
# 17. Extract model residuals
# --------------------------------------------------

fixed_residuals <- residuals(
  fixed_model
)

head(
  fixed_residuals
)


# --------------------------------------------------
# 18. Plot residuals
# --------------------------------------------------

plot(
  fitted(fixed_model),
  fixed_residuals,
  xlab = "Fitted Values",
  ylab = "Residuals",
  main = "Residuals vs Fitted Values"
)

abline(
  h = 0
)


# --------------------------------------------------
# 19. Panel-data heteroskedasticity
# --------------------------------------------------

# Panel data may contain heteroskedasticity.
#
# The Breusch-Pagan test can be applied to
# a panel model.

# install.packages("lmtest")

library(lmtest)

bptest(
  fixed_model
)


# --------------------------------------------------
# 20. Serial correlation in panel data
# --------------------------------------------------

# Panel data may also contain serial correlation
# within entities.

pbgtest(
  fixed_model
)


# --------------------------------------------------
# 21. Cross-sectional dependence
# --------------------------------------------------

# Panel units may be correlated with one another.
#
# Example:
#
# Economic shocks affecting one country may also
# affect neighbouring countries.

# install.packages("plm")

pcdtest(
  fixed_model,
  test = "lm"
)


# --------------------------------------------------
# 22. Robust standard errors
# --------------------------------------------------

# Panel models may require robust standard errors
# when heteroskedasticity or serial correlation
# is present.

coeftest(
  fixed_model,
  vcov = vcovHC(
    fixed_model,
    type = "HC1",
    cluster = "group"
  )
)


# --------------------------------------------------
# 23. First-Difference Model
# --------------------------------------------------

# First differences remove time-invariant
# individual-specific effects.
#
# Conceptually:
#
# ΔY_it = beta1 ΔX1_it
#       + beta2 ΔX2_it
#       + Δerror_it

first_difference_model <- plm(
  consumption ~ income + investment,
  data = pdata,
  model = "fd"
)

summary(
  first_difference_model
)


# --------------------------------------------------
# 24. Within vs First Difference
# --------------------------------------------------

# Both approaches can eliminate
# time-invariant individual effects.
#
# Fixed Effects:
# Uses deviations from individual means.
#
# First Difference:
# Uses changes between consecutive periods.


# --------------------------------------------------
# 25. Interpretation of Fixed Effects
# --------------------------------------------------

# For a Fixed Effects model:
#
# A coefficient represents the expected change
# in the dependent variable associated with a
# one-unit change in an explanatory variable,
# holding the other included variables constant,
# after controlling for time-invariant
# individual-specific effects.
#
# The interpretation is therefore based on
# within-unit variation.


# --------------------------------------------------
# 26. Important distinction
# --------------------------------------------------

# Pooled OLS:
#
# Treats all observations as one pooled dataset.
#
#
# Fixed Effects:
#
# Controls for unobserved time-invariant
# characteristics of each entity.
#
#
# Random Effects:
#
# Treats individual-specific effects as random
# and assumes they are uncorrelated with
# explanatory variables.


# --------------------------------------------------
# 27. Panel-data workflow
# --------------------------------------------------

# Research Question
#        ↓
# Identify panel structure
#        ↓
# Inspect missing values and duplicates
#        ↓
# Check dependent and explanatory variables
#        ↓
# Estimate Pooled OLS
#        ↓
# Consider Fixed Effects / Random Effects
#        ↓
# Model specification tests
#        ↓
# Diagnostic tests
#        ↓
# Robust standard errors if appropriate
#        ↓
# Interpret coefficients
#        ↓
# Report model and assumptions


# --------------------------------------------------
# 28. Key statistical considerations
# --------------------------------------------------

# Panel-data analysis requires attention to:
#
# - Individual effects
# - Time effects
# - Heteroskedasticity
# - Serial correlation
# - Cross-sectional dependence
# - Missing observations
# - Balanced vs unbalanced panels
# - Endogeneity
# - Model specification
# - Appropriate standard errors


# --------------------------------------------------
# 29. Balanced vs unbalanced panel
# --------------------------------------------------

# Balanced panel:
#
# Every entity has observations for every period.
#
# Example:
#
# 5 countries × 5 years = 25 observations.
#
#
# Unbalanced panel:
#
# Some entities have missing time periods.


# --------------------------------------------------
# 30. Key idea
# --------------------------------------------------

# Panel data combine:
#
# Cross-sectional dimension
# +
# Time dimension
#
#
# Pooled OLS
#     ↓
# Common relationship
#
# Fixed Effects
#     ↓
# Controls for time-invariant
# entity-specific characteristics
#
# Random Effects
#     ↓
# Models entity-specific effects
# as random
#
#
# Panel-data analysis is especially useful when
# repeated observations are available for the
# same individuals, firms, countries, regions,
# or other entities over time.
