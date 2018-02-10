#Getting and Cleaning Data - Course Project - Code Book 

This document contains a list of the variables used in 'run_analysis.R' The script 'run_analysis.R' performs the five steps outlined in the README.md file and describes on the comments in the 'run_analysis' file. 

#Variables

- 'trainingSubjects', 'trainingValues' and trainingActivity contain the training set data
- testSubjects, testValues and testActivity contain the test data
- 'features' is a dataframe containing the proper cames of the data columns and 'featuresNames' contains only the names
- the training and test data  is then combined into 'trainingData' and 'testData' and these two data frames are combined into ''allData'
- 'featuresSelect' contains features that contain mean and standard deviation, selected with the grep function
- 'selectData' is a data frame containing only the columns selected with 'featuresSelect'
- 'activities' contains the six different activities measured
- 'coiumnNames' contains the names of the columns which are made more descriptive by substituting abbreviations for complete words
- 'averageData' is a dataframe containing the avearage of each variable for each activity and each subject


# Versions
- 'run_analysis.R' was written using "R version 3.4.2 (2017-09-28)" and plyr"3.4.0"
- all work was done on Mac OS 10.13.2
