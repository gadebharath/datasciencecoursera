#Read Data
subject_train <- read.table("/Users/bharathgade/Documents/datascience/rtraining/data/gettingandcleaningdata/project/UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("/Users/bharathgade/Documents/datascience/rtraining/data/gettingandcleaningdata/project/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("/Users/bharathgade/Documents/datascience/rtraining/data/gettingandcleaningdata/project/UCI HAR Dataset/train/Y_train.txt")
subject_test <- read.table("/Users/bharathgade/Documents/datascience/rtraining/data/gettingandcleaningdata/project/UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("/Users/bharathgade/Documents/datascience/rtraining/data/gettingandcleaningdata/project/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("/Users/bharathgade/Documents/datascience/rtraining/data/gettingandcleaningdata/project/UCI HAR Dataset/test/Y_test.txt")
features <- read.table("/Users/bharathgade/Documents/datascience/rtraining/data/gettingandcleaningdata/project/UCI HAR Dataset/features.txt")
activity_labels <- read.table("/Users/bharathgade/Documents/datascience/rtraining/data/gettingandcleaningdata/project/UCI HAR Dataset/activity_labels.txt")

#Getting the training data together
colnames(X_train) <- as.character( features$V2 )
X_train_with_activity <- cbind(Y_train, X_train)
colnames(X_train_with_activity)[1] <- "activity"
all_train_data <- cbind(subject_train,X_train_with_activity)
colnames(all_train_data)[1] <- "subject"

#Repeat above steps for test data
colnames(X_test) <- as.character( features$V2 )
X_test_with_activity <- cbind(Y_test, X_test)
colnames(X_test_with_activity)[1] <- "activity"
all_test_data <- cbind(subject_test,X_test_with_activity)
colnames(all_test_data)[1] <- "subject"

#Merge training and test data
all_data <- rbind(all_train_data,all_test_data)

#Requirement 3: Use descriptive activity names to name the activities in the data set
colnames(activity_labels) <- c("activity", "activity_label")
all_data2 <- merge(all_data,activity_labels, by="activity")

#Requirement 2: Extract only the measurements on the mean and standard deviation for each measurement.
columns <- c(grep("mean", colnames(all_data2)),grep("std", colnames(all_data2)))
colnames_data <- colnames(all_data2)[columns]
all_data3 <- all_data2[,c(c("subject", "activity_label", "activity"),colnames_data)]

#Requirement 5: Create a second, independent tidy data set with the average
#of each variable for each activity and each subject.

all_data4 <- all_data3[,!(colnames(all_data3) %in% c("activity_label"))]
tidy_data <- aggregate(. ~ subject + activity, all_data4, mean)
tidy_data <- merge(tidy_data,activity_labels, by="activity")
tidy_data <- tidy_data[,c(2,82,3:81)]

#Return tidy data set
tidy_data
