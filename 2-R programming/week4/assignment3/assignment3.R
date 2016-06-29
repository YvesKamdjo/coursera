readfile <- function(fname="outcome-of-care-measures.csv"){
    outcome <- read.csv(fname, colClasses = "character")
    return(outcome)
}

best <- function(state,outcome){
    ##Read outcome data
    measures <- readfile()
    
    ##Check the state and outcome validity
    colsnames <- names(measures)
    
    ###Outcome validity
    outcome <- gsub(" ",".",outcome)
    
    test <- grep(outcome,colsnames,ignore.case = TRUE)
    if(length(test)<1){
        stop('invalid outcome')
    }
    
    colnumb <- test[1]
   
    ##List of distinct states
    states <- unique(measures[,7])
    
    if(!state%in%states){
        stop('invalide state')
    }
    
    ##get the lowest outcome value in the state
    
    submeasure <- subset(measures,measures$State==state)
    
    ###Remove all NA values
    ok <- complete.cases(submeasure[,colnumb])
    submeasure <- submeasure[ok,]
    
    out <- submeasure[,colnumb]
    
    out <- suppressWarnings(as.numeric(out))
    
    min_index <- which(out == min(out,na.rm = TRUE))
   
    return(submeasure$Hospital.Name[min_index])
    
}