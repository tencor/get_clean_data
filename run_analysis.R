library(data.table)
library(reshape2)
library(plyr)



if (!file.exists("data")) {
        
        print("The data folder doesn't exists. I proceed to create it")
        dir.create("data")
        myurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(myurl, destfile = ".\\data\\data.zip")
        dateDownloaded <- date()
        unzip(zipfile = ".\\data\\data.zip",
              overwrite = TRUE,
              exdir = ".\\data")
        
} else {
        print("Dear friend, our data folder exists.")
}

print("reading tables")


activitylabels <- read.table(".\\data\\UCI HAR Dataset\\activity_labels.txt")
features       <- read.table(".\\data\\UCI HAR Dataset\\features.txt")

subjecttrain   <- read.table(".\\data\\UCI HAR Dataset\\train\\subject_train.txt")
xtrain         <- read.table(".\\data\\UCI HAR Dataset\\train\\X_train.txt")
ytrain         <- read.table(".\\data\\UCI HAR Dataset\\train\\Y_train.txt")

subjecttest   <- read.table(".\\data\\UCI HAR Dataset\\test\\subject_test.txt")
xtest         <- read.table(".\\data\\UCI HAR Dataset\\test\\X_test.txt")
ytest         <- read.table(".\\data\\UCI HAR Dataset\\test\\Y_test.txt")

columns <- as.vector(features$V2)

#naming xfile columns

setnames(xtrain, columns)
setnames(xtest, columns)

#selecting the necessary labels

mylabels <- labels[grepl("mean|std", columns)]

# Concatening ytrain and ytest. I add another column to identify the origin (test and training)
# I associate each id with its description

ytrain$V1 <- activitylabels[ytrain$V1,2]
ytrain$V2 <- "TRAINING"


ytest$V1 <- activitylabels[ytest$V1,2]
ytest$V2 <- "TEST"

ytrain <- cbind(subjecttrain, ytrain)
ytest <- cbind(subjecttest, ytest)

# Union of the y training and testing

yset <- rbind(ytrain, ytest)

names(yset) <- c("Subject","Activity_label", "Origin")


# All training and testing measures

xset <- rbind(xtrain, xtest)

# Selecting the selected labels
myxset <- xset[,mylabels]

myset <-cbind(yset, myxset)

#Generating the aggregatted
myaverages <- aggregate(myset[,mylabels], by= list(Subject = myset$Subject,Activity_label = myset$Activity_label), data=myset, FUN=mean)

write.table(myset, file="non_aggregated_result.txt", row.name=FALSE)
write.table(myaverages, file="aggregated_result.txt", row.name=FALSE)
write.table(dateDownloaded, file="result_date.txt", row.name = FALSE, col.names = FALSE)
