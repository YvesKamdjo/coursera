question18 <- function(f){
  ot <- subset(f,f$Ozone>31 & f$Temp>90,drop = FALSE)
  return(mean(ot$Solar.R))
}
question19 <- function(f){
   ot <- subset(f,f$Month==6,drop = FALSE)
  return(mean(ot$Temp))
}
question20 <- function(f){
ot <- subset(fileTab,fileTab$Month==5, drop=FALSE)
ot <- subset(fileTab,fileTab$Month==5 & !is.na(fileTab$Ozone), drop=FALSE)

m <- sapply(ot,max, na.rm = TRUE)
return(m[1])
}