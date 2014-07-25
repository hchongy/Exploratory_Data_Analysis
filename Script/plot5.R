#Plot5
#======

## Load data from rds files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Extract values with a pattern "Comb.*Coal"
regular_expression <- "Mobile - On-Road"
extract_mobile_road <- grep(regular_expression, SCC$EI.Sector, ignore.case=TRUE)

## Get the SCC codes for Coal Combustion
scc_mobile_road <- SCC[extract_mobile_road, 1]

### Get NEI subset for Baltimore city fips
NEI_24510 <- NEI[NEI$fips == "24510",]

## Get subset of NEI 
NEI_24510_mobile_road <- NEI_24510[NEI_24510$SCC %in% scc_mobile_road, c("Emissions", "year")]

# Sum Emissions by year
NEI_24510_mobile_road_sum <- aggregate(Emissions ~ year, data=NEI_24510_mobile_road, sum)

## Plot chart with line and point types
plot(NEI_24510_mobile_road_sum$year, 
     NEI_24510_mobile_road_sum$Emissions, 
     type="b", 
     main="Motor Vehicle Emissions in Baltimore City", 
     xlab="Year", 
     ylab="Emissions of PM2.5 (in tons)")

## Export the chart to plot4.png with a width of 640 x 640 pixels 
dev.copy(png, file ="plot5.png", width=640, height=640)
dev.off()
