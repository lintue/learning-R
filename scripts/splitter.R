# Split dataset into categorised list

# import: source("splitter.R")
# use: splitter(data$X, data$Y)

# data <- data.frame(X, Y)
# where X represents arbitrary categorical variables and Y corresponding values

splitter <- function(id, value) {
  list <- list()
  for (i in unique(id)) list[[i]] <- vector()
  for (i in seq(1, length(id))) {
    category <- id[i]
    list[[category]] <- append(list[[category]], value[i])
  }
  return(list)  # returns a list of variables
}
