readfile <- function(pathname){
    
    if(file.exists(pathname))
        outcome <- read.csv(pathname,header = TRUE,sep = ",")
    else
        stop("The file doesn't exist")
    
    return(outcome)
}

q1<- function(d){
    sp <- strsplit(names(d), "wgtp")
    
    sp[[123]]
}