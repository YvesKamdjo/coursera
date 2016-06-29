plot4 <- function(){
    #To prevent the use of French language
    Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")
    
    #Get data
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
    #Get all coal combustion-related sources
    get_coal <- grep("*.coal.*", SCC$Short.Name, ignore.case = TRUE)
    
    #Subset to retain only coal combustion-related data
    SCC.COAL <- SCC[get_coal,]
    
    #we extract only SCC column
    SCC.COAL <- SCC.COAL$SCC
    
    #Subsetting NEI data
    NEI.COAL <- subset(NEI,NEI$SCC %in% SCC.COAL)
    
    ##First compute total PM emissions for each year
    aggr <- with(NEI.COAL, aggregate(Emissions, by = list(year), sum))
    
    png(filename = "plot4.png", 
    width = 480, height = 480, 
    units = "px")
   
    
    #Plotting
    plot(aggr, type = "o", ylab = expression("PM2.5 Emissions"), 
         xlab = "Year", main = "Emissions from coal sources in USA From 1999 to 2008")
    
    
    dev.off()
}