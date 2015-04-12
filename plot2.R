## read the data and separate by semicolon and replace "?" by "NA"s
house <- read.csv("~/Desktop/CS stuff/4 - Exploratory Data Analysis/WD4/household_power_consumption.txt",
                  sep=";", na.strings="?", stringsAsFactors = FALSE)

## load required library and subset for the dates needed
library(dplyr)
house %>% na.exclude  %>% tbl_df

## subset for the dates needed
sub_house1 <- filter(house, Date == "1/2/2007")
sub_house2 <- filter(house, Date == "2/2/2007")
sub_house3 <- bind_rows(sub_house1,sub_house2) ## correct number of observations!

## rearrange the data frame
sub_house4 <- mutate(sub_house3, DateTime = paste(Date, Time, sep = " ")) ## combine Date & Time columns into DateTime
sub_house5 <- select(sub_house4, DateTime, Global_active_power:Sub_metering_3) ## remove old columns by select

## parse DateTime column into Date and Time classes
library(lubridate)
sub_house5$DateTime <- dmy_hms(sub_house5$DateTime)

## plot 2 code and save into png file
png(filename = "plot2.png", width = 480, height = 480, bg = "transparent")
plot(sub_house5$DateTime, sub_house5$Global_active_power, type = "n", xlab = " ", ylab = "Global Active Power (kilowatts)")
        lines(sub_house5$DateTime, sub_house5$Global_active_power)
dev.off()

