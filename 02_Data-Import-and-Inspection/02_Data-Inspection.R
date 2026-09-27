# Data Inspection
# This script demonstrates basic techniques for inspecting a dataset in R.

# --------------------------------------------------
# 1. View the first few observations
# --------------------------------------------------

head(data_csv)

# View the first 10 observations
head(data_csv, 10)


# --------------------------------------------------
# 2. View the last few observations
# --------------------------------------------------

tail(data_csv)

# View the last 10 observations
tail(data_csv, 10)


# --------------------------------------------------
# 3. Check the structure of the dataset
# --------------------------------------------------

str(data_csv)


# --------------------------------------------------
# 4. Check the dimensions of the dataset
# --------------------------------------------------

# Number of rows
nrow(data_csv)

# Number of columns
ncol(data_csv)

# Number of rows and columns
dim(data_csv)


# --------------------------------------------------
# 5. Check variable names
# --------------------------------------------------

names(data_csv)


# --------------------------------------------------
# 6. Check the class of the dataset
# --------------------------------------------------

class(data_csv)


# --------------------------------------------------
# 7. Obtain a statistical summary
# --------------------------------------------------

summary(data_csv)


# --------------------------------------------------
# 8. Check the data types of all variables
# --------------------------------------------------

sapply(data_csv, class)


# --------------------------------------------------
# 9. Check the number of missing values
# --------------------------------------------------

sum(is.na(data_csv))


# --------------------------------------------------
# 10. Check missing values by variable
# --------------------------------------------------

colSums(is.na(data_csv))


# --------------------------------------------------
# 11. Check for duplicated observations
# --------------------------------------------------

sum(duplicated(data_csv))


# --------------------------------------------------
# 12. View duplicated observations
# --------------------------------------------------

data_csv[duplicated(data_csv), ]
