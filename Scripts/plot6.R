#Plot6
#======

Changes <- function(x) {
        return ((x-min(x))/(max(x)-min(x)))
}

## Load data from rds files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Extract values with a pattern "Mobile - On-Road"
regular_expression <- "Mobile - On-Road"
extract_mobile_road <- grep(regular_expression, SCC$EI.Sector, ignore.case=TRUE)

## Get the SCC codes for automobile on the road
scc_mobile_road <- SCC[extract_mobile_road, 1]

### Get NEI subset for Baltimore city fips
NEI_24510 <- NEI[NEI$fips == "24510",]

### Get NEI subset for Los Angeles fips
NEI_06037 <- NEI[NEI$fips == "06037",]

## Get subset of NEI for Baltimore city fips
NEI_24510_mobile_road <- NEI_24510[NEI_24510$SCC %in% scc_mobile_road, c("Emissions", "year")]

## Get subset of NEI for Los Angeles fips
NEI_06037_mobile_road <- NEI_06037[NEI_06037$SCC %in% scc_mobile_road, c("Emissions", "year")]

# Sum Emissions by year for Baltimore city fips
NEI_24510_mobile_road_sum <- aggregate(Emissions ~ year, data=NEI_24510_mobile_road, sum)
NEI_24510_mobile_road_sum$Emissions <- Changes(NEI_24510_mobile_road_sum$Emissions)
NEI_24510_mobile_road_sum <- cbind(NEI_24510_mobile_road_sum, "Country" = c("Baltimore city"))

# Sum Emissions by year for Los Angeles fips
NEI_06037_mobile_road_sum <- aggregate(Emissions ~ year, data=NEI_06037_mobile_road, sum)
NEI_06037_mobile_road_sum$Emissions <- Changes(NEI_06037_mobile_road_sum$Emissions)
NEI_06037_mobile_road_sum <- cbind(NEI_06037_mobile_road_sum, "Country" = c("Los Angeles city"))

## Combined Baltimore city data & Los Angeles Data
NEI_24510_06037_final <- rbind(NEI_24510_mobile_road_sum, NEI_06037_mobile_road_sum)

## Plot chart with line and point types
plot6 <- qplot(year, Emissions, data=NEI_24510_06037_final, color=Country, geom="path", 
               xlab="Year", ylab="Emissions Changes", 
               main="Motor Vehicle Emissions Changes Comparison")

## Export the chart to plot6.png
ggsave(plot6, file="plot6.png")




