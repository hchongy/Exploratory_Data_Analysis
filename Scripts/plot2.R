#Plot2
#======

## Load data from rds files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Find total emission of PM25 from year 1999 to 2008
total_pm25_24510 <- aggregate(Emissions ~ year, data=NEI[NEI$fips=="24510",], sum)

## Plot chart with line and point types
plot(total_pm25_24510$year, total_pm25_24510$Emissions, 
     type="b", 
     main="Total Emissions in Baltimore City", 
     xlab="Year", 
     ylab="Emissions of PM2.5 (in tons)",
     col = "Blue")

## Export the chart to plot1.png with a width of 480 x 480 pixels 
dev.copy(png, file ="plot2.png", width=480, height=480)
dev.off()