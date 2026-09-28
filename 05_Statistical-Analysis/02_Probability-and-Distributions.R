# Probability and Distributions
# This script introduces basic probability concepts
# and common probability distributions in R.

# --------------------------------------------------
# 1. Basic probability concepts
# --------------------------------------------------

# Suppose a fair die has six possible outcomes:
# 1, 2, 3, 4, 5, 6

outcomes <- 1:6

outcomes

# Probability of obtaining a 4

prob_4 <- 1 / length(outcomes)

prob_4


# --------------------------------------------------
# 2. Probability using counting
# --------------------------------------------------

# Probability of obtaining an even number

even_numbers <- c(2, 4, 6)

prob_even <- length(even_numbers) / length(outcomes)

prob_even


# --------------------------------------------------
# 3. Binomial distribution
# --------------------------------------------------

# Example:
# A student answers 10 multiple-choice questions.
# Each question has a probability of 0.5 of being correct.

# Probability of getting exactly 6 correct answers

dbinom(
  x = 6,
  size = 10,
  prob = 0.5
)

# Probability of getting 6 or fewer correct answers

pbinom(
  q = 6,
  size = 10,
  prob = 0.5
)

# Probability of getting more than 6 correct answers

1 - pbinom(
  q = 6,
  size = 10,
  prob = 0.5
)


# --------------------------------------------------
# 4. Generate random binomial observations
# --------------------------------------------------

set.seed(123)

binomial_data <- rbinom(
  n = 100,
  size = 10,
  prob = 0.5
)

binomial_data


# --------------------------------------------------
# 5. Normal distribution
# --------------------------------------------------

# Mean = 70
# Standard deviation = 10

mean_score <- 70
sd_score <- 10

# Density at score = 80

dnorm(
  x = 80,
  mean = mean_score,
  sd = sd_score
)

# Probability of obtaining a score
# less than or equal to 80

pnorm(
  q = 80,
  mean = mean_score,
  sd = sd_score
)

# Probability of obtaining a score
# greater than 80

1 - pnorm(
  q = 80,
  mean = mean_score,
  sd = sd_score
)

# Probability of obtaining a score
# between 60 and 80

pnorm(
  q = 80,
  mean = mean_score,
  sd = sd_score
) -
  pnorm(
    q = 60,
    mean = mean_score,
    sd = sd_score
  )


# --------------------------------------------------
# 6. Generate random normal observations
# --------------------------------------------------

set.seed(123)

normal_data <- rnorm(
  n = 100,
  mean = 70,
  sd = 10
)

head(normal_data)

mean(normal_data)

sd(normal_data)


# --------------------------------------------------
# 7. Uniform distribution
# --------------------------------------------------

# Generate 100 observations between 0 and 1

set.seed(123)

uniform_data <- runif(
  n = 100,
  min = 0,
  max = 1
)

head(uniform_data)


# --------------------------------------------------
# 8. Poisson distribution
# --------------------------------------------------

# Example:
# Number of customer arrivals per hour.
#
# Assume the average number of arrivals
# is 5 per hour.

# Probability of exactly 3 arrivals

dpois(
  x = 3,
  lambda = 5
)

# Probability of 3 or fewer arrivals

ppois(
  q = 3,
  lambda = 5
)

# Probability of more than 3 arrivals

1 - ppois(
  q = 3,
  lambda = 5
)


# --------------------------------------------------
# 9. Generate Poisson observations
# --------------------------------------------------

set.seed(123)

poisson_data <- rpois(
  n = 100,
  lambda = 5
)

head(poisson_data)


# --------------------------------------------------
# 10. Distribution functions in R
# --------------------------------------------------

# R uses four common prefixes:

# d = density / probability at a point
# p = cumulative probability
# q = quantile
# r = random generation

# Examples:

dnorm(70, mean = 70, sd = 10)

pnorm(70, mean = 70, sd = 10)

qnorm(0.95, mean = 70, sd = 10)

rnorm(
  n = 10,
  mean = 70,
  sd = 10
)


# --------------------------------------------------
# 11. Quantiles
# --------------------------------------------------

# Find the 95th percentile of a standard normal distribution

qnorm(0.95)

# Find the 97.5th percentile

qnorm(0.975)


# --------------------------------------------------
# 12. Simulating a sampling distribution
# --------------------------------------------------

set.seed(123)

sample_means <- replicate(
  1000,
  mean(
    sample(
      normal_data,
      size = 30,
      replace = TRUE
    )
  )
)

head(sample_means)

mean(sample_means)

sd(sample_means)


# --------------------------------------------------
# 13. Visualise a distribution
# --------------------------------------------------

hist(
  normal_data,
  main = "Simulated Normal Data",
  xlab = "Value"
)

hist(
  sample_means,
  main = "Sampling Distribution of the Mean",
  xlab = "Sample Mean"
)


# --------------------------------------------------
# 14. Statistical interpretation
# --------------------------------------------------

# Probability describes uncertainty about outcomes.
#
# Common distributions include:
#
# Binomial
# → Number of successes in a fixed number of trials
#
# Normal
# → Continuous measurements with an approximately
#   symmetric bell-shaped distribution
#
# Uniform
# → Outcomes with equal density across an interval
#
# Poisson
# → Counts of events occurring within a fixed interval
#
# Sampling distributions describe how a statistic,
# such as a sample mean, behaves across repeated samples.
#
# Key idea:
# Understanding probability distributions is important
# because many statistical methods are based on
# assumptions about probability and sampling behaviour.
