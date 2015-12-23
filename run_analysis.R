# Library loaden
require(tidyr)
require(dplyr)
require(magrittr)

# Loading of feature names 
features <- read.table("./UCI HAR Dataset/features.txt") 

# Loading of activity names
activity <- read.table("./UCI HAR Dataset/activity_labels.txt") 

# Loading of training and test values
test <- read.table("./UCI HAR Dataset/test/X_test.txt")
train <- read.table("./UCI HAR Dataset/train/X_train.txt")

# Loading of training and test activity names
testAct <- read.table("./UCI HAR Dataset/test/y_test.txt")
trainAct <- read.table("./UCI HAR Dataset/train/y_train.txt")

# Loading of training and test subjects
testSubj <- read.table("./UCI HAR Dataset/test/subject_test.txt")
trainSubj <- read.table("./UCI HAR Dataset/train/subject_train.txt")


# Transform variable names of features to valid variable names
features[, 2] <- sub("\\-", "\\_", features[, 2])


# merge training and test set values, activity and subject
datVal <- rbind(test, train)
datAct <- rbind(testAct, trainAct)
datSubj <- rbind(testSubj, trainSubj)

# select column numbers for mean and standard deviation variables, numbers and names
meanNumb <- grep("mean\\(", features[,2], value= F, ignore.case=T)
stdNumb <- grep("std", features[,2], value= F, ignore.case=T)
meanName <- grep("mean\\(", features[,2], value= T, ignore.case=T)
stdName <- grep("std", features[,2], value= T, ignore.case=T)

# merge column numbers for mean and std variables, Numb and Names
featuresNumb <- c(meanNumb, stdNumb)
featuresName <- c(meanName, stdName)

# select mean and std columns from data, replace columns Numb for Names
datVal <- datVal %>% select(featuresNumb)
colnames(datVal) <- featuresName

# Transform activity number to name
Activity <- datAct %>% unlist %>% factor(levels=activity[, 1], labels = activity[, 2])

# merge all value and activity name data
dat <- cbind(datSubj, Activity, datVal)

# Mean of all variables per subject-activity pair
dat_Means <- dat %>% group_by(V1, Activity) %>% summarise_each(funs(mean))

# Change column names
colnames(dat_Means)[1:2] <- c("Subject", "Activity")

# Remove hyphens and brackets from variable names 
colnames(dat_Means) <- sub("-", "_", colnames(dat_Means))
colnames(dat_Means) <- sub("\\(\\)", "", colnames(dat_Means))

# Write datMeans to file dataMeans.txt
write.table(dat_Means, "dataMeans.txt", row.name=F)
