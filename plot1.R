#-----------------------------------------------
# Author: Jacob Townson
# Date : 06/05/2015
# Title: Project 1
#-----------------------------------------------

# Getting and preparing the data

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, "./electric_consumption.zip")
project_data <- read.csv(unz("./electric_consumption.zip", "household_power_consumption.txt"), sep = ";")

day <- strptime(project_data$Date, "%d/%m/%Y")
project_data$Date <- day

DATE1 <- as.Date("2007-02-01")
DATE2 <- as.Date("2007-02-02")
project_data <- project_data[as.Date(project_data$Date) == DATE1 | as.Date(project_data$Date) == DATE2,]
is.na(project_data) <- project_data=="?"


# Plot 1

project_data$Global_active_power <- as.numeric(as.vector(project_data$Global_active_power))
# Must make the values numeric

hist(project_data$Global_active_power, xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = "red", ylim = c(0,1200))

dev.copy(png, file = "./plot1.png")
dev.off()