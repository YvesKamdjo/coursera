plot5 <- function(){
    #To prevent the use of French language
    Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")
    
    #Get data
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
    #Get all coal combustion-related sources
    get_motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
    
    #Subset to retain only coal combustion-related data
    SCC.MOTOR <- SCC[get_motor,]
    
    #we extract only SCC column
    SCC.MOTOR <- SCC.MOTOR$SCC
    
    #Subsetting NEI data for Baltimore
    NEI.MOTOR <- subset(NEI,NEI$SCC %in% SCC.MOTOR & NEI$fips=="24510")
    
    ##First compute total PM emissions for each year
    aggr <- with(NEI.MOTOR, aggregate(Emissions, by = list(year), sum))
    
    png(filename = "plot5.png", 
    width = 480, height = 480, 
    units = "px")
   
    
    #Plotting
    plot(aggr, type = "o", ylab = expression("PM2.5 Emissions"), 
         xlab = "Year", main = "Emissions from motors sources in Balt. From 1999 to 2008")
    
    
    dev.off()
}