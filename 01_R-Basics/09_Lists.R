# R Basics: Lists

# Create a list
student <- list(
  name = "Maria",
  age = 25,
  scores = c(75, 80, 90),
  information = data.frame(
    subject = c("Statistics", "R Programming"),
    mark = c(85, 90)
  )
)

# Display the list
student

# Access an element by name
student$name

# Access the age
student$age

# Access the scores
student$scores

# Access the data frame
student$information

##########################################################################
A list is a data structure that can store different types of objects in one object.

Vector vs List: 
Vector = a box containing similar things. c(10, 20, 30)
List = a box containing different things. list(name = "Maria", age = 25)

