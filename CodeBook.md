## Code book

### The Variables of the tidy data set (in order):
* subjects
* activities
* tBodyAcc-mean()-X
* tBodyAcc-mean()-Y
* tBodyAcc-mean()-Z
* tBodyAcc-std()-X
* tBodyAcc-std()-Y
* tBodyAcc-std()-Z
* tGravityAcc-mean()-X
* tGravityAcc-mean()-Y
* tGravityAcc-mean()-Z
* tGravityAcc-std()-X
* tGravityAcc-std()-Y
* tGravityAcc-std()-Z
* tBodyAccJerk-mean()-X
* tBodyAccJerk-mean()-Y
* tBodyAccJerk-mean()-Z
* tBodyAccJerk-std()-X
* tBodyAccJerk-std()-Y
* tBodyAccJerk-std()-Z
* tBodyGyro-mean()-X
* tBodyGyro-mean()-Y
* tBodyGyro-mean()-Z
* tBodyGyro-std()-X
* tBodyGyro-std()-Y
* tBodyGyro-std()-Z
* tBodyGyroJerk-mean()-X
* tBodyGyroJerk-mean()-Y
* tBodyGyroJerk-mean()-Z
* tBodyGyroJerk-std()-X
* tBodyGyroJerk-std()-Y
* tBodyGyroJerk-std()-Z
* tBodyAccMag-mean()
* tBodyAccMag-std()
* tGravityAccMag-mean()
* tGravityAccMag-std()
* tBodyAccJerkMag-mean()
* tBodyAccJerkMag-std()
* tBodyGyroMag-mean()
* tBodyGyroMag-std()
* tBodyGyroJerkMag-mean()
* tBodyGyroJerkMag-std()
* fBodyAcc-mean()-X
* fBodyAcc-mean()-Y
* fBodyAcc-mean()-Z
* fBodyAcc-std()-X
* fBodyAcc-std()-Y
* fBodyAcc-std()-Z
* fBodyAccJerk-mean()-X
* fBodyAccJerk-mean()-Y
* fBodyAccJerk-mean()-Z
* fBodyAccJerk-std()-X
* fBodyAccJerk-std()-Y
* fBodyAccJerk-std()-Z
* fBodyGyro-mean()-X
* fBodyGyro-mean()-Y
* fBodyGyro-mean()-Z
* fBodyGyro-std()-X
* fBodyGyro-std()-Y
* fBodyGyro-std()-Z
* fBodyAccMag-mean()
* fBodyAccMag-std()
* fBodyBodyAccJerkMag-mean()
* fBodyBodyAccJerkMag-std()
* fBodyBodyGyroMag-mean()
* fBodyBodyGyroMag-std()
* fBodyBodyGyroJerkMag-mean()
* fBodyBodyGyroJerkMag-std()

### The Rows of the tidy data set:
Each row corresponds to one subject doing one activity.
There are a total of 30 subjects, numbered "1" to "30"
Each subject did 6 different activities:
* Walking
* Walking Up
* Walking Down
* Sitting
* Standing
* Laying

### The steps to clean up the data
It is assumed that the raw data are in the working directory having the same file structure as given initially.
(i.e. the test and train data are in there own folders.)
The data in the "Inertial Signals" folders are ignored.
The R script "run_analysis.R" uses one uncommen package ("reshape2") which ist loaded at the beginning.

A data.frame "subjects" is created by loading and merging the data from the "test" and "train" files.
The merge is done by "rbind". The column is named "subjects".

Then a data.frame "y" is created by loading and merging the data from the "test" and "train" files.
The merge is done by "rbind". The column is named "activities".
The values of the variable "activities" are labeled with descriptive names.

The data.frame "x" is created by loading and merging the data from the "test" and "train" files.
The merge is done by "rbind". The columns are named according to the names provided in the "features.txt" file.

The "x" data.frame is cleaned up by removing all columns that do not contain the mean or standard deviation
of the measurements. The columns to drop from the data.frame are found by not matching any one of two regular expressions
that check if the column name contains "-mean()" or "-std()".

Finally all three data.frames("subjects","y","x") are merged into one data.frame by using cbind.

To make the data set tidy it must have unique row IDs.
That means a single row is one subject doing one of his six activities.
The data set is made tidy by using "melt" and "dcast".
The values of the variables are set to their mean.

The tidy data set is exported to the working directory as a comma separated file.
The file ends on ".txt" to allow for uploading at coursera.