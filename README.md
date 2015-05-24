# Course Project for Getting and Cleaning Data

## Description

This repository contains the deliverables for the Course Project for the Coursera course
Getting and Cleaning Data (data-014).

## Repository Contents

File            | Purpose
----------------|-------------------------------------------------------
README.md       | This file.  Describes how the code works.
run_analysis.R  | Script to read data files and prepare a tidy data set.
Codebook.Rmd    | Description of the data set.

## Raw Data Description

The raw data appear in the folder "UCI HAR Dataset."  Within that folder are text files describing the study that produced the data, the measured variables, and the data files and their formats.  In addition, the folder contains two folders, "test," and "train," that each contain raw data files comprising one of the two disjoint subsets into which the entire data set was partitioned.  In the test folder are "X_test.txt," "subject_test.txt," and "y_test.txt," and in the train folder are similarly named files.  These are the data of interest.

## Code description

The code makes use of the plyr and dplyr R library packages.  To run the script, the packages must be installed, but the script takes care of loading the libraries in the proper sequence.

The script defines three functions:

* `create_data_set <- function( data_path, subset, feature_names )` -- creates a data table of 563 variables: subject, activity code, and the 561 measured variables.
    + `data_path` -- a character vector specifying the top-level raw dat folder
    + `subset` -- "train" | "test"
    + `feature_names` -- a list of character vectors, one for each measured variable
    
* `create_integrated_data_set <- function( data_path )` --  Defines the feature names by modifying the names given for the raw data and passes them to `create_data_set()`.   Creates and combines data tables for the train and test data, then uses `rbind` to join them and `arrange` to sort the rows by subject and activity.
    + `data_path` -- a character vector specifying the top-level raw dat folder

* `run_analysis <- function( )` -- creates and returns the tidy data set.  Defines the data path and gets the data table returned by `create_integrated_data_set()`. Uses `select()` the create a second table that includes only raw measurements with "mean()" or "std()" in the raw name.  Makes a final adjustement to feature_names and applies them.  Uses `ddply()` to break the data table into parts by subject and activity code, then uses `sapply()` to find the means of data for each measurement in each part.  Reads the activity descriptions from the activity data table and uses `mutate()` to replace the activity codes with activity names in the resultant data table.  That table is returned.

## To run:

With the top-level raw data folder in the working directory, type: 

`tidy_data <- run_analysis`


