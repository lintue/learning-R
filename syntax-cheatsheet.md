### R syntax cheatsheet

*Disclaimer: this is just a general outline of things I've found useful.*

1. Data structures
2. Numbers
3. Strings
4. General
5. Numerical summaries
6. Plotting
7. Modelling data
8. Probability distributions
9. Useful functions

**1. DATA STRUCTURES**

Data frame

`data.frame(a, b, ...)`

Vector

`vector()  # empty` or `c(a, b, ...)  # specific values` or `c(a:b)  # integer sequence`

Matrix

`matrix(data, nrow = y, ncol = x)`

List

`list(a, b, ...)`

Display structure

`str(data)`

... or length

`length(data)`

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

Transpose

`t(data)`

Cumulative sum

`cumsum(data)`

**3. STRINGS**

Concatenate vectors to character strings

`paste(x, y, ..., sep = " ", collapse = NULL)`

Convert characters from lower to uppercase and vice versa
```
toupper(data)
tolower(data)
casefold(x, upper = TRUE/FALSE)  # alternative method
chartr(old = "example", new = "eXaMpLe", data)  # specify new character pattern
```

Convert string to expression

`parse(text = data)`

**4. GENERAL**

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

Return n number of first or last values

`head(data, n)` or `tail(data, n)`

Look for object

`exists("variable")`

Check for duplicates in data
```
duplicated(data)

# Returns a vector of Boolean values.
# If input is a vector, compares consecutive values;
# and if input is a matrix, compares consecutive row vectors.
```

Remove duplicates

```unique(data)```

Read clipboard data (MacOS)

`read.table(pipe("pbpaste"), sep = "\t", header = F)`

Read line from terminal

`readline(prompt = "Enter something: ")  # disable quoting in strings by including quote = ""`

Substitute values (e.g., decimal commas to dots)

`scan(text = x, dec = ",", sep = ".")` or `as.numeric(sub(",", ".", sub(".", "", var, fixed = TRUE), fixed = TRUE))`

Check if argument value was specified to a function
```
missing(data)

e.g.,

a <- function(x, y) {
  if (missing(y)) {
    do something
  }
}
```

**5. NUMERICAL SUMMARIES**

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

**6. PLOTTING**

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

**7. MODELLING DATA**

Linear regression
```
model <- lm(dependent variable ~ independent variable, data = data.frame)

plot(dependent variable ~ independent variable, data = data.frame)

abline(model)
```

Normal probability plot
```
qqnorm(data)
qqline(data)
```

**8. PROBABILITY DISTRIBUTIONS**

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

**9. USEFUL FUNCTIONS**

*There are some useful functions in scripts/*

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

Find factorial of non-negative integer
```
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

# Use: factorial(n)
# Output: "The factorial of n is x."
```
