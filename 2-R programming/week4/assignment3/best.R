
best <- function(state,outcome){
    ##include common functions file
    source('common.R')
    
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
        stop('invalid state')
    }
    
    ##get the lowest outcome value in the state
    
    submeasure <- subset(measures,measures$State==state)
    
    ###Remove all NA values
    ok <- complete.cases(submeasure[,colnumb])
    submeasure <- submeasure[ok,]
    
    out <- submeasure[,colnumb]
    
    out <- suppressWarnings(as.numeric(out))
    
   ##Get the min value
    min_val <- min(out,na.rm = TRUE)
    
    hosp <- subset(submeasure,submeasure[,colnumb]==min_val)
    
    h <- sort(hosp$Hospital.Name)
    
    return(h[1])
   
}