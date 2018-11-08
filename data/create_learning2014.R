

# IODS excercise II: Data wrangling, Suvi Virtanen

# read the data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# look at the dimensions of the data
dim(lrn14)

# We have 60 variables and 183 observations

# look at the structure of the data
str(lrn14)

# Most of the variables appear to be integer number Variables, except for gender, which is a factor variable

# Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions in the learning2014 data

# Access the dplyr library
library(dplyr)

# Creating questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# Selecting the columns related to deep learning and creating column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# Selecting the columns related to surface learning and creating column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# Selecting the columns related to strategic learning and creating column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# Scaling the attitude variable back to the original scale by dividing each number in the column vector
lrn14$attitude <- lrn14$Attitude / 10

# Choosing a columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# Selecting the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# See the stucture of the new dataset
str(learning2014)

# Exclude observations where the exam points variable is zero. 
learning2014 <- filter(learning2014, Points > 0)

# set wd
setwd("~/yhis-kouluhommat/IODS-project/data")

# save data
write.csv(learning2014, file = "learning2014.csv")

#read csv file
test <- read.csv("learning2014.csv", header = T)
head(test)


