# 1. Merges the training and the test sets to create one data set.

train <- read.table("train/X_train.txt")
test <- read.table("test/X_test.txt")
X <- rbind(train, test)

train <- read.table("train/subject_train.txt")
test <- read.table("test/subject_test.txt")
Subj <- rbind(train, test)

train <- read.table("train/y_train.txt")
test <- read.table("test/y_test.txt")
Y <- rbind(train, test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")
good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, good_features]
names(X) <- features[good_features, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))  

# 3. Uses descriptive activity names to name the activities in the data set

activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y[,1] = activities[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.

names(Subj) <- "subject"
cleaned <- cbind(Subj, Y, X)
write.table(cleaned, "mc_data.txt")

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniSubj = unique(Subj)[,1]
numSubj= length(unique(Subj)[,1])
numAct = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubj*numAct), ]

row = 1
for (s in 1:numSubj) {
	for (a in 1:numAct) {
		result[row, 1] = uniSubj[s]
		result[row, 2] = activities[a, 2]
		tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
		result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
		row = row+1
	}
}
write.table(result, "final.txt")
