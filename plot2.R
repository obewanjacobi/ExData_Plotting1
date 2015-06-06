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

# Plot 2

time <- as.POSIXct(paste(project_data$Date, project_data$Time), format="%Y-%m-%d %H:%M:%S")
project_data$Date <- time
project_data$Global_active_power <- as.numeric(as.vector(project_data$Global_active_power))

plot(Global_active_power~Date, data = project_data, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, file = "./plot2.png")
dev.off()