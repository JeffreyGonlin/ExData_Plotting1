## Exploratory Data Analysis - Week 1 Assignment - plot1.R

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
# Plot 1 - Global Active Power Histogram

png(file = "~/R/Exploratory Data Analysis/Data/plot1.png", height=480, width = 480)

Global_Active_Power <- household_2day$Global_active_power
par(oma = c(4,4,6,2))
hist(Global_Active_Power, col = "red", xlab = "Global Active Power (kilowatts)")
title("Plot 1", outer = TRUE, adj = 0, font = 2)

dev.off()

# on screen plot:
Global_Active_Power <- household_2day$Global_active_power
par(oma = c(4,4,6,2))
hist(Global_Active_Power, col = "red", xlab = "Global Active Power (kilowatts)")
title("Plot 1", outer = TRUE, adj = 0, font = 2)

####### END plot1.R #######