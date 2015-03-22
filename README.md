## Readme for GetAndClean

### Origin

This script was created to pass the peer assignment of the Coursera course "Getting and Cleaning Data" (https://www.coursera.org/course/getdata).

It runs a specific analyses as instructed by the course. The goal is to process the data provided by "Human Activity Recognition Using Smartphones Dataset" and extract mean and standard deviation variables as well as provide a tidy dataset of the mean of observations grouped by the Subject and Activity.

### Data set

You can acquire the data set that you will need here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

You can find more information on the origin of the data set and its credits here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Instructions

1. Download the run_analysis.R script
2. Download the data set described above
3. Place the subfolder "./UCI HAR Dataset/" of the data set into the same folder as the run_analysis.R script
4. Load the GetAndClean.R script
5. Execute command "tidyData <- run_analysis()"

### Analysis

We start by loading all the corresponding files for the test and training data and merge them into one data set.
The result is a set of merged data frames:

	mergedX
	./UCI HAR Dataset/train/X_train.txt
	./UCI HAR Dataset/test/X_test.txt

	mergedY
	./UCI HAR Dataset/train/y_train.txt
	./UCI HAR Dataset/test/y_test.txt

	mergedSubject
	./UCI HAR Dataset/train/subject_train.txt
	./UCI HAR Dataset/test/subject_test.txt
 
After adding the features to the column names by loading "./UCI HAR Dataset/features.txt" we extract only the columns containing "mean()" or "std()" in their names.

We continue by loading the activity labels from "./UCI HAR Dataset/activity_labels.txt" and mapping them to our observations.

Then, we add the subjects, acquired from the merged datasets before (mergedSubject) to our observations.

Now that we've got a completed data set, we can use use melt and dcast functions from the reshape2 package, to calculate the mean for each variable while grouping by the Subject and Activity variables.