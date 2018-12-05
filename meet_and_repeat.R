
# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)
library(data.table)

# read and explore data

BPRS <- fread('https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt', header = T)
str(BPRS)
summary(BPRS)

RATS <- fread('https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt')
RATS$V1 <- NULL
colnames(RATS) <- c("ID","Group","WD1","WD8","WD15","WD22","WD29","WD36","WD43","WD44","WD50","WD57","WD64")
str(RATS)
glimpse(RATS)


# Wide structure = In the wide format, a subject's/rats repeated measurements will be in a single row, and each response is in a separate column.

# Factor treatment & subject in BPRS
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Factor group & id in RATS
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert BPRS to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)

# Convert RATS data to long form
RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4))) 

# Glimpse the data
glimpse(RATSL)


# In the long format, each row is one time point per subject. So each subject will have data in multiple rows. Any variables that don't change across time will have the same value in all the rows.


write.csv(RATSL, file = "ratsl.csv")
write.csv(BPRSL, file = "bprsl.csv")