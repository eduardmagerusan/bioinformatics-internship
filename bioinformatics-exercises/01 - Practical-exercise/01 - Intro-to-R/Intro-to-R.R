# Intro to R Lesson
# Feb 16th, 2016

# Interacting with R

# I am adding 3 and 5. R is fun!
3+5

x <- 3
y <- 5

number <- x + y

x <- 5
y <- 10

number <- x + y

# Create a numeric vector and store the vector as a variable called 'glengths'
glengths <- c(4.6, 3000, 50000)


# Create a character vector and store the vector as a variable called 'species'
species <- c("ecoli", "human", "corn")
species

combined <- c(glengths, species)

# Create a character vector and store the vector as a variable called 'expression'
expression <- c("low", "high", "medium", "high", "low", "medium", "high")

# Turn 'expression' vector into a factor
expression <- factor(expression)


# Create a data frame and store it as a variable called 'df'
df <- data.frame(species, glengths)


titles <- c("Catch-22", "Pride and Prejudice", "Nineteen Eighty Four")
pages <- c(453, 432, 328)

df2 <- data.frame(titles, pages)


list1 <- list(species, df, number)

square_it <- function(x) {
  square <- x * x
  return(square)
}

multiply_it <- function(x, y) {
  multiplied <- x * y
  return(multiplied)
}

metadata <- read.csv(file="data/mouse_exp_design.txt")

proj_summary <- read.table(file="data/project-summary.txt", header = TRUE, stringsAsFactors = FALSE)




