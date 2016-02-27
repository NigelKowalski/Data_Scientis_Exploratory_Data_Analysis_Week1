temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", na.strings = "?", header = TRUE)
unlink(temp)

## data <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", header = TRUE)
data$Date_Time <- paste(data$Date, data$Time, sep=" ")
data$Date_Time <- strptime(data$Date_Time, format = '%d/%m/%Y %H:%M:%S')

data1 <- subset(data, data$Date_Time >= as.POSIXct("2007-02-01"))
data2 <- subset(data1, data1$Date_Time < as.POSIXct("2007-02-03"))

png(file = "plot4.png")

par(mfrow = c(2,2), mar = c(4,4,2,1))

with(data2, {
  plot(Date_Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(Date_Time, Voltage, type = "l", xlab = "datetime")
 {
 with(data2, plot(Date_Time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy submetering"))
  
  
  with(data2, lines(Date_Time, Sub_metering_2, col = "red", type = "l"))
  
  with(data2, lines(Date_Time, Sub_metering_3, col = "blue", type = "l"))
  
  legend("topright", lwd = 1, col =c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  }
  plot(Date_Time, Global_reactive_power, type = "l", xlab = "datetime")
  })


dev.off()