# Peer-Review-Project
This is my Peer Review Project for Getting and Cleaning Data class.  The goal of this project was to take data sets and great a tidy data set.  The finished tidy data set is called totaldata and a summarized tidy data set is called data_summary.  This project consists of the R script - run_analysis.R, this readme file, and a code book.

The analysis of the data
FThe process is as follows:
1 Read in test subject file (suject_test.txt) 
2 Add column to indictate type of subject, used later when test and training data is combined
3 Add column names - subject and type of subject
4 Read in activity type data file and add column name - activity
5 Read in activity labels file 
6 Read in the actual activity test data file
7 Read in features.txt, which will be the labels for activity test data
8 Clean up activity file and create a dataframe
9 Merge the activity type file and activity label file to create an actvity file with named activities
10 Take features.txt information and name the activity test data columns with it
11 Combine all the data to then create the tidy test data table
12 Repeat steps for the training data, read in training subject file
13 Add column to indictate type of subject, used later when test and training data is combined
14 Add column names - subject and type of subject
15 Read in activity type file and add column name - activity
16 Merge the activity type and activity label files to create actvity file with proper labels
17 Read in actual training activity data file
18 Take features.txt information and name the activity training data columns with it
19 Combine all the data to then create the tidy training data table
20 Combine the test and training data datasets into one tidy training data table
21 Create a second tidy data set with the average of each variable for each activity and each subject
