## Load dplyr and lubridate
library(dplyr)
library(lubridate)

## Download file and unzip
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "power.zip", method="curl")
dateDownloaded <- date()
rm(fileURL)
unzip("power.zip")

## Load into dataframe
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                    na.strings = "?")

## Filter for two dates of interest
power <- filter(power, as.Date(Date, "%d/%m/%Y") == "2007-02-01" | as.Date(Date, 
                    "%d/%m/%Y") == "2007-02-02")

## Convert Date and Time
power <- mutate(power, DateTime = paste(Date, Time, sep = " "))
power$DateTime <- dmy_hms(power$DateTime)

## Create 4 chart PNG
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

## Plot top left
with(power, plot(DateTime, Global_active_power, type = "l",
                 xlab = "",
                 ylab = "Global Active Power (kilowatts)"
                 ))

## Plot top right
with(power, plot(DateTime, Voltage, type = "l"))

## Plot bottom left

with(power, plot(DateTime, Sub_metering_1, type = "n",
                 xlab="",
                 ylab = "Energy sub metering"
                 ))
    with(power, lines(DateTime, Sub_metering_1, col = "black"))
    with(power, lines(DateTime, Sub_metering_2, col = "red"))
    with(power, lines(DateTime, Sub_metering_3, col = "blue"))
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty=c(1,1),
           col=c("black", "red", "blue"))

## Plot bottom right
with(power, plot(DateTime, Global_reactive_power, type = "l"))

dev.off()
