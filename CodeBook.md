# CodeBook Peer-Graded Assignment Getting and Cleaning Data

## Data Set Information:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.    
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
Check the README.txt file for further details about this dataset. 

### Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Getting and Cleaning Data

The script run_analysis.R imports the train data from '/train/X_train.txt', '/train/y_train.txt', and '/train/subject_train.txt' into data_train_X, data_train_activity, and data_train_subject respectively. 
It imports the test data from '/test/X_test.txt', '/test/y_test.txt', and '/test/subject_test.txt' into data_test_X, data_test_activity, and data_test_subject respectively. 
The activity labels are imported from '/activity_labels.txt' into activity_labels, and the names of the measurements are imported from '/features.txt' into features.Also the columns activity and subject are named.

The training data sets data_train_X, data_train_activity, and data_train_subject are merged and the columns are renamed with the labels from features. The new training data set is data_train.
Also the test data sets data_test_X, data_test_activity, and data_test_subject are merged and the columns are renamed with the labels from features. The new data set is data_train.       

### The Transformations:

The Transformations

The script run_analysis.R does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#### 1. Merges the training and the test sets to create one data set

The data sets data_train and data_test are merged with the rbind() command. The result is the dataset data_total_UCI.

2. Extracts only the measurements on the mean and standard deviation for each measurement

A vector col.select is created that uses grep() to find the columns that have features with "mean()" or "std()" in the name. These columns are isolated in a new data frame called data_total_UCI_sub.

3. Uses descriptive activity names to name the activities in the data set

A new column activity_labels is added to the data frame data_total_UCI_sub with the labels for the variable activity. 
Activity: 1 WALKING, 
2 WALKING_UPSTAIRS,
 3 WALKING_DOWNSTAIRS, 
4 SITTING, 
5 STANDING, 
6 LAYING
. 

4. Appropriately labels the data set with descriptive variable names

The variable names are cleaned up by replacing characters.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

The data data_total_UCI_sub is aggregated by activity and subject. The aggregated data matrix is tidy_data_set. Descriptive activity names to name the activities are added to this data set.
This data frame is output to 'tidy_data_set.txt'.

