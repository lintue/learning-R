### R syntax cheatsheet

*Disclaimer: the list is expanded as I discover new things; and as with programming in general, there are many ways of achieving something. This is just a general outline of useful stuff.*

1. Data structures
2. Numbers
3. General syntax
4. Numerical summaries
5. Plotting
6. Modelling data
7. Probability distributions
8. Useful functions

**1. DATA STRUCTURES**

Data frame

`data.frame(a, b, ...)`

Vector

`vector()  # empty` or `c(a, b, ...)  # specific values` or `c(a:b)  # integer sequence`

Matrix

`matrix(data, nrow = y, ncol = x)`

List

`list(a, b, ...)`

Read clipboard data (MacOS)

`read.table(pipe("pbpaste"), sep = "\t", header = F)`

Read line from terminal

`readline(prompt = "Enter something: ")`

Replace decimal commas with dots

`scan(text = x, dec = ",", sep = ".")` or `as.numeric(sub(",", ".", sub(".", "", var, fixed = TRUE), fixed = TRUE))`

Display structure

`str(data)`

... or length

`length(data)`

Transpose

`t(data)`

Convert data structure

`as.vector(data)` /matrix, etc.

Rename table column

`names(data)[index] <- name`

Add row

`rbind(data, c(a, b, ...))`

... or column

`cbind(data, c(a, b, ...))`

Append to specific location

`append(data, c(a, b, ...), i)  # where i is the position before append`

Concatenate vectors to character strings

`paste(x, y, ..., sep = " ", collapse = NULL)`

Return n number of first or last values

`head(data, n)` or `tail(data, n)`

Note on indexing

Starts from 1 as opposed to 0;\
`variable[row, column]` (e.g. list first ten rows of matrix `data[1:10, ]` or first ten columns `data[ , 1:10]`)

**2. NUMBERS**

Sequence

`seq(min, max, increment)`

Random numbers (uniform distribution)

`runif(n, min, max)  # where n is the quantity of values to be generated`

Rounding

`round(value, dp)`

**3. GENERAL SYNTAX**

Define variable

`x <- vector()  # or x <- a; y <- b; z <- c for a series of expressions`

Loops
```
for (i in seq(min, max)) {
  do something
}
```
```
while (condition) {
  do something
}
```
```
repeat {
  do something
  if (condition) {
    break
  }
}
```

Conditionals
```
if (condition) {
  do a
} else if (condition) {
  do b
} else {
  do c
}
```

Functions
```
function(arguments) {
  return(something)
}
```

(Note that curly brackets are not needed for single-expression functions.)

*Manipulate function body*

`body(f) <- as.call(c(as.name("{"), e))  # where f is an arbitrary function`

*Manipulate function arguments*

`formals(f) <- alist(a = , b = , ...)  # where f is an arbitrary function; a and b new arguments`

Operators

[Listed here](https://www.tutorialspoint.com/r/r_operators.htm)

Errors

*to do: message warning, stop*

**4. NUMERICAL SUMMARIES**

Summary

`summary(data)`

**Measures of location**

Mean

`mean(data)`

Weighted mean

`weighted.mean(data, weights)  # where the two input variables are arbitrary vectors`

(Note that if data contains NAs include argument `na.rm = TRUE`.)

Median

`median(data)`

Mode
```
mode <- function(x) {
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

mode(data)
```

Extreme upper

`max(data)`

Extreme lower

`min(data)`

**Measures of spread**

Range

`range(data)`

IQR

`IQR(data)`

Variance

`var(data)`

Standard deviation

`sqrt(var(data))`

**5. PLOTTING**

Saving images of plots (in current directory)
```
png("filename.png")
x()  # where x() is an arbitrary function for producing graphical representations
dev.off()
```

Stemplot

`stem(data, scale = 1)`

Simple bar chart

`barplot(data, xlab = "", ylab = "", main = "", names.arg = c(), col = "")`

Side-by-side bar chart

... add argument `beside = TRUE`;\
modify width of bars with `width = 0-1`;\
and input data may be a table or individual vectors.

Add legend
```
legend("position", title = "", legend = sort(unique(data$groups)), fill = c(), box.lty = 1, box.lwd = 1, box.col = "")
# where position is defined as coordinates x, y, or right, left, etc.;
# data$groups represents a discrete random variable that describes each group;
# lty refers to type, lwd to width, and col colour.
```

Frequency histogram

`hist(data, xlim = c(), right = FALSE, breaks = c(), main = "", xlab = "", col = "")`

(Note that `right = FALSE` transforms bins from right-closed left-open (a, b] to left-closed right-open [a, b), e.g., will include 5 in bin 5-10 instead of 0-5.)

Unit-area histogram

... add argument `freq = FALSE`

Boxplot

`boxplot(vector, data_frame, horizontal = TRUE, main = "",  col = "")`

(Note that `horizontal = TRUE` results in horizontal boxplot.)

Comparative boxplot
```
boxplot(values ~ groups, data,
  xlab = "",
  ylab = "",
  ylim = c(),
  main = "",
  names = c(),
  horizontal = TRUE,
  notch = FALSE,  # confidence interval around median
  varwidth = TRUE,  # box width (/height in horizontal) proportionate to sample size
  col = c()
)
```

Scatterplot (to fit a line see below)
```
plot(x, y,
  xlab = "",
  ylab = "",
  xlim = c(),
  ylim = c(),
  main = ""
)
```

**6. MODELLING DATA**

Linear regression
```
model <- lm(dependent variable ~ independent variable, data = data.frame)

plot(dependent variable ~ independent variable, data = data.frame)

abline(model)
```

**7. PROBABILITY DISTRIBUTIONS**

*to do*

d - for density - density/mass function\
p - for probability - cumulative distribution function\
q - for quantile - inverse c.d.f.\
r - for random - sampling function

Distributions:

Binomial - binom\
Geometric - geom\
Poisson - pois\
Uniform - unif\
Normal - norm

**8. USEFUL FUNCTIONS**

Split dataset into categorised list
```
data <- data.frame(X, Y)  # where X represents arbitrary categorical variables
                          # and Y their corresponding values

splitter <- function(id, value) {
  list <- list()
  for (i in unique(id)) list[[i]] <- vector()
  for (i in seq(1, length(id))) {
    category <- id[i]
    list[[category]] <- append(list[[category]], value[i])
  }
  return(list)  # returns a list of variables
}

splitter(data$X, data$Y)
```

Loop through numerical data

*Within given range (return vector of conditional values)*
```
looper <- function(min, max) {
  x <- vector()
  for (i in min:max) {
    if (condition) {
      x <- append(x, i)
    }
  }
  return(x)
}

looper(min, max)
```

*Return a specified number of items (input initial value and number of items to be returned)*
```
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

looper(value, items)
```

Integration

*Integrate over arbitrary interval*
```
f <- function(x) (expression)

I <- function(min, max) {  # range [min, max]
  integrate(f, lower = min, upper = max)  # where lower and upper are the limits of integration
}

I(min, max)
```

*Probabilities of continuous random variable X by integration*
```
g <- function(x) (expression)  # integrand: arbirary expression
                               # e.g. (1 / sqrt(2 * pi) * exp(-(1 / 2) * x^2))

P <- function(g, g_L, g_U, lim_min, lim_max, scale_y = FALSE) {
  if (g(g_L) < 0 || g(g_U) < 0) {  # ensure non-negativity given domain [g_L, g_U]
    stop("The image set of g contains negative values... not a valid pdf.")
  } else {
    K <- integrate(g, lower = g_L, upper = g_U)  # integrate g over domain
    norm <- 1 / K$value  # normalising constant
  }
  if (lim_min <= g_L) lim_min <- g_L  ######
  else if (lim_max >= g_U) lim_max <- g_U  # following (g_L ≤ X ≤ g_U)
  I <- integrate(g, lower = lim_min, upper = lim_max)  # integrate g over range [lim_min, lim_max]
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
      "The PDF of X; ",
      "P(", lim_min, " ≤ X ≤ ", lim_max, ")", " = ", round(f, 3)
    ), collapse=""))
}

# Function P plots the p.d.f. of X and calculates P(lim_min ≤ X ≤ lim_max) where
# g is the integrand (a normalising constant will be applied if needed);
# g_L and g_U define the domain of g; and
# lim_min and lim_max are the limits of integration (for probabilities).

P(g, g_L, g_U, lim_min, lim_max)
```

(Note that you may scale the y-axis by including `scale_y = TRUE`; defaults to `FALSE`.)
