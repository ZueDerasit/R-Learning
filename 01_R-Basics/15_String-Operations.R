# R Basics: String Operations
Strings mean text values in R. This is useful when working with names, labels, categories, survey responses, and text data.

# Create a character string
name <- "Maria Zhang"

# Get the number of characters
nchar(name)

# Convert text to uppercase
toupper(name)

# Convert text to lowercase
tolower(name)

# Combine strings
first_name <- "Maria"
last_name <- "Zhang"

paste(first_name, last_name)

# Combine strings without a space
paste0(first_name, last_name)

# Extract part of a string
substr(name, 1, 3)

# Replace part of a string
gsub("Maria", "Dr Maria", name)
