#Plot3
#======

## Load data from rds files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Load ggplot2 package
library(ggplot2)

#Find total emission of PM25 from year 1999 to 2008
total_pm25_24510_by_type <- aggregate(Emissions ~ year + type, data=NEI[NEI$fips=="24510",], sum)

## Plot chart with line and point types
plot3 <- qplot(year, 
               Emissions,
               data=total_pm25_24510_by_type,
               main="Emissions by type in Baltimore City",
               color=type, 
               geom="path",
               xlab="Year", 
               ylab="Emissions of PM2.5 (in tons)")


## Export the chart to plot1.png with a width of 480 x 480 pixels 
ggsave(plot3, file="plot3.png", width=6, height=4,units = "in")

