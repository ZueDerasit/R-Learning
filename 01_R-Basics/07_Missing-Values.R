# R Basics: Missing Values

# Create a vector with a missing value
scores <- c(80, 75, NA, 90, 85)

# Display the vector
scores

# Check for missing values
is.na(scores)

# Count the number of missing values
sum(is.na(scores))

# Calculate the mean
mean(scores)

# Calculate the mean while ignoring missing values
mean(scores, na.rm = TRUE)
