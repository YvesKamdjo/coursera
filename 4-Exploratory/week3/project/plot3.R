plot3 <- function(){
    #To prevent the use of French language
    Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")
    
    NEI <- readRDS("summarySCC_PM25.rds")
    
    ##Subset the data frame to retain only Baltimore data
    baltimore <- subset(NEI,NEI$fips=="24510", select=c("Emissions","type","year"))
    
    library(plyr)
    
    #For each subset of a data frame, sum Emissions
    baltimore <- ddply(baltimore, .(type, year), summarize, Emissions = sum(Emissions))
    
    #Plotting with ggplot2
    library(ggplot2)
    
   
    #Plotting
    p <- qplot(year,Emissions,data = baltimore,facets = type~.
               ,color=type,
               geom = c("point","line"),
               group=type,
               main="PM2.5 Emissions by type of sources from 1999 to 2008")
    p + xlab("Year") + ylab("PM2.5 Emissions")
        
    
    dev.copy(png,file="plot3.png")
   dev.off()
    
}