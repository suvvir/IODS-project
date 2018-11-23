# Suvi Virtanen, Open Data Science course exercise 4 - data wrangling

# access the libraries
library(dplyr)
library(ggplot2)

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
