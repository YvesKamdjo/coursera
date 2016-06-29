plot2 <- function(){
    #To prevent the use of French language
    Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")
    
    NEI <- readRDS("summarySCC_PM25.rds")
    
    ##Subset the data frame to retain only Baltimore data
    baltimore <- subset(NEI,NEI$fips=="24510", select=c("Emissions","year"))
    
    ##compute total PM emissions for each year
    aggr <- with(baltimore, aggregate(Emissions, by = list(year), sum))
    
    #Plotting
    plot(aggr, type = "o", ylab = expression("PM2.5 Emissions"), 
         xlab = "Year", main = "Total Emissions in Baltimore From 1999 to 2008")
    
    dev.copy(png,file="plot2.png")
    dev.off()
}