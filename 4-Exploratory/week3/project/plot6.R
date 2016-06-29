plot6 <- function(){
    #To prevent the use of French language
    Sys.setlocale(category = "LC_ALL", locale = "English_United States.1252")
    
    #Get data
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
    #Get all coal combustion-related sources
    get_motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
    
    #Subset to retain only motor 
    SCC.MOTOR <- SCC[get_motor,]
    
    #we extract only SCC column
    SCC.MOTOR <- SCC.MOTOR$SCC
    
    #Subsetting to retain only PM2.5 motors sources
    NEI.MOTOR <- subset(NEI,NEI$SCC %in% SCC.MOTOR )
    
    #Subsetting NEI data for Baltimore
    NEI.MOTOR.24510 <- subset(NEI.MOTOR,(NEI.MOTOR$fips=="24510"))
    
    #Subsetting NEI data for Los Angeles
    NEI.MOTOR.06037 <- subset(NEI.MOTOR,(NEI.MOTOR$fips=="06037"))
    
    ##compute total PM emissions for each year
    aggr.24510 <- with(NEI.MOTOR.24510, aggregate(Emissions, by = list(year), sum))
    aggr.06037 <- with(NEI.MOTOR.06037, aggregate(Emissions, by = list(year), sum))
    
    #Rename the columns
    colnames(aggr.06037) <- c("year","Emissions")
    colnames(aggr.24510) <- c("year","Emissions")
    
    #Add a new column for Baltimore and Los Angeles
    aggr.24510$city <- rep("Baltimore", length(aggr.24510[,1]))
    aggr.06037$city <- rep("Los Angeles", length(aggr.06037[,1]))
    
    #Bind rows
    aggr <- rbind(aggr.06037,aggr.24510)
    
    #Plotting
      p <- qplot(year,Emissions,data = aggr,facets = city~.
               ,geom = c("point","smooth")
               ,color=city)
    
    p + xlab("Year") + ylab("PM2.5 Emissions")
    
    dev.copy(png,file="plot6.png")
    dev.off()
}