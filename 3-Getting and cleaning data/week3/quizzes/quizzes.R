readfile <- function(fname="ss06hid.csv"){
    outcome <- read.csv(fname, colClasses = "character")
    return(outcome)
}

q1 <- function(){
    dt <- readfile();
    agricultureLogical <- dt$ACR==3 & dt$AGS==6
    
    dt2 <- which(agricultureLogical)
    str(dt2)
}

q2 <- function(){
    
    library(jpeg)
    
    jp <- readJPEG("img.jpg",native=TRUE)
  
    res <- quantile(jp,c(0.3,0.8))
    res
}

q3 <- function(){
    dt1 <- read.csv2("GDP.csv",skip = 4,sep=",",skipNul = TRUE,nrows = 190)
    
    gdp <- dt1[, c(1, 2, 4, 5)]
    colnames(gdp) <- c("CountryCode", "Rank", "Country.Name", "GDP.Value")
    
    edu <- read.csv("Country.csv",sep=",", header = TRUE)
    
    ## Merge data by country codes
    matchedData <- merge(gdp, edu, by.x = "CountryCode", by.y = "CountryCode")
    
    print(dim(matchedData)[1])
    library(plyr)
    
    matchedData <- arrange(matchedData,desc(Rank))
    
    print(as.character(matchedData[13,3]))
    
    ##Question 4
    
    m1<-mean(subset(matchedData, Income.Group %in% "High income: OECD", select = c(Rank))$Rank)
    print(m1)
    
    ## Subset "High income: nonOECD"
    m2<-mean(subset(matchedData, Income.Group %in% "High income: nonOECD", select = c(Rank))$Rank)
    print(m2)
    
    ##Question 5
    library(Hmisc)
    ## Cut Ranks into 5 groups and store as factor variable
    matchedData$Rank.Groups = cut2(matchedData$Rank, g = 5)
    ## Build a table of Income Groups across Rank Groups
    table(matchedData$Income.Group, matchedData$Rank.Groups)
}