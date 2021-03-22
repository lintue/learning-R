# Find factorial of non-negative integer

# import: source("splitter.R")
# use: factorial(n) where n is a non-negative integer

factorial <- function(n) {
  n <- as.integer(n)
  if (n < 0) {
    print("The factorial of a negative integer is undefined")
  } else if (n == 0) {
    print("The factorial of 0 is 1")
  } else {
    factorial <- 1
    for (i in seq(1, n)) {
      factorial <- factorial * i
    }
    print(paste("The factorial of", n, "is", factorial))
  }
}
