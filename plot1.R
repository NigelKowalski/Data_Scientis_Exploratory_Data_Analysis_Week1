temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", na.strings = "?", header = TRUE)
unlink(temp)

## data <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", header = TRUE)
data$Date_Time <- paste(data$Date, data$Time, sep=" ")
data$Date_Time <- strptime(data$Date_Time, format = '%d/%m/%Y %H:%M:%S')

data1 <- subset(data, data$Date_Time >= as.POSIXct("2007-02-01"))
data2 <- subset(data1, data1$Date_Time < as.POSIXct("2007-02-03"))
png(file = "plot1.png")


hist(data2$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Glabal Active Power", col = "red")

dev.off()
