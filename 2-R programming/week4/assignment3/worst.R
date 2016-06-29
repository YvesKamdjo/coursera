
worst <- function(state,outcome){
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
    
    temp <- data.frame(HN=submeasure[,2],Rate=suppressWarnings(as.numeric(submeasure[,colnumb])))
    
    good <- complete.cases(temp$Rate)
    temp <- temp[good,]
    
    temp <- temp[order(temp$Rate,temp$HN,na.last = TRUE,decreasing = TRUE),]
    
    t <- temp$HN
    t <- temp[1,]$HN
    return(as.character(t))
    
}