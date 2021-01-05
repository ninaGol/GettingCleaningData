
rm(list=ls())

w.dir <- "C:/Users/Nina/Documents/GettingCleaningData"
setwd("C:/Users/Nina/Documents/GettingCleaningData")


# =================================================================================================
# 1. Merges the training and the test sets to create one data set. + 
# 4. Appropriately labels the data set with descriptive variable names. 
# =================================================================================================

aa <- read.table(paste0(w.dir, "/UCI HAR Dataset/activity_labels.txt"))
bb <- read.table(paste0(w.dir, "/UCI HAR Dataset/features.txt"))

# Training data set
a <- read.table(paste0(w.dir, "/UCI HAR Dataset/train/subject_train.txt"))
b <- read.table(paste0(w.dir, "/UCI HAR Dataset/train/X_train.txt"))
c <- read.table(paste0(w.dir, "/UCI HAR Dataset/train/Y_train.txt"))

train <- cbind(a,c,b)
colnames(train) <- c("subject", "label", as.character(bb$V2))
unique(train$subject)
train$data <- "train"

# Test data set
a <- read.table(paste0(w.dir, "/UCI HAR Dataset/test/subject_test.txt"))
b <- read.table(paste0(w.dir, "/UCI HAR Dataset/test/X_test.txt"))
c <- read.table(paste0(w.dir, "/UCI HAR Dataset/test/Y_test.txt"))

test <- cbind(a,c,b)
colnames(test) <- c("subject", "label", as.character(bb$V2))
unique(test$subject)
test$data <- "test"

# Merge the data sets
e <- rbind(train, test)


# =================================================================================================
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# =================================================================================================

f <- e[ ,c("data", "subject", "label", grep("[Mm]ean|[Ss]td", colnames(e), value = T))]

# =================================================================================================
# 3. Uses descriptive activity names to name the activities in the data set
# =================================================================================================

g <- merge(f, aa, by.x="label", by.y = "V1")
names(g)[names(g) == "V2"] <- "activity"
# colnames(g)
g <- g[, c("data", "subject", "label", "activity", grep("[Mm]ean|[Ss]td", colnames(e), value = T))]

# =================================================================================================
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
# =================================================================================================

h <- g
h$data <- NULL
h$activity <- NULL
h <- aggregate(h, by=list(h$subject, h$label), FUN = "mean", na.action = na.pass)
# remerging the data because otherwise there are warnings of NA in previous step
h <- merge(h, aa, by.x="label", by.y = "V1")
names(h)[names(h) == "V2"] <- "activity"
h$Group.1<- NULL
h$Group.2 <- NULL
h <- h[with(h, order(subject, label)), c("subject", "label", "activity", grep("[Mm]ean|[Ss]td", colnames(h), value = T))]
