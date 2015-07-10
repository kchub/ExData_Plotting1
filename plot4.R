##Plot 4 of Coursera Data Science Specialization - Exploratory Data Analysis - Project 1
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

## create plot 4 which is a set of four plots placed in a 2x2 gridand save it as a 480x480 png to the working directory
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(data$datetime,data$Global_active_power, pch = NA, xlab="", ylab="Global Active Power", lines(data$datetime,data$Global_active_power))
plot(data$datetime,data$Voltage, pch = NA, xlab="datetime", ylab="Voltage", lines(data$datetime,data$Voltage))
plot(data$datetime, data$Sub_metering_1, pch=NA, xlab="", ylab="Energy sub metering", cex=0.7, lines(data$datetime, data$Sub_metering_1))
lines(data$datetime, data$Sub_metering_2, col="red")
lines(data$datetime, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lw=1, bty="n")
plot(data$datetime,data$Global_reactive_power, pch = NA, xlab="datetime", ylab="Global_reactive_power", lines(data$datetime,data$Global_reactive_power))
dev.off()