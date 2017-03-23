# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# load requied libraries

library(data.table)
library(plyr)

# download and unzip file 


Url_FUCI <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url_FUCI, dest="FUCI_dataset.zip", mode="wb") 
unzip ("FUCI_dataset.zip")

# List the files in the zipfile and load the names of the columns of the X_train and X_test file

list.files("UCI HAR Dataset", recursive=TRUE)

features <- read.csv('UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])

features

# Load the training datasets, merge the training files and name columns

data_train_X <- read.table('UCI HAR Dataset/train/X_train.txt')
data_train_activity <- read.csv('UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
data_train_subject <- read.csv('UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')

data_train <- cbind(data_train_subject, data_train_activity, data_train_X)
names(data_train) <- c(c('subject', 'activity'), features)

head(data_train)

# Load the test datasets, merge the test files and name columns

data_test_X <- read.table('UCI HAR Dataset/test/X_test.txt')
data_test_activity <- read.csv('UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
data_test_subject <- read.csv('UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

data_test <-  cbind(data_test_subject, data_test_activity, data_test_X)
names(data_test) <- c(c('subject', 'activity'), features)

head(data_test)

# (1) Merge the training and the test sets to create one data set

data_total_UCI <-  rbind(data_train, data_test)

col.select <- grep('subject|activity|mean|std', features)

# (2) Extracts only the measurements on the mean and standard deviation for each measurement.

col.select <- grep('mean|std', features)
col.select
data_total_UCI_sub <- data_total_UCI[,c(1,2,col.select + 2)]
head(data_total_UCI_sub)

# (3) Uses descriptive activity names to name the activities in the data set

activity_labels <- read.table('UCI HAR Dataset/activity_labels.txt')
names(activity_labels) <- c('activity', 'activity_labels')

head(activity_labels)

data_total_UCI_sub <- merge(data_total_UCI_sub, activity_labels,
                            by='activity',
                            all.x=TRUE)

# (4) Appropriately labels the data set with descriptive variable names.

## Check the names
names(data_total_UCI_sub)

## Cleanup the variable names by replacing characters

names(data_total_UCI_sub)<-gsub("-", "", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub("std()", "sd", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub("mean()", "mean", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub("^t", "time ", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub("^f", "freq", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub("Freq", "freq", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub("Acc", "accelerometer", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub("Gyro", "gyroscope", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub("Mag", " magnitude", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub("BodyBody", "body ", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub("Body", "body", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub("Gravity", "gravity ", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub("Jerk", " jerk ", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub("activity_labels", "activitynames", names(data_total_UCI_sub))
names(data_total_UCI_sub)<-gsub(" ", "", names(data_total_UCI_sub))



## Check the final names
names(data_total_UCI_sub)
str(data_total_UCI_sub)

# (5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
## for each activity and each subject

tidy_data_set <- aggregate(data_total_UCI_sub[,3:81], 
                           by = list(activity = data_total_UCI_sub$activity, subject = data_total_UCI_sub$subject),
                           FUN = mean)

## Uses descriptive activity names to name the activities in the data set

tidy_data_set <- merge(tidy_data_set, activity_labels,
                       by='activity',
                       all.x=TRUE)

## Rename Activity_labels into Activity names

names(tidy_data_set)<-gsub("activitylabels", "activitynames", names(tidy_data_set))

## Output the independent tidy data set with the average of each variable for each activity and each subject

write.table(x = tidy_data_set, file = "tidy_data_set.txt", row.names = FALSE)
   
