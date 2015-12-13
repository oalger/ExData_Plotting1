library(data.table)

##Set working directory and open data file
setwd("~/Data Science/Exploratory Data Analysis/Project 1/exdata-data-household_power_consumption")
dt1 = fread("household_power_consumption.txt", na.strings = "?")

##Create subset of file for 2007-02-01 and 2007-02-02
dt2 <- subset(dt1, Date=="1/2/2007" | Date=="2/2/2007")
dt1 <- NULL

##Create new date/time variable column
DateTime <- strptime(paste(dt2$Date,dt2$Time), format = "%d/%m/%Y %H:%M:%S")
dt2 <- cbind(dt2, DateTime)

##Open png graphics device
png(filename = "plot4.png")

##Matrix of plots
par(mfrow = c(2,2))

##Create x-y plots
with(dt2,{
     plot(DateTime,Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
     plot(DateTime,Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
     plot(DateTime,Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
     lines(DateTime,Sub_metering_2, col = "red")
     lines(DateTime,Sub_metering_3, col = "blue")
     legend("topright",bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(DateTime,Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})

##Close png file
dev.off()
