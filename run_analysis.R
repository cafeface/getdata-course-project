# top level script
run_analysis <- function( ... ) {
    # create the integrated data set
    data_set <- create_integrated_data_set( ... )
    subset <- select( data_set, 
                      subject, 
                      activity, 
                      contains( "mean..", ignore.case =  FALSE),
                      contains( "std..", ignore.case = FALSE) )
}
