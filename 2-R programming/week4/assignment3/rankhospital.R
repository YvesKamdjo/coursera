rankhospital <- function(state,outcome,num='best'){
    
    if(num=='best'){
        source('best.R')
       return( best(state,outcome))
    }
        
    if(num=='worst'){
        source('worst.R')
        return(worst(state,outcome))
    }
    
    source('custom.R')
    
    r <- custom(state,outcome,num)
    
    r
    
}