# Loop through numerical data

# Within given range (return vector of conditional values)
# Use: looper(min, max)

looper <- function(min, max) {
  x <- vector()
  for (i in min:max) {
    if (condition) {
      x <- append(x, i)
    }
  }
  return(x)
}

# Return a specified number of items
# Use: looper(value, items)
# where value = initial value and item = number of items to return

looper <- function(value, items) {
  x <- vector()
  repeat {
    if (length(x) < items) {
      if (condition) {
        x <- append(x, value)
      }
      value <- value + 1  # where 1 is an arbitrary increment
    } else {
      break
    }
  }
  return(x)
}
