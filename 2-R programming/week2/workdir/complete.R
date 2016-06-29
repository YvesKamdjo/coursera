complete <- function(directory, id = 1:332) {
    
    l <- length(id)
    
    final <- data.frame(id= integer(l), nobs= integer(l))
    
    j<-1
    
    for(i in id){
        
        padded <- pad_int(i,100)
        
        d <- readData(directory,padded)
        
        good <- complete.cases(d)
        
        d2 <- d[good,]
       
        final$id[j] <- i
        
        final$nobs[j] <- nrow(d2)
        
        j <- j+1
        
    } 
    
   
    return(final)
}

readData <- function(directory,fileName){
    
    csv <- paste(directory,"/",fileName,".csv",sep='')
    
    read.csv(csv)
}

pad_int<-function(n,scale){
    
    out_string<-paste(10*scale + n,sep='')
    
    out_string<-substr(out_string,2,nchar(out_string))
    
    return(out_string)
}