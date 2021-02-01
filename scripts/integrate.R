# Two useful functions involving integration

# import: source("integrate.R")

# 1. Integrate over arbitrary interval

# use: I()
# user is prompted to enter integrand
# followed by the range [min, max]

f <- function(x) (expression)

I <- function(min, max) {
  body(f) <- parse(text = readline(prompt = "Integrand [dx, e.g., x^3]: "))
  min <- as.numeric(readline(prompt = "Endpoint [lower]: "))
  max <- as.numeric(readline(prompt = "Endpoint [upper]: "))
  integrate(f, lower = min, upper = max)
}

# 2. Probabilities of continuous random variable X by integration

# plots the p.d.f. of X and calculates P(lim_min ≤ X ≤ lim_max)

# use: P()
# user is prompted to enter integrand g (a normalising constant will be applied)
# followed by its domain [g_L, g_U] and
# the limits of integration [lim_min, lim_max] (for probabilities)

# OR

# define g <- function(x) (expression) and
# use: P(g, g_L, g_U, lim_min, lim_max)
# where g is the integrand; g_L, g_U, lim_min and lim_max as described above

P <- function(g, g_L, g_U, lim_min, lim_max) {
  if (missing(g) || exists("g") == FALSE) {
    g <- function(x) (expression)  # integrand: arbirary expression
                                   # e.g. (1 / sqrt(2 * pi) * exp(-(1 / 2) * x^2))
    body(g) <- parse(text = readline(prompt = "Integrand [dx, e.g., 1/sqrt(2*pi)*exp(-(1/2)*x^2)]: "))
  } else if (is.expression(body(g)) == FALSE && is.language(body(g)) == FALSE) {
    stop("Define integrand g <- function(x) (expression).")
  }
  if (missing(g_L) || missing(g_U) || missing(lim_min) || missing(lim_max)) {
    g_L <- as.numeric(readline(prompt = "Domain endpoint [lower]: "))
    g_U <- as.numeric(readline(prompt = "Domain endpoint [upper]: "))
    lim_min <- as.numeric(readline(prompt = "Integral endpoint [lower]: "))
    lim_max <- as.numeric(readline(prompt = "Integral endpoint [upper]: "))
  }
  scale_y <- as.logical(toupper(readline(prompt = "Scale y-axis? [t/f]: ")))
  if (min(g(seq(g_L, g_U, 0.01))) < 0) {  # ensure non-negativity given domain [g_L, g_U]
    error <- "The image set of g contains negative values: not a valid p.d.f."
    plot.function(g, xlim = c(g_L, g_U), ylim = c(0, max(g(seq(g_L, g_U, 0.01)))), xlab = "x", ylab = "g(x)")
    title(error)
    stop(error)
  } else {
    K <- integrate(g, lower = g_L, upper = g_U)  # integrate g over domain
    norm <- 1 / K$value  # normalising constant
  }
  # Store original endpoints for graph label.
  lim_min_o <- lim_min
  lim_max_o <- lim_max
  # Restrict endpoints.
  if (lim_min <= g_L) lim_min <- g_L  ######
  else if (lim_max >= g_U) lim_max <- g_U  # following (g_L ≤ X ≤ g_U)
  # Integrate g over range [lim_min, lim_max].
  I <- integrate(g, lower = lim_min, upper = lim_max)
  f <- eval(substitute(a * b, list(a = norm, b = I$value)))  # apply normalising constant to get p.d.f.
  if (lim_max <= g_L || lim_min > g_U) f <- 0  # (P = 0) if out of range
  scaled <- function(x) norm * g(x)  # scale g for plotting
  peak <- max(scaled(seq(g_L, g_U, 0.01)))  # find peak for scaling y-axis
  if (scale_y == FALSE) scale_y <- c(0, 1) else scale_y <- c(0, peak)
  plot.function(scaled, xlim = c(g_L, g_U), ylim = scale_y, xlab = "x", ylab = "f(x)")
  if (f > 0) {
    vert_x <- c(lim_min, seq(lim_min, lim_max, 0.01), lim_max)
    vert_y <- c(0, scaled(seq(lim_min, lim_max, 0.01)), 0)
    polygon(vert_x, vert_y, col = 'lavender')
  }
  title(main = paste(c
    (
      "The PDF of X -- ",
      "P(", lim_min_o, " ≤ X ≤ ", lim_max_o, ")", " = ", round(f, 3)
    ), collapse=""))
}

# 3. Probabilities associated with nonstandard normal distributions by integration

# standardise X (= Z)
# plot the p.d.f. of Z and calculate P(lim_min ≤ X ≤ lim_max)

# use: Z()
# user is prompted to enter mean and variance of normally distributed random variable X
# followed by the limits of integration [lim_min, lim_max] (for probabilities)

# OR

# Z(E(X), V(X), lim_min, lim_max)
# where X is the nonstandard normal random variable;
# and lim_min and lim_max as described above

Z <- function(mean, variance, lim_min, lim_max) {
  # If mean or SD not given, prompt user.
  if (missing(mean) || missing(variance)) {
    # TO DO: fractions as inputs.
    mean <- as.numeric(readline(prompt = "Mean of X: "))
    sd <- sqrt(as.numeric(readline(prompt = "Variance of X: ")))
  } else {
    sd <- sqrt(variance)
  }
  # Standardise X.
  z <- function(x) (1/sqrt(2*pi) * exp(-(1/2) * ((x-mean)/sd)^2))
  # Calculate μ-4*sd and μ+4*sd for x-axis.
  z_L <- (mean - (4*sd))
  z_U <- (mean + (4*sd))
  # Limits of integration.
  if (missing(lim_min) || missing(lim_max)) {
    lim_min <- as.numeric(readline(prompt = "Integral endpoint [lower]: "))
    lim_max <- as.numeric(readline(prompt = "Integral endpoint [upper]: "))
  }
  # Store original endpoints for graph label.
  lim_min_o <- lim_min
  lim_max_o <- lim_max
  # Restrict endpoints.
  if (lim_min <= z_L) lim_min <- z_L  ######
  else if (lim_max >= z_U) lim_max <- z_U  # following (g_L ≤ X ≤ g_U).
  # Find normalising constant.
  K <- integrate(z, lower = z_L, upper = z_U)  # integrate z over domain [z_L, z_U].
  norm <- 1 / K$value  # normalising constant.
  # Integrate z over [lim_min, lim_max].
  I <- integrate(z, lower = lim_min, upper = lim_max)
  # Compute probability by applying normalising constant.
  f <- eval(substitute(a * b, list(a = norm, b = I$value)))
  if (lim_max <= z_L || lim_min > z_U) f <- 0  # (P = 0) if out of range.
  # Plot.
  plot.function(z, xlim = c(z_L, z_U), ylim = c(0, 0.42), xlab = "z", ylab = "f(z)")
  if (f > 0) {
    vert_x <- c(lim_min, seq(lim_min, lim_max, 0.01), lim_max)
    vert_y <- c(0, z(seq(lim_min, lim_max, 0.01)), 0)
    polygon(vert_x, vert_y, col = 'lavender')
  }
  title(main = paste(c
    (
      "The PDF of X (standardised) -- ",
      "P(", lim_min_o, " ≤ X ≤ ", lim_max_o, ")", " = ", round(f, 3)
    ), collapse=""))
}
