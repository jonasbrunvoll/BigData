# Widen data (from long list to wide table)
#install.packages("reshape2")
#library(reshape2)
R <- dcast(music_ratings, User ~ Artist)

# Save user names in array for use later
users <- R[,1]

# Remove user column (first column).
R <- R[,-1]

# Find the "distances" between the users. (close == similar)
# We are using "euclidian" distance.
# Experiment with "canberra", "manhattan" etc
d <- dist(R, method = "euclidian")
d <- as.matrix(d)

# We can visualize this distance matrix using MDS (Multidimensional Scaling)
# This visualization will not work if two users have no ratings in common
# but in this test-dataset they all do
fit <- cmdscale(d, eig=TRUE, k=2) # k is the number of dimensions

# Make plot
x <- fit$points[,1]
y <- fit$points[,2]
plot(x, y, xlab="x", ylab="y", main="Users", type="n")
text(x, y, labels = users, cex=.7)

# Create recommendation function
recommendation <- function(me, dist, k){
  # Find distances from me to all neighbors, ordered by distance
  ordered.neighbors <- order(d[me, ])

  # Remove "me" from this vector
  ordered.neighbors <- ordered.neighbors[ordered.neighbors != me];

  # Use only the k nearest neighbors
  nearest.neighbors <- ordered.neighbors[0:k]

  # Replace N/A's with 0 to make dataframes addable
  ratings <- R
  ratings[is.na(ratings)] <- 0

  rec <- matrix(0, ncol = ncol(ratings), nrow = 1)
  for(i in nearest.neighbors) {
    # Find distance from me to this particular neighbor
    dist <- d[me, i]

    # Create a weight for this user based on the distance
    weight <- 1 / (1 + dist)

    # Find recommendations from this particular neighbor (ratings[i,]),
    # multiply by weigh
    # and add to list of recommendations
    rec <- rec + (ratings[i,] * weight)
  }

  # Order recommendations (- means descending, highest recommendation first)
  rec <- rec[order(-rec)]

  return (rec)
}

# Test. me=2 (Frank), d is the distance matrix, k=2)
recommendation(me=2, d, k=2)

