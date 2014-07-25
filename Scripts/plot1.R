#Plot1.R
#=======

## Load data from rds files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Find total emission of PM25 from year 1999 to 2008
total_pm25 <- aggregate(Emissions ~ year, data=NEI, sum)

## Plot chart with lline and point types
par(mfrow=c(1,1))

plot(total_pm25$year, total_pm25$Emissions, 
     type="b", 
     main="Total Emissions of PM2.5 in United States", 
     xlab="Year", 
     ylab="Emissions of PM2.5 (in tons)",
     col = "Blue")

## Export the chart to plot1.png with a width of 480 x 480 pixels 
dev.copy(png, file ="plot1.png", width=480, height=480)
dev.off()
