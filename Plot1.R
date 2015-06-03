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

## Create histogram PNG
png("plot1.png", width = 480, height = 480)
hist(power$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()
