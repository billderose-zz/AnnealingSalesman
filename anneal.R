Generate.Cities <- function(n) {
  # Generate.Cities returns a vector of n (x,y) coordinates
  # where each ordered pair in the vector represents the location
  # of a city. Cities are generated with x and y coordinates within
  # the unit square.
  cities <- c()
  for (i in 1:n) {
    cities[[i]] <- runif(2)
  }
  return(cities)
}

Distance <- function(x, y) {
  # Distance computes the Euclidean distance between two points
  # x, y.
  return(sqrt((x[1] - y[1]) ^ 2 + (x[2] - y[2]) ^ 2))
}

Path.Length <- function(cities) {
  # Path.Length computes the path length of the path connecting
  # the cities passed in.
  total.distance <- 0
  for (i in 1:(length(cities)-1)) {
    total.distance <- total.distance + Distance(cities[[i]], cities[[i+1]])
  }
  total.distance <- total.distance + Distance(cities[[1]], cities[[length(cities)-1]])  
  return(total.distance)
}

P <- function(new, old, tau) {
  # Metropolis-Hastings ratio
  return(min(1, exp((old - new) /  tau)))
}

Swap <- function(cities) {
  # Perform a random two-swap of the cities
  idx <- sample(1:length(cities), 2)
  temp <- cities[idx[1]]
  cities[idx[1]] <- cities[idx[2]]
  cities[idx[2]] <- temp
  return(cities)
}

Anneal <- function(n) {
  dist <- c()
  tau <- c(10000, 7000, 5000, 2000, 1000, 700, 500, 100, 50, 10, 1, 0.1, 0.01, 0.001, 0.0001)
  
  initial.config <- Generate.Cities(n)
  Plot.Cities(initial.config)
  initial.distance <- Path.Length(initial.config)
  dist[1] <- initial.distance
  for (temp in tau) {
    for (i in 1:floor(100 + 1 / temp)) {
      next.config <- Swap(initial.config)
      next.distance <- Path.Length(next.config)
      if (runif(1) < P(next.distance, initial.distance, temp)) {
        initial.config <- next.config
        initial.distance <- next.distance
        dist <- c(dist, initial.distance)
      }
    }
  }
  plot(dist, t="l", main="Path length vs. time", ylab="Path length")
  Plot.Cities(initial.config)
  return(initial.config)
}

Plot.Cities <- function(cities) {
  x <- c()
  y <- c()
  for (city in cities) {
    x <- c(x, city[1])
    y <- c(y, city[2])
  }
  x <- c(x, cities[[1]][1])
  y <- c(y, cities[[1]][2])
  plot(x,y, t="l", cex=1)
}