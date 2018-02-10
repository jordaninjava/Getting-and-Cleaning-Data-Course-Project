library(plyr)

# Download Data file.exists, variable (url, file, dataPath)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file <-"getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataPath <- "UCI HAR Dataset" 


# If file has does not exist, then download
if (!file.exists(file)) {
	download.file(url, file)
}

# If folder does not exist, unzip
if (!file.exists(dataPath)) {
	unzip(file)
}


#STEP 1: MERGES THE TRAINING AND TEST SETS TO CREATE ONE DATA SET
# Read the subjects, data and activity names for training data
trainingSubjects <- read.table(file.path(dataPath, "train", "subject_train.txt"))
trainingValues <- read.table(file.path(dataPath, "train", "X_train.txt"))
trainingActivity <- read.table(file.path(dataPath, "train", "y_train.txt"))

# Read the subjects, data and activity names for test data
testSubjects <- read.table(file.path(dataPath, "test", "subject_test.txt"))
testValues <- read.table(file.path(dataPath, "test", "X_test.txt"))
testActivity <- read.table(file.path(dataPath, "test", "y_test.txt"))


# Read the features
features <-  read.table(file.path(dataPath, "features.txt"), as.is=TRUE)
featuresNames <- features[,2]


# Bind all data tables into a single data table
trainingData <- cbind(trainingSubjects, trainingValues, trainingActivity)
testData <- cbind(testSubjects, testValues, testActivity)
allData <- rbind(trainingData, testData)

#STEP 2: EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
# Assign column names - subject, features, activity
colnames(allData) <- c("Subject", features[,2], "Activity")

# Extract man and standard deviation for each measurement
featuresSelect <- grep(".*mean |.*std.*", featuresNames)
selectData <- allData[, c(1, featuresSelect, 563)]


#STEP 3: ASSIGNS ACTIVITY NAMES TO THE ACTIVITIES
# replace activity vales with names factor levels using factor function
activities <- read.table(file.path(dataPath, "activity_labels.txt"))
selectData$Activity <- factor(selectData$Activity, levels= activities[,1], labels= activities[,2])


#STEP 4: CREATE DESCRIPTIVE LABELS
# substitute abbreviations for complete words
columnNames <- colnames(selectData)
columnNames <- gsub("std", "StandardDeviation", columnNames)
columnNames <- gsub("mean", "Mean", columnNames)
columnNames <- gsub("Mag", "Magnitude", columnNames)
columnNames <- gsub("Gyro", "Gyroscope", columnNames)
columnNames <- gsub("Acc", "Accelerometer", columnNames)
columnNames <- gsub("^f", "frequencyDomain", columnNames)
columnNames <- gsub("^t", "timeDomain", columnNames)
columnNames <- gsub("Freq", "Frequency", columnNames)
colnames(selectData) <-columnNames


#STEP 5: CREATE A SECOND, INDEPENDENT TIDY DATA SET
averageData <- aggregate(. ~Subject + Activity, selectData, mean)
write.table(averageData, file = "averageData.text", row.name=FALSE)

