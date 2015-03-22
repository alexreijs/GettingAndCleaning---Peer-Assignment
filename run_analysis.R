run_analysis <- function() {
    
    # The goal here is to combine to the different data files and to turn them into tidy data
    # We will achieve this by reading, merging, filtering and complementing the data
    # After acquiring a complete data frame, it will become easy to reshape it as we please
    
    # Load the training data into variables
    trainX <- read.table("./UCI HAR Dataset/train/X_train.txt")
    trainY <- read.table("./UCI HAR Dataset/train/y_train.txt")
    trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    
    # Load the test data into variables
    testX <- read.table("./UCI HAR Dataset/test/X_test.txt")
    testY <- read.table("./UCI HAR Dataset/test/y_test.txt")
    testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    
    # Task 1
    # Merge training data with test data
    mergedX <- rbind(trainX, testX)
    mergedY <- rbind(trainY, testY)
    mergedSubject <- rbind(trainSubject, testSubject)
    
    # Load features into a variable and assign to column names of merged data
    features <- read.table("./UCI HAR Dataset/features.txt")
    colnames(mergedX) <- features[, 2]
    
    # Look for columns containing "mean()" or "std()" using regular expressions
    meanStdCols <- grepl("mean[(][)]", colnames(mergedX)) | grepl("std[(][)]", colnames(mergedX))
    
    # Task 2
    # Get the data for the columns we are interested in
    meanStd <- mergedX[ , meanStdCols]
    
    # Load activity labels into variable
    activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
    
    # Use plyr::mapvalues function to replace activity factor with according activity label
    mappedLabels <- plyr::mapvalues(factor(mergedY[, 1]), from = as.character(activityLabels[, 1]), to = as.character(activityLabels[, 2]))
    
    # Task 3 (& 4?)
    # Add mapped labels and subject to meanStd as new columns
    meanStd <- cbind(mappedLabels, meanStd)
    meanStd <- cbind(mergedSubject, meanStd)
    
    # Rename column names for good measures
    colnames(meanStd)[1] <- "Subject"
    colnames(meanStd)[2] <- "Activity"
    
    # Task 5
    # Melt down and cast the meanStd data frame by using Subject and Activity as variables
    meltedMeanStd <- reshape2::melt(meanStd, id.vars = c("Subject","Activity"))
    tidyMeanStd <- reshape2::dcast(meltedMeanStd, Subject + Activity ~ ..., mean)
    
    return(tidyMeanStd)
}