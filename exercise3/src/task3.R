# Need rpart to create descision threes
install.packages("rpart")
library(rpart)

# Makes it possible to create fancier threes.
install.packages("rpart.plot")
library(rpart.plot)

# Read CSV file pakeges
theFile = "~/Documents/NTNU/3.year/BigData/exercises/exercise3/csv/winequality-red.csv"
wineTable <- read.table(file=theFile, header=TRUE, sep=";")

# Creates decision three about 'Car' based on the attributes 'Sex', 'Age' and 'Children'
# 'method = class' means that the three is a classification three

#fixed.acidity + volatile.acidity + citric.acid + residual.sugar + chlorides + free.sulfur.dioxide 
#+ total.sulfur.dioxide  + density + pH + sulphates + alcohol

fit <- rpart(quality ~ total.sulfur.dioxide  + density + pH 
             + sulphates + alcohol, method="class", data = wineTable, control=rpart.control(cp=0.0071))

# plots decision three
prp(fit)

printcp(fit)

 