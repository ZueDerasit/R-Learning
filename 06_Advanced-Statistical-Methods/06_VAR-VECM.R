# VAR and VECM
# This script introduces Vector Autoregression (VAR)
# and Vector Error Correction Models (VECM).
#
# VAR is used for multivariate time series where
# several variables may dynamically influence one another.
#
# VECM is useful when non-stationary variables are
# cointegrated and therefore share a long-run equilibrium
# relationship.


# --------------------------------------------------
# 1. Create a multivariate time series
# --------------------------------------------------

set.seed(123)

n <- 120

income <- cumsum(
  rnorm(
    n,
    mean = 0.5,
    sd = 2
  )
) + 100

consumption <- income * 0.8 +
  cumsum(
    rnorm(
      n,
      mean = 0.2,
      sd = 1.5
    )
  ) +
  20

economic_data <- cbind(
  income,
  consumption
)

economic_data


# --------------------------------------------------
# 2. Convert to a time-series object
# --------------------------------------------------

economic_ts <- ts(
  economic_data,
  start = c(2015, 1),
  frequency = 12
)

economic_ts


# --------------------------------------------------
# 3. Visualise the variables
# --------------------------------------------------

plot(
  economic_ts,
  main = "Multivariate Economic Time Series",
  xlab = "Year",
  ylab = "Value"
)


# --------------------------------------------------
# 4. Examine correlations
# --------------------------------------------------

cor(
  economic_data
)


# --------------------------------------------------
# 5. Check stationarity
# --------------------------------------------------

# The tseries package provides the ADF test.
#
# Install once if necessary:
# install.packages("tseries")

library(tseries)

adf.test(
  income
)

adf.test(
  consumption
)


# --------------------------------------------------
# 6. Difference the variables
# --------------------------------------------------

income_diff <- diff(
  income
)

consumption_diff <- diff(
  consumption
)

adf.test(
  income_diff
)

adf.test(
  consumption_diff
)


# --------------------------------------------------
# 7. VAR model
# --------------------------------------------------

# VAR models several time series simultaneously.
#
# Each variable is modelled as a function of:
#
# - Its own lagged values
# - Lagged values of the other variables

# Install once if necessary:
# install.packages("vars")

library(vars)

var_data <- cbind(
  income,
  consumption
)

var_model <- VAR(
  var_data,
  p = 2,
  type = "const"
)

summary(
  var_model
)


# --------------------------------------------------
# 8. VAR coefficients
# --------------------------------------------------

coef(
  var_model
)


# --------------------------------------------------
# 9. VAR model diagnostics
# --------------------------------------------------

# Serial correlation test

serial.test(
  var_model,
  lags.pt = 12,
  type = "PT.asymptotic"
)


# Heteroscedasticity test

arch.test(
  var_model,
  lags.multi = 5
)


# Normality test

normality.test(
  var_model
)


# --------------------------------------------------
# 10. Stability of the VAR model
# --------------------------------------------------

# A stable VAR should have roots inside
# the unit circle.

roots(
  var_model
)

plot(
  roots(var_model),
  main = "Roots of VAR Model"
)


# --------------------------------------------------
# 11. Granger causality
# --------------------------------------------------

# Granger causality examines whether past values
# of one variable provide useful information for
# predicting another variable.
#
# It does NOT establish true causal mechanisms.

causality(
  var_model,
  cause = "income"
)


causality(
  var_model,
  cause = "consumption"
)


# --------------------------------------------------
# 12. Impulse Response Function
# --------------------------------------------------

# An impulse response function examines how a shock
# to one variable is associated with future responses
# in the system.

irf_income <- irf(
  var_model,
  impulse = "income",
  response = "consumption",
  n.ahead = 12,
  boot = TRUE
)

plot(
  irf_income
)


# --------------------------------------------------
# 13. Forecast Error Variance Decomposition
# --------------------------------------------------

# FEVD examines the contribution of shocks to each
# variable to the forecast error variance.

fevd_result <- fevd(
  var_model,
  n.ahead = 12
)

fevd_result


plot(
  fevd_result
)


# --------------------------------------------------
# 14. VAR forecasting
# --------------------------------------------------

var_forecast <- predict(
  var_model,
  n.ahead = 12
)

var_forecast


plot(
  var_forecast
)


# --------------------------------------------------
# 15. Cointegration
# --------------------------------------------------

# Two or more non-stationary time series may have
# a stable long-run relationship.
#
# This is known as cointegration.
#
# Cointegration is important because simply
# differencing all variables may remove useful
# long-run information.


# --------------------------------------------------
# 16. Johansen cointegration test
# --------------------------------------------------

# The urca package provides Johansen tests.
#
# Install once if necessary:
# install.packages("urca")

library(urca)

johansen_test <- ca.jo(
  var_data,
  type = "trace",
  ecdet = "const",
  K = 2
)

summary(
  johansen_test
)


# --------------------------------------------------
# 17. VECM concept
# --------------------------------------------------

# VECM is appropriate when:
#
# - Variables are non-stationary
# - Variables are integrated of the same order
# - Variables are cointegrated
#
# VECM separates:
#
# Short-run dynamics
# +
# Long-run equilibrium adjustment


# --------------------------------------------------
# 18. VECM using ca.jo()
# --------------------------------------------------

# The Johansen object can be converted into
# a VECM representation.
#
# The exact conversion depends on the selected
# cointegration rank.

vecm_model <- cajorls(
  johansen_test,
  r = 1
)

vecm_model


# --------------------------------------------------
# 19. Error correction term
# --------------------------------------------------

# The error correction term represents the deviation
# from the long-run equilibrium relationship.
#
# The adjustment coefficients indicate how variables
# respond when the system moves away from equilibrium.


# --------------------------------------------------
# 20. VAR vs VECM
# --------------------------------------------------

# VAR:
#
# Usually applied to stationary variables,
# or variables transformed to achieve stationarity.
#
#
# VECM:
#
# Used when non-stationary variables are cointegrated.
#
#
# Conceptually:
#
# VAR
# ↓
# Short-run dynamic relationships
#
# VECM
# ↓
# Short-run dynamics
# +
# Long-run equilibrium


# --------------------------------------------------
# 21. Granger causality interpretation
# --------------------------------------------------

# If the Granger causality test is significant:
#
# Past values of the candidate cause variable
# provide predictive information about the
# target variable, conditional on the model.
#
# This should not automatically be interpreted
# as structural or true causation.


# --------------------------------------------------
# 22. Impulse response interpretation
# --------------------------------------------------

# An impulse response function can be used to examine
# the dynamic response of one variable following
# a shock to another variable.
#
# Interpretation should consider:
#
# - Sign of the response
# - Magnitude
# - Duration
# - Confidence intervals
# - Variable ordering / identification assumptions


# --------------------------------------------------
# 23. Important modelling considerations
# --------------------------------------------------

# VAR/VECM analysis requires careful attention to:
#
# - Stationarity
# - Lag length
# - Cointegration
# - Deterministic terms
# - Model stability
# - Residual diagnostics
# - Structural interpretation
# - Sample size


# --------------------------------------------------
# 24. Recommended workflow
# --------------------------------------------------

# Multivariate time-series workflow:
#
# Data
#   ↓
# Visualise variables
#   ↓
# Test stationarity
#   ↓
# Determine integration order
#   ↓
# Select lag length
#   ↓
# Test cointegration
#   ↓
# ┌──────────────────────┐
# │ No cointegration     │
# │ → VAR on stationary  │
# │   transformations    │
# └──────────────────────┘
#
# ┌──────────────────────┐
# │ Cointegration        │
# │ → VECM                │
# └──────────────────────┘
#
#   ↓
# Diagnostics
#   ↓
# Granger causality / IRF / FEVD
#   ↓
# Forecasting / interpretation


# --------------------------------------------------
# 25. Statistical interpretation
# --------------------------------------------------

# VAR and VECM are useful when several time series
# interact dynamically.
#
# VAR focuses on dynamic relationships among
# stationary variables.
#
# VECM incorporates both:
#
# - Short-run dynamics
# - Long-run equilibrium relationships
#
# The appropriate model depends on the integration
# and cointegration properties of the data.


# Key idea:
#
# VAR:
# Multiple time series
#       ↓
# Dynamic interactions
#
# VECM:
# Non-stationary + cointegrated variables
#       ↓
# Short-run dynamics
# +
# Long-run equilibrium
#
# Always establish stationarity and cointegration
# properties before selecting VAR or VECM.
