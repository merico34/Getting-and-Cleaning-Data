library("reshape2")
dir <- getwd()

subjects_train <- read.table(paste(dir, "/train/subject_train.txt", sep=""), quote="\"")
subjects_test <- read.table(paste(dir, "/test/subject_test.txt", sep=""), quote="\"")
subjects <- rbind(subjects_train, subjects_test)
colnames(subjects) <- "subjects"

y_train <- read.table(paste(dir, "/train/y_train.txt", sep=""), quote="\"")
y_test <- read.table(paste(dir, "/test/y_test.txt", sep=""), quote="\"")
y <- rbind(y_train, y_test)
colnames(y) <- "activities"
y$activities <- factor(y$activities,
  labels=c("Walking","Walking_Up","Walking_Down","Sitting","Standing","Laying"))

x_train <- read.table(paste(dir, "/train/x_train.txt", sep=""), quote="\"")
x_test <- read.table(paste(dir, "/test/x_test.txt", sep=""), quote="\"")
x <- rbind(x_train, x_test)
colnames(x) <- read.table("features.txt")[,2]

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

data <- cbind(subjects, y, x)

molten <- melt(data, id=c("subjects", "activities"))
tidyData <- dcast(molten, subjects + activities ~ variable, mean)
