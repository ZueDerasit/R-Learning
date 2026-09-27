# R Basics: User-Defined Functions
A user-defined function is a function that you create yourself to perform a specific task.

# Syntax
function_name <- function(argument) {
  instructions
}

# Create a simple function
greet <- function(name) {
  paste("Hello", name)
}

# Use the function
greet("Maria")
greet("Noah")


# Create a function to calculate the square
square <- function(x) {
  x^2
}

# Use the function
square(5)
square(10)


# Create a function to calculate the mean
calculate_mean <- function(x) {
  mean(x)
}

# Use the function
scores <- c(70, 80, 90, 85)

calculate_mean(scores)
