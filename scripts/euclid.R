# Find HCF of two integers using Euclid's algorithm.

# import: source("euclid.R")
# use: hcf(a, b) where a and b are integers

hcf <- function(a, b) {
  if (a %% 1 != 0 || b %% 1 != 0) {
    stop("Only input integers!")  # check that inputs are integers.
  }
  a <- abs(a); b <- abs(b)  # use absolute values.
  if (a == 0 && b == 0) {
    stop("Undefined!")  # undefined if both inputs zero.
  } else if (a == 0 || b == 0 && a != b) {
    return (max(a, b))  # return the non-zero input if one input zero.
  }
  # If min(a, b) is a factor of max(a, b), HCF = min(a, b).
  if (max(a, b) %% min(a, b) == 0) {
    return (min(a, b))
  }
  # If none of the conditions above apply, use Euclid's algo.
  if (a < b) {
    a <- a + b; b <- a - b; a <- a - b  # ensure a > b.
  }
  remainders <- c()
  repeat {
    factor <- (a - a %% b) / a %/% b  # (a - modulus) / quotient.
    b <- a %% b ##
    a <- factor  # update values.
    remainders <- append(remainders, b)  # store remainder.
    if (b == 0) {
      return (tail(remainders, 2)[1])  # return the remainder before 0.
    }
  }
}
