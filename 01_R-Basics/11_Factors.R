# R Basics: Factors
A factor is an R data structure used to represent categorical data.

# Create a categorical variable
gender <- factor(c("Female", "Male", "Female", "Male", "Female"))

# Display the factor
gender

# Check the data type
class(gender)

# View the categories
levels(gender)

# Count the number of observations in each category
table(gender)
