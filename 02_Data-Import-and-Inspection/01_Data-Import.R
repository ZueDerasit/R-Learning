# Data Import
# This script demonstrates how to import common data formats into R.

# --------------------------------------------------
# 1. Import a CSV file
# --------------------------------------------------

# Read a CSV file into R
# Replace the file path with the location of your own CSV file.

data_csv <- read.csv("data/data.csv")

# Display the imported data
data_csv


# --------------------------------------------------
# 2. Import an Excel file
# --------------------------------------------------

# The readxl package is required to read Excel files.
# Install it once if necessary:
# install.packages("readxl")

library(readxl)

# Read an Excel file
# Replace the file path with the location of your own Excel file.

data_excel <- read_excel("data/data.xlsx")

# Display the imported data
data_excel


# --------------------------------------------------
# 3. Import an RDS file
# --------------------------------------------------

# RDS files store a single R object.

data_rds <- readRDS("data/data.rds")

# Display the imported object
data_rds


# --------------------------------------------------
# 4. Check the imported data
# --------------------------------------------------

# Check the structure
str(data_csv)

# Check the dimensions
dim(data_csv)

# Check the first few rows
head(data_csv)
