# R Basics: Apply Functions
Apply functions allow us to perform the same operation on multiple values without writing the same code repeatedly.
For example, instead of calculating the mean of several columns one by one, we can use an apply function.

# Create a matrix
scores <- matrix(
  c(70, 80, 90,
    75, 85, 95),
  nrow = 2,
  byrow = TRUE
)

# Display the matrix
scores

#Script > 1=row, 2=column
apply(data, margin, function)

# Apply a function to each row (mean of each row)
apply(scores, 1, mean)

# Apply a function to each column (mean of each column)
apply(scores, 2, mean)

# Apply a function to each row
apply(scores, 1, sum)

# Apply a function to each column
apply(scores, 2, sum)
