#GETTING AND CLEANING DATA PROJECT
#run_analysis.R

library(dplyr);library(reshape2)

if(!file.exists("data")) {
        dir.create("data")
}
# Creating a pointer to the url of the dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

#download the file
download.file(fileUrl, destfile = "./data/getcleandataproject.zip")

#This download is a zip file, so the contents have to unzipped and extracted
unzip(zipfile="./data/getcleandataproject.zip",exdir="./data")

# Reading the text files with read.table
# Files were read in groups of "test" and "train" and "other features"

# Test
xTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
yTest <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
dim(xTest);dim(yTest);dim(subjectTest)

#Train
xTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
dim(yTrain); dim(xTrain); dim(subjectTrain)

# other pertinent info
features <- read.table('./data/UCI HAR Dataset/features.txt')
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')
dim(features); dim(activityLabels)

#The columns have to be labelled
names(xTrain) <- features[,2]
names(xTest) <- features[,2]
# these labels were aobtained by visiting the original readme file of the dataset
names(yTrain) <- "activityNumber"
names(yTest) <- "activityNumber"
names(subjectTest) <- "subjectNumber"
names(subjectTrain) <- "subjectNumber"
names(activityLabels) <- c("activityNumber","activityName")

#Merging all data
mergeTrainData <- cbind(yTrain,subjectTrain,xTrain)
mergeTestData <- cbind(yTest, subjectTest,xTest)
mergedData <- rbind(mergeTrainData, mergeTestData)

#Selecting those columns with mean and standard deviation
#Also maintain the subjectNumber and activityNumber
meanStdData <- mergedData[, grep("activityNumber|subjectNumber|mean|std", names(mergedData))]
freqData <- grepl("meanFreq",names(meanStdData))

#The meanFreq data was dropped as these are frequencies
meanStdDataFinal <- meanStdData[!freqData]

## Adding descriptive names for the dataset
descriptiveData <- merge(meanStdDataFinal,activityLabels, by="activityNumber", all.x = TRUE)
descriptiveData <- descriptiveData[,-1]


#Tidy data
myTidyData <- aggregate(. ~activityName + subjectNumber, descriptiveData, mean)
# Wide format
myTidyDataWide <- myTidyData[order(myTidyData$activityName, myTidyData$subjectNumber), ]
#Long format
myTidyDataLong <- melt(myTidyData, id=c("subjectNumber", "activityName"))
names(myTidyDataLong) <- c("subjectNumber", "activityName", "Feature", "Value")

# Writing a text files
write.table(myTidyDataWide, "tidyDataWide.txt", row.name=FALSE)
write.table(myTidyDataLong, "tidyDataLong.txt", row.names=FALSE)
