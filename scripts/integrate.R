# Integrate over arbitrary interval

# import: source("integrate.R")
# use: I()
# user is prompted to enter integrand
# followed by the range [min, max]

f <- function(x) (expression)

I <- function(min, max) {
  body(f) <- parse(text = readline(prompt = "Integrand (dx, e.g., x^3): "))
  min <- as.numeric(readline(prompt = "Endpoint (lower): "))
  max <- as.numeric(readline(prompt = "Endpoint (upper): "))
  integrate(f, lower = min, upper = max)
}
