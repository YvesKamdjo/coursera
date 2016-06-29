q1 <- function(){
    #To prevent the use of French language
    Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")
    
    NEI <- readRDS("summarySCC_PM25.rds")
   
    ##First compute total PM emissions for each year
    aggregate.data <- with(NEI, aggregate(Emissions, by = list(year), sum))
    
    #Plotting
    plot(aggregate.data, type = "o", ylab = expression("PM2.5 Emissions"), 
         xlab = "Year", main = "Total Emissions in the United States From 1999 to 2008")
    
    dev.copy(png,file="plot1.png")
    dev.off()
}

q2 <- function(){
    NEI <- readRDS("summarySCC_PM25.rds")
    #SCC <- readRDS("Source_Classification_Code.rds")
}