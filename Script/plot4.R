#Plot4
#======

## Load data from rds files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Extract values with a pattern "Comb.*Coal"
regular_expression <- "Comb.*Coal"
extract_coal <- grep(regular_expression, SCC$EI.Sector, ignore.case=TRUE)

## Get the SCC codes for Coal Combustion
scc_coal_comb <- SCC[extract_coal, 1]

## Get subset of NEI 
NEI_coal_comb <- NEI[NEI$SCC %in% scc_coal_comb, c("Emissions", "year")]

# Sum Emissions by year
NEI_coal_comb_sum <- aggregate(Emissions ~ year, data=NEI_coal_comb, sum)

## Plot chart with line and point types
plot(NEI_coal_comb_sum$year, 
     NEI_coal_comb_sum$Emissions, 
     type="b", 
     main="Coal Combustion Emissions in United States", 
     xlab="Year", 
     ylab="Emissions of PM2.5 (in tons)")

## Export the chart to plot4.png with a width of 640 x 640 pixels 
dev.copy(png, file ="plot4.png", width=640, height=640)
dev.off()
