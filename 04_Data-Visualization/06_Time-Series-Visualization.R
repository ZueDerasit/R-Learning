# Data Visualization: Time Series
# This script demonstrates basic techniques for
# visualising time-dependent data.


# --------------------------------------------------
# 1. Load required packages
# --------------------------------------------------

library(ggplot2)
library(dplyr)


# --------------------------------------------------
# 2. Create sample time series data
# --------------------------------------------------

monthly_data <- data.frame(
  month = 1:12,
  rainfall = c(
    120, 135, 150, 180, 210, 190,
    160, 145, 170, 200, 230, 250
  ),
  temperature = c(
    27.1, 27.3, 27.8, 28.0, 28.4, 28.2,
    28.0, 27.9, 27.7, 27.5, 27.2, 27.0
  )
)

monthly_data


# --------------------------------------------------
# 3. Basic line plot
# --------------------------------------------------

ggplot(
  monthly_data,
  aes(
    x = month,
    y = rainfall
  )
) +
  geom_line() +
  geom_point() +
  labs(
    title = "Monthly Rainfall",
    x = "Month",
    y = "Rainfall"
  )


# --------------------------------------------------
# 4. Visualise temperature over time
# --------------------------------------------------

ggplot(
  monthly_data,
  aes(
    x = month,
    y = temperature
  )
) +
  geom_line() +
  geom_point() +
  labs(
    title = "Monthly Temperature",
    x = "Month",
    y = "Temperature"
  )


# --------------------------------------------------
# 5. Multiple time series
# --------------------------------------------------

# Convert the data to long format

monthly_long <- monthly_data %>%
  tidyr::pivot_longer(
    cols = c(rainfall, temperature),
    names_to = "variable",
    values_to = "value"
  )

monthly_long


# --------------------------------------------------
# 6. Plot multiple variables
# --------------------------------------------------

ggplot(
  monthly_long,
  aes(
    x = month,
    y = value,
    colour = variable
  )
) +
  geom_line() +
  geom_point() +
  labs(
    title = "Monthly Rainfall and Temperature",
    x = "Month",
    y = "Value",
    colour = "Variable"
  )


# --------------------------------------------------
# 7. Add a linear trend
# --------------------------------------------------

ggplot(
  monthly_data,
  aes(
    x = month,
    y = rainfall
  )
) +
  geom_line() +
  geom_point() +
  geom_smooth(
    method = "lm",
    se = FALSE
  ) +
  labs(
    title = "Rainfall Trend",
    x = "Month",
    y = "Rainfall"
  )


# --------------------------------------------------
# 8. Calculate a moving average
# --------------------------------------------------

# install.packages("zoo")

library(zoo)

monthly_data <- monthly_data %>%
  mutate(
    rainfall_ma3 = rollmean(
      rainfall,
      k = 3,
      fill = NA,
      align = "right"
    )
  )

monthly_data


# --------------------------------------------------
# 9. Plot rainfall with moving average
# --------------------------------------------------

ggplot(
  monthly_data,
  aes(x = month)
) +
  geom_line(
    aes(y = rainfall),
    linewidth = 1
  ) +
  geom_line(
    aes(y = rainfall_ma3),
    linewidth = 1
  ) +
  labs(
    title = "Rainfall and 3-Month Moving Average",
    x = "Month",
    y = "Rainfall"
  )


# --------------------------------------------------
# 10. Identify potential seasonal patterns
# --------------------------------------------------

ggplot(
  monthly_data,
  aes(
    x = month,
    y = rainfall
  )
) +
  geom_line() +
  geom_point() +
  scale_x_continuous(
    breaks = 1:12
  ) +
  labs(
    title = "Monthly Rainfall Pattern",
    x = "Month",
    y = "Rainfall"
  )


# --------------------------------------------------
# Key idea
# --------------------------------------------------

# Time series data have an important characteristic:
# observations are ordered in time.
#
# Line plots are commonly used to visualise:
#
# - Trends
# - Seasonal patterns
# - Changes over time
# - Short-term fluctuations
# - Long-term movements
#
# When analysing time-dependent data,
# the order of observations should be preserved.
