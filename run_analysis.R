#Load dplyr library in order to help filtering, manipulating, grouping data sets
library(dplyr)

#Load activity id's and activity names
activity_master <- read.table("../UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)

#Load Feature id's and Feature names
features_master <- read.table("../UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

#Filter out the featured to include only the ones containing mean, std
filtered_features_master <- filter(features_master,grepl("mean",features_master[,2]) | grepl("std",features_master[,2]))

#Convert the list to vector of relevant and filtered column indexes
filteredFeaturesColIndices <- unname(unlist(filtered_features_master[,1]))

#Convert the list to vector of relevant and filtered column names
filteredFeaturesColNames <- unname(unlist(filtered_features_master[,2]))

#Load training data,activities, subjects and combine the columns to a single training data set
training_data <- read.table("../UCI HAR Dataset/train/X_train.txt")[filteredFeaturesColIndices]
training_activities <- read.table("../UCI HAR Dataset/train/Y_train.txt")
training_subjects <- read.table("../UCI HAR Dataset/train/subject_train.txt")
training_data_set <- cbind(training_subjects, training_activities, training_data)

#Load testing data,activities, subjects and combine the columns to a single testing data set
testing_data <- read.table("../UCI HAR Dataset/test/X_test.txt")[filteredFeaturesColIndices]
testing_activities <- read.table("../UCI HAR Dataset/test/Y_test.txt")
testing_subjects <- read.table("../UCI HAR Dataset/test/subject_test.txt")
testing_data_set <- cbind(testing_subjects, testing_activities, testing_data)

#Merge training and testing datasets and add proper column names
combined_data_set <- rbind(training_data_set, testing_data_set)
colnames(combined_data_set) <- c("Subject", "Activity", filteredFeaturesColNames)

#create a new dataset that contains the mean value of each observation for each subject,activity combination
tidy_data_set <- combined_data_set %>% 
                        group_by(Subject,Activity) %>% 
                        summarise_each(funs(mean))

#Replace the activity id with activity name
tidy_data_set <- mutate(tidy_data_set,Activity = activity_master[Activity,2])

#Write the tidied data set to file
write.table(tidy_data_set, "tidied_mean_data.txt", row.name=FALSE, quote = FALSE)

