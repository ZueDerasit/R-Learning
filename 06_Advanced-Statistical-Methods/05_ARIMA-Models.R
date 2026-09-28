# ARIMA Models
# This script introduces ARIMA modelling for
# time series analysis and forecasting.
#
# ARIMA stands for:
#
# AR = Autoregressive
# I  = Integrated
# MA = Moving Average


# --------------------------------------------------
# 1. Create a time series
# --------------------------------------------------

monthly_sales <- c(
  120, 125, 128, 135, 140, 145,
  150, 148, 155, 160, 168, 172,
  175, 180, 185, 190, 195, 200,
  205, 210, 215, 220, 225, 230,
  235, 240, 245, 250, 255, 260,
  265, 270, 275, 280, 285, 290
)

sales_ts <- ts(
  monthly_sales,
  start = c(2024, 1),
  frequency = 12
)

sales_ts


# --------------------------------------------------
# 2. Plot the time series
# --------------------------------------------------

plot(
  sales_ts,
  main = "Monthly Sales",
  xlab = "Year",
  ylab = "Sales"
)


# --------------------------------------------------
# 3. Examine autocorrelation
# --------------------------------------------------

acf(
  sales_ts,
  main = "ACF of Sales"
)

pacf(
  sales_ts,
  main = "PACF of Sales"
)


# --------------------------------------------------
# 4. Difference the series
# --------------------------------------------------

# Differencing can be used to remove trend
# and help achieve stationarity.

sales_diff <- diff(
  sales_ts
)

plot(
  sales_diff,
  main = "First-Differenced Sales",
  xlab = "Year",
  ylab = "Differenced Sales"
)


# --------------------------------------------------
# 5. Check stationarity
# --------------------------------------------------

# Install once if necessary:
# install.packages("tseries")

library(tseries)

adf.test(
  sales_ts
)

adf.test(
  sales_diff
)


# --------------------------------------------------
# 6. Fit an ARIMA model manually
# --------------------------------------------------

# ARIMA(p, d, q)
#
# p = autoregressive order
# d = degree of differencing
# q = moving-average order
#
# Example:
# ARIMA(1, 1, 0)

arima_model <- arima(
  sales_ts,
  order = c(1, 1, 0)
)

arima_model


# --------------------------------------------------
# 7. Model summary
# --------------------------------------------------

arima_model$coef

arima_model$sigma2

arima_model$aic

arima_model$aicc

arima_model$bic


# --------------------------------------------------
# 8. Residuals
# --------------------------------------------------

arima_residuals <- residuals(
  arima_model
)

arima_residuals


# Plot residuals

plot(
  arima_residuals,
  main = "ARIMA Residuals",
  xlab = "Time",
  ylab = "Residuals"
)


# --------------------------------------------------
# 9. Residual diagnostics
# --------------------------------------------------

acf(
  arima_residuals,
  main = "ACF of ARIMA Residuals"
)

pacf(
  arima_residuals,
  main = "PACF of ARIMA Residuals"
)


# --------------------------------------------------
# 10. Ljung-Box test
# --------------------------------------------------

# A good forecasting model should leave residuals
# that are approximately uncorrelated.

Box.test(
  arima_residuals,
  lag = 12,
  type = "Ljung-Box"
)


# --------------------------------------------------
# 11. Normal Q-Q plot of residuals
# --------------------------------------------------

qqnorm(
  arima_residuals,
  pch = 19,
  main = "Normal Q-Q Plot of ARIMA Residuals"
)

qqline(
  arima_residuals,
  lty = 2
)


# --------------------------------------------------
# 12. Automatic ARIMA selection
# --------------------------------------------------

# The forecast package provides auto.arima().
#
# Install once if necessary:
# install.packages("forecast")

library(forecast)

auto_model <- auto.arima(
  sales_ts
)

auto_model


# --------------------------------------------------
# 13. Compare manual and automatic models
# --------------------------------------------------

AIC(
  arima_model
)

AIC(
  auto_model
)

BIC(
  arima_model
)

BIC(
  auto_model
)


# Important:
#
# AIC and BIC are model selection criteria.
#
# Lower values generally indicate a better trade-off
# between model fit and model complexity.
#
# They should not be used as the only basis for
# selecting a final forecasting model.


# --------------------------------------------------
# 14. Forecast future observations
# --------------------------------------------------

sales_forecast <- forecast(
  auto_model,
  h = 12
)

sales_forecast


# --------------------------------------------------
# 15. Plot the forecast
# --------------------------------------------------

plot(
  sales_forecast,
  main = "ARIMA Forecast",
  xlab = "Year",
  ylab = "Sales"
)


# --------------------------------------------------
# 16. Forecast values
# --------------------------------------------------

sales_forecast$mean


# Lower prediction limits

sales_forecast$lower


# Upper prediction limits

sales_forecast$upper


# --------------------------------------------------
# 17. Forecast intervals
# --------------------------------------------------

# Forecast intervals represent uncertainty
# surrounding future predictions.
#
# Wider intervals indicate greater uncertainty.


# --------------------------------------------------
# 18. ARIMA model notation
# --------------------------------------------------

# ARIMA(p, d, q)
#
# p:
# Number of autoregressive terms
#
# d:
# Number of differences used to achieve stationarity
#
# q:
# Number of moving-average terms
#
# Example:
#
# ARIMA(1, 1, 1)
#
# means:
#
# 1 AR term
# 1 order of differencing
# 1 MA term


# --------------------------------------------------
# 19. Seasonal ARIMA
# --------------------------------------------------

# Seasonal ARIMA extends ARIMA to include
# seasonal patterns.
#
# SARIMA is written as:
#
# ARIMA(p, d, q)(P, D, Q)[s]
#
# where:
#
# P = seasonal AR order
# D = seasonal differencing order
# Q = seasonal MA order
# s = seasonal period
#
# For monthly data:
#
# s = 12


# --------------------------------------------------
# 20. Forecast evaluation
# --------------------------------------------------

# Forecast accuracy should be evaluated using
# out-of-sample or holdout observations when possible.
#
# Common measures include:
#
# MAE
# → Mean Absolute Error
#
# RMSE
# → Root Mean Squared Error
#
# MAPE
# → Mean Absolute Percentage Error
#
# Model performance should be assessed on data
# that were not used to estimate the model whenever
# the research objective is forecasting.


# --------------------------------------------------
# 21. Forecasting workflow
# --------------------------------------------------

# A practical ARIMA workflow is:
#
# Time series
#      ↓
# Explore trend and seasonality
#      ↓
# Check stationarity
#      ↓
# Difference if necessary
#      ↓
# Examine ACF and PACF
#      ↓
# Identify candidate models
#      ↓
# Fit ARIMA model
#      ↓
# Diagnose residuals
#      ↓
# Compare models
#      ↓
# Validate forecasts
#      ↓
# Generate future forecasts


# --------------------------------------------------
# 22. Important statistical principle
# --------------------------------------------------

# A model with a low AIC is not automatically
# a good forecasting model.
#
# A suitable forecasting model should:
#
# - Represent the temporal structure reasonably
# - Produce approximately uncorrelated residuals
# - Have sensible parameter estimates
# - Perform adequately on validation data
# - Provide useful forecasts for the research objective


# --------------------------------------------------
# 23. Statistical interpretation
# --------------------------------------------------

# ARIMA models are useful for:
#
# - Time series forecasting
# - Modelling temporal dependence
# - Handling non-stationary series through differencing
# - Capturing autoregressive and moving-average behaviour
#
# Forecasts should be reported together with
# appropriate prediction intervals.


# Key idea:
#
# ARIMA
#   ↓
# Model temporal dependence
#   ↓
# Diagnose residuals
#   ↓
# Validate model
#   ↓
# Forecast future observations
#
# Forecasting is not simply about producing future
# values. Model adequacy and forecast uncertainty
# are equally important.
