rankall <- function(outcome,num="best"){
    source('common.R')
    
    measures <- readfile()
    
    colsnames <- names(measures)
    
    ###Outcome validity
    outcome <- gsub(" ",".",outcome)
    
    test <- grep(outcome,colsnames,ignore.case = TRUE)
    if(length(test)<1){
        stop('invalid outcome')
    }
    
    colnumb <- test[1]
    colName <- colsnames[colnumb]
    
    ##List of distinct states
    states <- unique(measures[,7])
    
    ##Function
    compute <- function(state,colnumb,num){
        
        ##get the lowest outcome value in the state
        
        submeasure <- subset(measures,measures$State==state)
        
        out <- submeasure[,colnumb]
        
        temp <- data.frame(HN=submeasure[,2],Rate=suppressWarnings(as.numeric(submeasure[,colnumb])))
        
        good <- complete.cases(temp$Rate)
        temp <- temp[good,]
        
        temp <- temp[order(temp$Rate,temp$HN,na.last = TRUE,decreasing = FALSE),]
        
        total <- length(temp$Rate)
        t <- NA
        
        if(num=='best'){
            t <- temp[1,]
            return (as.character(t$HN))
        }
        
        if(num=='worst'){
            t <- temp[total,]
            return (as.character(t$HN))
        }
        
        if(total<num){
            return(NA)
        }
        
        t <- temp[num,]
        return (as.character(t$HN))
    }
    
    
    
    hosp <- sapply(states,compute,colnumb,num)
    
    d <- data.frame(hospital=hosp,state=states)
    return(d[order(d$state,na.last = TRUE,decreasing = FALSE),])
}