# Need rpart to create descision threes
install.packages("rpart")
library(rpart)

# Makes it possible to create fancyer threes.
install.packages("rpart.plot")
library(rpart.plot)

# Read CSV file pakeges
theFile = "~/Documents/NTNU/3.year/BigData/exercises/GetingStatedWithR/csv/cars.csv"
cars <- read.table(file=theFile, header=TRUE, sep=";")

# Creates decision three about 'Car' based on the attributes 'Sex', 'Age' and 'Children'
# 'method = class' means that the three is a classification three
fit <- rpart(Car ~ Sex + Age + Children, method="class", data = cars, control=rpart.control(cp=0.002))

# plots decision three
prp(fit)

# The complexity parameter (cp) is used to control the size of the decision tree and to select the optimal tree size.
# We can find the optimal cp value with either finding the lowest xerror using
printcp(fit)

# or using
plotcp(fit)

# to make the three shallower use
fit <- prune(fit, cp=0.0039439)
prp(fit)


#Create e regression three
# Price = price / 1000 makes the price more displayable.
# 'method = anova' --> regession three.
cars <- transform(cars, Price = Price / 1000)
fit <- rpart(Price ~ Sex + Age + Children, method="anova", data = cars)
prp(fit)

printcp(fit)

# To find the expected prediction error in price we can take:
# sqrt(Root node error) * xerror = MSE (mean squared error)
sqrt(20323) * 0.28641

# output: 40.83025. This means that the error in price prediction is 41 000.
