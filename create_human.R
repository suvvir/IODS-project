# Suvi Virtanen, Open Data Science course exercise 4 - data wrangling

# access the libraries
library(dplyr)
library(ggplot2)
library(stringr)

# read and explore data

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
str(hd)
summary(hd)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
str(gii)
summary(gii)


# Edit column names

colnames(hd)
names(hd) <- c("HDI_rank", "country","HDI_raw","life_expct","educ_expct","mean_educ","GNI_raw","GNI_rank")
colnames(hd)

colnames(gii)
names(gii) <- c("GII_rank", "country","GII_raw","MMR","ABR","parliament","female_educ","male_educ","female_work","male_work")
colnames(gii)



# define a new column ratio of Female and Male populations with secondary education

gii <- mutate(gii, FMR_work = female_work/male_work)
gii <- mutate(gii, FMR_educ = female_educ/male_educ)


#create new data
human <- inner_join(gii, hd, by = "country")

# save data
write.csv(human, file = "human.csv")


###############################################################

  
# Week 5 Data Wrangling
# Original data: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt

# read data
human <- read.csv("human.csv")
dim(human)
str(human)

# The dataset contains 195 observations and 19 variables. 
# The data combines several indicators of economic/equality development from most countries in the world

# Abbrevations for the key variables:

# Health and knowledge

#"GNI_raw" = Gross National Income per capita
#"GNI_rank" = Gross National Income per capita ranking
#"HDI_raw" = Human development index score
#"HDI_rank" = Ranking on human development index
#"life_excpct" = Life expectancy at birth
#"educ_excpct" = Expected years of schooling 
#"MMR" = Maternal mortality ratio
#"ABR" = Adolescent birth rate

# Empowerment

#"Parliament" = Percetange of female representatives in parliament
#"female_educ" = Proportion of females with at least secondary education
#"male_eudc" = Proportion of males with at least secondary education
#"female_work" = Proportion of females in the labour force
#"male_work" " Proportion of males in the labour force

#"FMR_educ" = female_educ / male_educ
#"FMR_work" = female_work / male_work



# look at the structure of the GNI column in 'human'
str(human$GNI_raw)

# remove the commas from GNI and print out a numeric version of it
GNI <- str_replace(human$GNI_raw, pattern=",", replace ="") %>%  as.numeric

#Add to the data
human <- cbind(human,GNI)

# columns to keep
keep <- c("country", "FMR_educ", "FMR_work", "life_expct", "educ_expct", "GNI", "MMR", "ABR", "parliament")


# select the 'keep' columns
human <- dplyr::select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))

# look at the last 20 observations of human
tail(human$country, n=10)

#look like the last 7 obs are areas instead of states

# define the last indice we want to keep
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human_ <- human_[1:last, ]

# add countries as rownames
rownames(human_) <- human_$country


# remove the Country variable
human_ <- select(human, -country)

# glimpse at the new data
glimpse(human_)


# save data
write.csv(human_, file = "human.csv")
