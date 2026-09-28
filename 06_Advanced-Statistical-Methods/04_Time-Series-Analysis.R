# Time Series Analysis
# This script introduces fundamental concepts in
# time series analysis using R.
#
# Time series data consist of observations recorded
# sequentially over time.


# --------------------------------------------------
# 1. Create a monthly time series
# --------------------------------------------------

monthly_rainfall <- c(
  120, 135, 150, 170, 160, 145,
  130, 125, 140, 155, 180, 165,
  125, 140, 155, 175, 165, 150,
  135, 130, 145, 160, 185, 170,
  130, 145, 160, 180, 170, 155,
  140, 135, 150, 165, 190, 175
)

rainfall_ts <- ts(
  monthly_rainfall,
  start = c(2024, 1),
  frequency = 12
)

rainfall_ts


# --------------------------------------------------
# 2. Inspect the time series
# --------------------------------------------------

start(rainfall_ts)

end(rainfall_ts)

frequency(rainfall_ts)

length(rainfall_ts)

time(rainfall_ts)


# --------------------------------------------------
# 3. Plot the time series
# --------------------------------------------------

plot(
  rainfall_ts,
  main = "Monthly Rainfall",
  xlab = "Year",
  ylab = "Rainfall"
)


# --------------------------------------------------
# 4. Identify components of a time series
# --------------------------------------------------

# A time series may contain:
#
# Trend
# → Long-term movement
#
# Seasonality
# → Repeating pattern at regular intervals
#
# Cyclical behaviour
# → Longer-term fluctuations
#
# Irregular component
# → Random or unexplained variation


# --------------------------------------------------
# 5. Decompose the time series
# --------------------------------------------------

rainfall_decomposition <- decompose(
  rainfall_ts
)

rainfall_decomposition


# Plot decomposition

plot(
  rainfall_decomposition
)


# --------------------------------------------------
# 6. Trend component
# --------------------------------------------------

trend_component <- rainfall_decomposition$trend

trend_component


# Plot trend

plot(
  trend_component,
  main = "Trend Component",
  xlab = "Year",
  ylab = "Trend"
)


# --------------------------------------------------
# 7. Seasonal component
# --------------------------------------------------

seasonal_component <- rainfall_decomposition$seasonal

seasonal_component


plot(
  seasonal_component,
  main = "Seasonal Component",
  xlab = "Year",
  ylab = "Seasonal Effect"
)


# --------------------------------------------------
# 8. Remainder component
# --------------------------------------------------

remainder_component <- rainfall_decomposition$random

remainder_component


plot(
  remainder_component,
  main = "Irregular Component",
  xlab = "Year",
  ylab = "Remainder"
)


# --------------------------------------------------
# 9. Moving average
# --------------------------------------------------

# A moving average smooths short-term fluctuations
# to help reveal the underlying pattern.

# Install once if necessary:
# install.packages("zoo")

library(zoo)

moving_average <- rollmean(
  rainfall_ts,
  k = 3,
  fill = NA,
  align = "center"
)

moving_average


# Plot original series and moving average

plot(
  rainfall_ts,
  main = "Rainfall with Moving Average",
  xlab = "Year",
  ylab = "Rainfall"
)

lines(
  moving_average,
  lty = 2
)


# --------------------------------------------------
# 10. Autocorrelation
# --------------------------------------------------

# Time series observations may not be independent.
#
# Autocorrelation measures the correlation between
# observations and their lagged values.

acf(
  rainfall_ts,
  main = "Autocorrelation Function"
)


# --------------------------------------------------
# 11. Partial autocorrelation
# --------------------------------------------------

pacf(
  rainfall_ts,
  main = "Partial Autocorrelation Function"
)


# --------------------------------------------------
# 12. Lagged observations
# --------------------------------------------------

# Lag 1:
# Compare each observation with the previous
# observation.

lag_1 <- lag(
  rainfall_ts,
  -1
)

lag_1


# --------------------------------------------------
# 13. First differences
# --------------------------------------------------

# Differencing can be used to remove trend
# and help achieve stationarity.

rainfall_diff <- diff(
  rainfall_ts
)

rainfall_diff


plot(
  rainfall_diff,
  main = "First-Differenced Rainfall",
  xlab = "Year",
  ylab = "Differenced Rainfall"
)


# --------------------------------------------------
# 14. Autocorrelation after differencing
# --------------------------------------------------

acf(
  rainfall_diff,
  main = "ACF of Differenced Series"
)

pacf(
  rainfall_diff,
  main = "PACF of Differenced Series"
)


# --------------------------------------------------
# 15. Stationarity
# --------------------------------------------------

# A stationary time series has statistical properties
# that are relatively stable over time.
#
# Important characteristics include:
#
# - Constant mean
# - Constant variance
# - Stable autocovariance structure
#
# Trend and seasonality can cause non-stationarity.


# --------------------------------------------------
# 16. Augmented Dickey-Fuller test
# --------------------------------------------------

# The tseries package provides the adf.test() function.
#
# Install once if necessary:
# install.packages("tseries")

library(tseries)

adf.test(
  rainfall_ts
)

adf.test(
  rainfall_diff
)


# --------------------------------------------------
# 17. KPSS test
# --------------------------------------------------

# The null hypothesis of the KPSS test is
# different from the ADF test.
#
# Install once if necessary:
# install.packages("tseries")

kpss.test(
  rainfall_ts
)

kpss.test(
  rainfall_diff
)


# --------------------------------------------------
# 18. ADF vs KPSS
# --------------------------------------------------

# ADF:
#
# H0 → Unit root / non-stationarity
# H1 → Stationarity
#
#
# KPSS:
#
# H0 → Stationarity
# H1 → Non-stationarity
#
# Because the null hypotheses differ, using both
# tests can provide complementary evidence.


# --------------------------------------------------
# 19. White noise
# --------------------------------------------------

# A white noise series contains random observations
# with no systematic temporal structure.
#
# Ideally:
#
# - Mean approximately constant
# - Variance approximately constant
# - No meaningful autocorrelation


# --------------------------------------------------
# 20. Ljung-Box test
# --------------------------------------------------

# The Ljung-Box test can be used to assess whether
# a group of autocorrelations is jointly different
# from zero.

Box.test(
  rainfall_ts,
  lag = 12,
  type = "Ljung-Box"
)


# --------------------------------------------------
# 21. Seasonal analysis
# --------------------------------------------------

# Monthly seasonal pattern

monthplot(
  rainfall_ts,
  main = "Monthly Seasonal Pattern"
)


# --------------------------------------------------
# 22. Seasonal differencing
# --------------------------------------------------

# For monthly data, lag = 12 represents
# one seasonal cycle.

seasonal_diff <- diff(
  rainfall_ts,
  lag = 12
)

seasonal_diff


# Plot seasonally differenced data

plot(
  seasonal_diff,
  main = "Seasonally Differenced Rainfall",
  xlab = "Year",
  ylab = "Difference"
)


# --------------------------------------------------
# 23. Time series forecasting
# --------------------------------------------------

# Forecasting methods will be covered in more detail
# in the ARIMA section.
#
# Basic workflow:
#
# Historical data
#       ↓
# Understand trend and seasonality
#       ↓
# Check stationarity
#       ↓
# Identify temporal dependence
#       ↓
# Fit forecasting model
#       ↓
# Validate model
#       ↓
# Generate forecasts


# --------------------------------------------------
# 24. Important considerations
# --------------------------------------------------

# Time series analysis differs from ordinary
# cross-sectional analysis because observations
# are ordered in time.
#
# Therefore, we must consider:
#
# - Trend
# - Seasonality
# - Autocorrelation
# - Stationarity
# - Structural changes
# - Time-dependent errors
#
# Randomly shuffling time series observations
# can destroy important temporal information.


# --------------------------------------------------
# 25. Statistical interpretation
# --------------------------------------------------

# Time series analysis can be used to:
#
# - Identify trends
# - Detect seasonal patterns
# - Measure temporal dependence
# - Assess stationarity
# - Transform non-stationary data
# - Prepare data for forecasting
#
# Important:
# A strong correlation between observations at
# different times indicates temporal dependence,
# not necessarily a causal relationship.


# Key idea:
#
# Time series data
#       ↓
# Ordered observations
#       ↓
# Trend + Seasonality + Dependence + Noise
#       ↓
# Statistical modelling
#       ↓
# Forecasting / inference
#
# The temporal order of observations is fundamental
# to time series analysis.
