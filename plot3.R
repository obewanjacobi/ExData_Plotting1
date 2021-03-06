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

# Plot 3

time <- as.POSIXct(paste(project_data$Date, project_data$Time), format="%Y-%m-%d %H:%M:%S")
project_data$Date <- time
project_data$Sub_metering_1 <- as.numeric(as.vector(project_data$Sub_metering_1))
project_data$Sub_metering_2 <- as.numeric(as.vector(project_data$Sub_metering_2))
project_data$Sub_metering_3 <- as.numeric(as.vector(project_data$Sub_metering_3))

plot((Sub_metering_1+Sub_metering_2+Sub_metering_3)~Date, data = project_data, 
     type = "n", ylab = "Energy sub metering", xlab = "", ylim= c(0,40))
lines(Sub_metering_1~Date, data = project_data, col = "black")
lines(Sub_metering_2~Date, data = project_data, col = "red")
lines(Sub_metering_3~Date, data = project_data, col = "blue")
legend("topright", pch = "-", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "./plot3.png")
dev.off()