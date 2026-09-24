# R Basics: Matrices

# Create a matrix
scores <- matrix(
  c(80, 85, 90,
    75, 88, 92),
  nrow = 2,
  byrow = TRUE
)

# Display the matrix
scores

# Get the number of rows
nrow(scores)

# Get the number of columns
ncol(scores)

# Access an element
scores[1, 2]

# Select the first row
scores[1, ]

# Select the second column
scores[, 2]

###############################################################
The matrix looks like:
     [,1] [,2] [,3]
[1,]  80   85   90
[2,]  75   88   92

Matrix vs Data Frame
| Matrix                             | Data Frame                       |
| ---------------------------------- | -------------------------------- |
| Rows and columns                   | Rows and columns                 |
| Usually one data type              | Can contain different data types |
| Useful for mathematical operations | Commonly used for datasets       |
| `matrix()`                         | `data.frame()`                   |
