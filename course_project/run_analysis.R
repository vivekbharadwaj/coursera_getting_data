### Getting and Cleaning Data Project
#
# This is a script for processing human activity recognition using smartphones data
#
# INPUT DATA SET:
#     http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
#
# DATA SAMPLE:
#     https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# the data is loaded from the "UCI HAR Dataset/" folder. The working directory has been set to this.
#
# Assumes that the libraries data.table and reshape2 are already installed. 
#

library(reshape2)
library(data.table)

# load_data function for loading data and merging it with labels. Can be used both with test/train
load_data <- function(x_file, y_file, subj_file, features, activity) {
  # saving labels needed for processing
  k_features <- grepl("mean|std", features)
  
  # Loading whole data file
  x_dat <- read.table(x_file)
  names(x_dat) = features
  
  # Filtering only mean and std columns
  x_dat = x_dat[,k_features]
  
  # Reading activities data
  y_dat <- read.table(y_file)
  y_dat[,2] = activity[y_dat[,1]]
  names(y_dat) = c("Activity_ID", "Activity_Label")
  
  # Reading subject IDs data
  subject <- read.table(subj_file)
  names(subject) = "subject"
  
  # Linking all columns together
  cbind(as.data.table(subject), y_dat, x_dat)
}

# Main function for processing dataset
run_analysis <- function(data_path = "UCI HAR Dataset/") {
  # Loading data column names for later use
  features <- read.table(paste(data_path,"features.txt", sep="")) [,2]
  # Loading names of activities
  activity <- read.table(paste(data_path,"activity_labels.txt", sep="")) [,2]
  
  # Loading test and train data using internal function
  test_data = load_data(x_file = paste(data_path,"test/X_test.txt", sep=""), y_file = paste(data_path,"test/y_test.txt", sep=""), subj_file = paste(data_path,"test/subject_test.txt", sep=""), features, activity)
  train_data = load_data(x_file = paste(data_path,"train/X_train.txt", sep=""), y_file = paste(data_path,"train/y_train.txt", sep=""), subj_file = paste(data_path,"train/subject_train.txt", sep=""), features, activity)
  
  # Merging test and train data
  dat = rbind(test_data, train_data)
  
  # Aggregating data grouping by id_labels
  id_labels   = c("subject", "Activity_ID", "Activity_Label")
  data_labels = setdiff(colnames(dat), id_labels)
  redata      = melt(dat, id = id_labels, measure.vars = data_labels)
  # Applying mean function to dataset
  final_data   = dcast(redata, subject + Activity_Label ~ variable, mean)
  
  write.table(final_data, file = paste(data_path,"final_data.txt", sep=""))
}

# Start of processing 
run_analysis()

