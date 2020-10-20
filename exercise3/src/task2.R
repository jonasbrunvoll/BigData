# Installing reshape
install.packages("reshape2")
library(reshape2)

# Fetch the dishes CSV file.
dishes <- read_delim("csv/dishes.csv", ";", escape_double = FALSE, trim_ws = TRUE)
# Widen data (from long list to wide table)
R <- dcast(dishes, UserName ~ Dish)

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




# Function for finding which guest i should invite
recommendationOfGuests <- function(me, d, users, numberOfGuests){
  
  #Fetch the other users distance from me.
  datalist <- d[me,]
  
  #Order distance rising from me '0.000' to highest. 
  datalist <- datalist[order(datalist)]
  
  #Finding the 'numberOfGuests' users closest to my taste
  datalist <- datalist[2:(1+numberOfGuests)]
  datalist <- as.matrix(datalist)
  
  #Finding their users number
  datalist <- data.frame(as.integer(rownames(datalist)))
  datalist <- datalist[,]
  
  # Transform thir user numbers to user names
  datalist[1:numberOfGuests] <- users[datalist[1:numberOfGuests]]
  
  #Returning list with names to invite
  return (datalist)
}


# Extract data from (jonasbl) me = 15. numberOfGuests = 2
me <- 15
numberOfGuests <- 3
guestList <- recommendationOfGuests(me, d, users, numberOfGuests)
sprintf("The %s guests you should invite are: ",numberOfGuests)
sprintf('%s', guestList)



