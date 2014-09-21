# run_analysis.R

Getting and Cleaning Data Course Project

This repository is a deliverable for the course project for the Coursera "Getting and Cleaning Data" subject.

Information about the data can be found in CodeBook.md. This repo also contains an R script, run_analysis.R, which:

* Reads input data originally downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  and extracted into yout working directory.
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The output data set is generated as "FinalData.txt".