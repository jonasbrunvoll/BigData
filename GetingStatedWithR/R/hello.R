# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

theFile = "/Users/jonaslarsson/Documents/NTNU/3.year/BigData/exercises/GetingStatedWithR/csv/us-500.csv"
table <- read.table(file=theFile, header=TRUE, sep=",")
theFile2 = "/Users/jonaslarsson/Documents/NTNU/3.year/BigData/exercises/GetingStatedWithR/csv/ssb-sq-prices.csv"
table2 <- read.table(file=theFile2, header=TRUE, sep=";", dec=",")
head(table2, 2)

##ggplot(table, aes(state)) + geom_bar()

