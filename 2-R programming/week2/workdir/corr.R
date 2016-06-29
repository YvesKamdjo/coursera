corr <- function(directory, threshold = 0) {
    
    final <- vector(mode = "numeric")
   for(i in 1:332){
       padded <- pad_int(i,100)
       
       d <- readData(directory,padded)
       
       good <- complete.cases(d)
       
       d2 <- d[good,]
       
       if(nrow(d2) > threshold){
           sulf <- d2$sulfate
           nitr <- d2$nitrate
           
           crr <- cor(sulf,nitr)
           
           final <- c(final,crr)
        }
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