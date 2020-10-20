#Install ggplot2
install.packages("ggplot2")
library(ggplot2)
library(readr)
dishes <- read_delim("csv/dishes.csv", ";", escape_double = FALSE, trim_ws = TRUE)

# Group by dishes and find each dish avrage score. 
aggregatedList <- aggregate(Score ~ Dish, dishes, mean)

# Print out resalt
print(aggregatedList)

# Create diagram with avrage score along the x-axis and dish name along the y - axis
ggplot(aggregatedList, aes(x=Score, y=Dish)) + geom_point()




