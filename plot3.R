##Plot 3 of Coursera Data Science Specialization - Exploratory Data Analysis - Project 1
##Author: kchub
##Date: July 9, 20

##set a variable to the zipped file
zipURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

##download the zipped file to a temporary file
temp <- tempfile()
download.file(zipURL, temp)

##unzip and read the text file from the zipped file and indicate headers, seperator, NA value
data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep=";", na.strings = "?")

##format the date column and subset the data to the date range of interest
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

##format the time column and add a new column that is a combination of the date and time
data$Time <- strftime(data$Time, "%H:%M:%S")
data$datetime <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

## create plot 3 and save it as a 480x480 png to the working directory
png(file = "plot3.png", width = 480, height = 480)
plot(data$datetime, data$Sub_metering_1, pch=NA, xlab="", ylab="Energy sub metering", lines(data$datetime, data$Sub_metering_1))
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lw=1)
dev.off()