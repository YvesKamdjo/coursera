pollutantmean <- function(directory,polluant,id = 1:332){
  
    vec <- vector()
    
    if(length(directory) != 1 | length(polluant) != 1){
        return(means)
    }
    
    
    for (i in id) {
      
        padded <- pad_int(i,100)
        
        d <- readData(directory,padded)
       
        pol<- d[,polluant]
        
        vec <- c(vec,pol)
        
    }
    
    mean(vec, na.rm=TRUE)
   

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
