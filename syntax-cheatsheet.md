### R syntax cheatsheet

*Disclaimer: the list is expanded as I discover new things; and as with programming in general, there are many ways of achieving something. This is just a general outline of useful stuff.*

1. Data structures
2. Numbers
3. General syntax
4. Numerical summaries
5. Plotting
6. Modelling data
7. Useful functions

**1. DATA STRUCTURES**

Data frame

`data.frame(a, b, ...)`

Vector

`vector()  # empty` or `c(a, b, ...)  # specific values` or `c(a:b)  # integer sequence`

Matrix

`matrix(data, nrow=y, ncol=x)`

List

`list(a, b, ...)`

Read clipboard data (MacOS)

`read.table(pipe("pbpaste"), sep="\t", header=F)`

Replace decimal commas with dots

`scan(text=x, dec=",", sep=".")` or `as.numeric(sub(",", ".", sub(".", "", var, fixed=TRUE), fixed=TRUE))`

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

`x <- vector()`

Loops (for, while, repeat)
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
if (something) {
  do a
} else if (something) {
  do b
} else {
  do c
}
```

Functions
```
function(input) {
  return(something)
}
```

Operators

[Listed here](https://www.tutorialspoint.com/r/r_operators.htm)

**4. NUMERICAL SUMMARIES**

Summary

`summary(data)`

**Measures of location**

Mean

`mean(data)`

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

`stem(data, scale=1)`

Simple bar chart

`barplot(data, xlab="", ylab="", main="", names.arg=c(), col="")`

Side-by-side bar chart

... add argument `beside=TRUE`;\
modify width of bars with `width=0-1`;\
and input data may be a table or individual vectors.

Add legend
```
legend("position", title="", legend=sort(unique(data$groups)), fill=c(), box.lty=1, box.lwd=1, box.col="")
# where position is defined as coordinates x, y, or right, left, etc.;
# data$groups represents a discrete random variable that describes each group;
# lty refers to type, lwd to width, and col colour.
```

Frequency histogram

`hist(data, xlim=c(), right=FALSE, breaks=c(), main="", xlab="", col="")`

(Note that `right=FALSE` transforms bins from right-closed left-open (a, b] to left-closed right-open [a, b), e.g., will include 5 in bin 5-10 instead of 0-5.)

Unit-area histogram

... add argument `freq=FALSE`

Boxplot

`boxplot(vector, data_frame, horizontal=TRUE, main="",  col="")`

(Note that `horizontal=TRUE` results in horizontal boxplot.)

Comparative boxplot
```
boxplot(values ~ groups, data,
  xlab="",
  ylab="",
  ylim=c(),
  main="",
  names=c(),
  horizontal=TRUE,
  notch=FALSE,  # confidence interval around median
  varwidth=TRUE,  # box width (/height in horizontal) proportionate to sample size
  col=c()
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

**7. USEFUL FUNCTIONS**

Split dataset based on binary categories (return list of two variables)
```
data <- data.frame(x, y)  # where x is a vector of group IDs and y is a vector of values

splitter <- function(id, value) {
  list <- list(a=vector(), b=vector())
  for (i in seq(1, length(id))) {
    if (id[i] == 0) {
      list$a <- append(list$a, value[i])
    } else {
      list$b <- append(list$b, value[i])
    }
  }
  return(list)
}

splitter(data$x, data$y)
```

Loop through numerical values

*Within a given range (return vector of values which meet condition)*
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

*Return a specific number of items (input initial value and number of items to be returned)*
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
