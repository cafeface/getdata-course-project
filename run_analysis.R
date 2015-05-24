# top level script

# define subroutines

# Create a data set from the Samsung data

create_data_set <- function( path, subset, feature_names ) {
    dir <- paste( path, subset, sep = "/" )
    subject_fname <- paste( "subject_", subset, ".txt", sep = "" )
    activity_fname <- paste( "y_", subset, ".txt", sep = "" )
    X_fname <- paste( "X_", subset, ".txt", sep = "" )
    X_set <- read.table( paste( dir, X_fname, sep = "/" ), col.names = feature_names )
    s_set <- read.table( paste( dir, subject_fname, sep = "/" ), col.names = "subject" )
    a_set <- read.table( paste( dir, activity_fname, sep = "/" ), col.names = "activity" )
    #act_set <- sapply(a_set, function(i) activities[i])
    cbind( a_set, s_set, X_set )
}

# Create an integrated data set from the Samsung data

create_integrated_data_set <- function( data_path ) {
    features <- read.table( paste( data_path, "features.txt", sep = "/" ), 
                            col.names = c("row", "feature" ) )
    feature_names <- as.character( features$feature )
    train <- create_data_set( data_path, "train", feature_names )
    test <- create_data_set( data_path, "test", feature_names )
    arrange( rbind( train, test ), activity, subject)
}

# create the tidy data set

run_analysis <- function( ) {
    data_path = paste( dd, "UCI HAR Dataset", sep = "/" )
    data_set <- create_integrated_data_set( data_path )
    filtered <- select( data_set, 
                        activity, 
                        subject, 
                        contains( "mean..", ignore.case =  FALSE),
                        contains( "std..", ignore.case = FALSE) )
    s_set <- ddply( filtered, .(activity, subject), function(feature) sapply(feature, mean) )
    activity_labels <- read.table( paste( data_path, "activity_labels.txt", sep = "/"), 
                                   col.names = c("a_idx", "activity") )
    activities <- as.character( activity_labels$activity )
    mutate( s_set, activity = activities[activity] )
}
