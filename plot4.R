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

## rearrange the data frame:
sub_house4 <- mutate(sub_house3, DateTime = paste(Date, Time, sep = " ")) ## combine Date & Time columns into DateTime
sub_house5 <- select(sub_house4, DateTime, Global_active_power:Sub_metering_3) ## remove old columns by select

## parse DateTime column into Date and Time classes
library(lubridate)
sub_house5$DateTime <- dmy_hms(sub_house5$DateTime)

## plot 4 code and save all into png file
png(filename = "plot4.png", width = 480, height = 480, bg = "transparent")
par(mfrow = c(2, 2))

## graph 1 code
plot(sub_house5$DateTime, sub_house5$Global_active_power, type = "n", xlab = " ", ylab = "Global Active Power")
        lines(sub_house5$DateTime, sub_house5$Global_active_power)

## graph 2 code
plot(sub_house5$DateTime, sub_house5$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
        lines(sub_house5$DateTime, sub_house5$Voltage)

## graph 3 code
plot(sub_house5$DateTime, sub_house5$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = " ")
        lines(sub_house5$DateTime, sub_house5$Sub_metering_1)
        lines(sub_house5$DateTime, sub_house5$Sub_metering_2, col = "red" )
        lines(sub_house5$DateTime, sub_house5$Sub_metering_3, col = "blue" )
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, cex = 0.8, bty = "n", col = c("black", "red", "blue"))

## graph 4 code
plot(sub_house5$DateTime, sub_house5$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power" )
        lines(sub_house5$DateTime, sub_house5$Global_reactive_power)

dev.off()

