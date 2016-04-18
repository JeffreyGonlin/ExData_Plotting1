## Exploratory Data Analysis - Week 1 Assignment - plot3.R

setwd("~/R/Exploratory Data Analysis/Data")
library(dplyr)
library(data.table)
library(lubridate)

# USE: Coursera site: "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# original data site: "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/"

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "~/R/Exploratory Data Analysis/Data/household_power_consumption.zip")
download.file(fileUrl, destfile = "~/R/Exploratory Data Analysis/Data/household_power_consumption_untouched.zip")
dateDownloaded <- date()

household_power_consumption <- unzip("household_power_consumption.zip")
household_power_consumption <- read.table("./household_power_consumption.txt", header = TRUE, na.strings = "?", sep = ";", colClasses = c("factor", "factor", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

household_2day <- filter(household_power_consumption, Date == "1/2/2007" | Date == "2/2/2007")
household_2day$Date <- strptime(household_2day$Date, format = "%d/%m/%Y")
household_2day$Time <- strptime(household_2day$Time, format = "%H:%M:%S") 
household_2day$Time <- strftime(household_2day$Time, format = "%H:%M:%S")

household_2day <- mutate(household_2day, datetime = as.POSIXct(paste(household_2day$Date, household_2day$Time, format = "%d-%m-%Y %H:%M:%S")))
household_2day <- mutate(household_2day, weekday = wday(household_2day$datetime, label = TRUE))

na_check <- sum(as.numeric(is.na(household_2day)))
na_check

str(household_2day)
head(household_2day) 
tail(household_2day)

######################################################
# Plot 3 - Sub-metering 1,2 3

png(file = "~/R/Exploratory Data Analysis/Data/plot3.png", height=480, width = 480)

plot(household_2day$Sub_metering_1, pch = "", ylab = "Energy sub metering", xlab = "", xaxt="n")
title("Plot 3", outer = FALSE, adj = 0, font = 2)
lines(household_2day$Sub_metering_1)
axis(side=1, at=c(1, 1441, 2880), labels=c("Thur", "Fri", "Sat"))
lines(household_2day$Sub_metering_2, col = "red")
lines(household_2day$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), fill = c("black", "red", "blue"))

dev.off()

# on screen plot:
plot(household_2day$Sub_metering_1, pch = "", ylab = "Energy sub metering", xlab = "", xaxt="n")
title("Plot 3", outer = FALSE, adj = 0, font = 2)
lines(household_2day$Sub_metering_1)
axis(side=1, at=c(1, 1441, 2880), labels=c("Thur", "Fri", "Sat"))
lines(household_2day$Sub_metering_2, col = "red")
lines(household_2day$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), fill = c("black", "red", "blue"))

####### END plot3.R #######