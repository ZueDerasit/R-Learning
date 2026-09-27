# R Basics: Control Flow
Control flow determines the order in which R executes commands.

# -------------------------
# For loop
# -------------------------

for (i in 1:5) {
  print(i)
}

# Loop through a vector

scores <- c(70, 80, 90, 85)

for (score in scores) {
  print(score)
}

# -------------------------
# While loop
# -------------------------

i <- 1

while (i <= 5) {
  print(i)
  i <- i + 1
}

######################################################
i is just a variable name
