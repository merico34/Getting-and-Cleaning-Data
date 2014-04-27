library("reshape2") # load external package that is needed for this script
dir <- getwd()

# Create data.frame "subjects" for the subjects of the train and test files
# by using rbind. Then name the column.
subjects_train <- read.table(paste(dir, "/train/subject_train.txt", sep=""), quote="\"")
subjects_test <- read.table(paste(dir, "/test/subject_test.txt", sep=""), quote="\"")
subjects <- rbind(subjects_train, subjects_test)
colnames(subjects) <- "subjects"

# Create data.frame "y" for the activities of the train and test files
# by using rbind. Then name the column and label the activities with descriptive names.
y_train <- read.table(paste(dir, "/train/y_train.txt", sep=""), quote="\"")
y_test <- read.table(paste(dir, "/test/y_test.txt", sep=""), quote="\"")
y <- rbind(y_train, y_test)
colnames(y) <- "activities"
y$activities <- factor(y$activities,
  labels=c("Walking","Walking_Up","Walking_Down","Sitting","Standing","Laying"))

# Create data.frame "x" for the measurements of the train and test file
# by using rbind. Then name the columns as read from the "features" file.
x_train <- read.table(paste(dir, "/train/x_train.txt", sep=""), quote="\"")
x_test <- read.table(paste(dir, "/test/x_test.txt", sep=""), quote="\"")
x <- rbind(x_train, x_test)
colnames(x) <- read.table("features.txt")[,2]

# Drop all columns from "x" that do not have the mean or
# the standard deviation of a measurement.
drop <- integer()
for(i in 1:length(x[1,])){
  col <- colnames(x[i])
  if(grepl("(.*)-mean\\(\\)(.*)", col)) {
    next
  } else if(grepl("(.*)-std\\(\\)(.*)", col)) {
    next
  } else {
    drop <- append(drop, i)
  }
}
x <- x[,-drop]

# Bring all three data.frames("subjects","y","x") together by using cbind.
data <- cbind(subjects, y, x)

# Make the data set tidy by making the rows unique for each activity and subject.
# The values of the variables are set to their mean.
molten <- melt(data, id=c("subjects", "activities"))
tidyData <- dcast(molten, subjects + activities ~ variable, mean)

# Export the tidy data as csv file with .txt ending for coursera upload.
write.table(tidyData, file="tidyData.txt", sep=",")