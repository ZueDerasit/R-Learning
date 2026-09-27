# Data Quality Checks
# This script demonstrates basic checks for identifying
# potential data quality issues before statistical analysis.


# --------------------------------------------------
# 1. Check variable names
# --------------------------------------------------

names(data_csv)


# --------------------------------------------------
# 2. Check the data types of all variables
# --------------------------------------------------

sapply(data_csv, class)


# --------------------------------------------------
# 3. Check the number of missing values
# --------------------------------------------------

colSums(is.na(data_csv))


# --------------------------------------------------
# 4. Check the percentage of missing values
# --------------------------------------------------

missing_percentage <- colMeans(is.na(data_csv)) * 100

missing_percentage


# --------------------------------------------------
# 5. Check for duplicated observations
# --------------------------------------------------

sum(duplicated(data_csv))


# --------------------------------------------------
# 6. Check unique values in categorical variables
# --------------------------------------------------

# Example:
# unique(data_csv$gender)

# Replace 'gender' with the name of a categorical variable
# in your own dataset.


# --------------------------------------------------
# 7. Check the number of unique values
# --------------------------------------------------

sapply(data_csv, function(x) length(unique(x)))


# --------------------------------------------------
# 8. Check numerical variables
# --------------------------------------------------

summary(data_csv)


# --------------------------------------------------
# 9. Check for potential impossible values
# --------------------------------------------------

# Example:
# If age should be between 18 and 100:

# sum(data_csv$age < 18 | data_csv$age > 100, na.rm = TRUE)


# --------------------------------------------------
# 10. Check the range of a numerical variable
# --------------------------------------------------

# Example:

# min(data_csv$age, na.rm = TRUE)
# max(data_csv$age, na.rm = TRUE)


# --------------------------------------------------
# 11. Check for unexpected categories
# --------------------------------------------------

# Example:
# table(data_csv$gender, useNA = "ifany")


# --------------------------------------------------
# 12. Identify potential issues
# --------------------------------------------------

# Common data quality issues include:
#
# - Missing values
# - Duplicate observations
# - Incorrect data types
# - Unexpected categories
# - Impossible values
# - Inconsistent coding
# - Extreme or unusual observations


# --------------------------------------------------
# Key principle
# --------------------------------------------------

# Data should be checked and understood
# before statistical analysis is performed.
