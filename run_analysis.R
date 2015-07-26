library(plyr)
library(dplyr)

#Attaining Data
folder <- "./UCI HAR Dataset"
zipFile<- "SaumsungData.zip"

if (!file.exists(zipFile)){
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = zipFile)
}

if (!dir.exists(folder)){
    unzip(zipFile)
}

#Reading Data
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE)
columnNames <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
colnames(subjectTrain) <- "Subject"
colnames(subjectTest) <- "Subject"
activityTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
activityTest<- read.table("./UCI HAR Dataset/test/y_test.txt")
colnames(activityTrain) <- "Activity"
colnames(activityTest) <- "Activity"

dataTrainBef <- read.table("./UCI HAR Dataset/train/X_train.txt")
dataTestBef <- read.table("./UCI HAR Dataset/test/X_test.txt")

#setting column names to data
colnames(dataTrainBef) <- columnNames[,2]
colnames(dataTestBef) <- columnNames[,2]

#bind subject, activity and data columns together
dataTrain <- cbind(subjectTrain, activityTrain, dataTrainBef)
dataTest <- cbind(subjectTest, activityTest, dataTestBef)

#bind Test and Train data together
dataFinal <- rbind(dataTrain, dataTest)
dataFinal <- dataFinal[,unique(colnames(dataFinal))]

#Subset Data
resultsFinal <- select(dataFinal,contains("Subject"), contains("Activity"), contains("mean"), contains("std"), -contains("meanFreq"))

#Replacing Activity Names
for (i in 1:length(activityLabels$V1)){
resultsFinal[resultsFinal$Activity == activityLabels$V1[i],2] <- activityLabels$V2[i]
}

#Replacing Column Names
colnames(resultsFinal) <- gsub("^t", "time ", colnames(resultsFinal))
colnames(resultsFinal) <- gsub("^f", "fourier transform of ", colnames(resultsFinal))
colnames(resultsFinal) <- gsub("[Bb]ody", "body ", colnames(resultsFinal))
colnames(resultsFinal) <- gsub("Acc", "accelorator ", colnames(resultsFinal))
colnames(resultsFinal) <- gsub("Gyro", "gyro ", colnames(resultsFinal))
colnames(resultsFinal) <- gsub("\\-", "", colnames(resultsFinal))
colnames(resultsFinal) <- gsub("[Mm]ean", "mean ", colnames(resultsFinal))
colnames(resultsFinal) <- gsub("X$", "x axis", colnames(resultsFinal))
colnames(resultsFinal) <- gsub("Y$", "y axis", colnames(resultsFinal))
colnames(resultsFinal) <- gsub("Z$", "z axis", colnames(resultsFinal))
colnames(resultsFinal) <- gsub("\\(\\)", "", colnames(resultsFinal))
colnames(resultsFinal) <- gsub("[Ss]td", "std ", colnames(resultsFinal))
colnames(resultsFinal) <- gsub("Jerk", "jerk ", colnames(resultsFinal))
colnames(resultsFinal) <- gsub("Mag", "mag ", colnames(resultsFinal))

#getting mean of data using dplyr, writing in into a table
tab <- resultsFinal %>%
    group_by(Subject, Activity) %>%
    summarise_each(funs(mean))

#write the data table into a .txt file
write.table(tab, file = "TidyDataPart5.txt", row.names = FALSE)