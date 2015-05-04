# Read the data, separate by semicolon and replace "?" by "NA"s
house <- read.csv("~/Desktop/CS stuff/4 - Exploratory Data Analysis/WD4/household_power_consumption.txt",
                  sep=";", na.strings="?", stringsAsFactors = FALSE)

# Load required library and subset for the dates needed
library(dplyr)
house %>% na.exclude  %>% tbl_df

# Subset for the dates needed
sub_house1 <- filter(house, Date == "1/2/2007")
sub_house2 <- filter(house, Date == "2/2/2007")
sub_house3 <- bind_rows(sub_house1,sub_house2) ## correct number of observations!

# Plot 1 code and save into png file
png(filename = "plot1.png", width = 480, height = 480, bg = "transparent")

hist(sub_house3$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)" )

dev.off()
