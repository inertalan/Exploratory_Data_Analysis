library(dplyr)
durl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
f <- paste0(getwd(), "/data.zip")
download.file(url = durl, destfile = f)
unzip(f)

dat <- read.table(paste0(getwd(),"/household_power_consumption.txt"), sep = ";",header = T)
use <- dat
use$Date <- as.Date(use$Date, "%d/%m/%Y")
d <- use[use$Date == "2007-02-02" | use$Date == "2007-02-01",]

d$Global_active_power <- as.numeric(as.character(d$Global_active_power))
d$Global_reactive_power <- as.numeric(as.character(d$Global_reactive_power))
d$Date_time <- strptime(paste(d$Date,d$Time), "%Y-%m-%d %H:%M:%S")
d$Sub_metering_1 <- as.numeric(as.character(d$Sub_metering_1))
d$Sub_metering_2 <- as.numeric(as.character(d$Sub_metering_2))
d$Sub_metering_3 <- as.numeric(as.character(d$Sub_metering_3))
d$Voltage <- as.numeric(as.character(d$Voltage))

d$Global_reactive_power <- as.numeric(as.character(d$Global_reactive_power))
png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
with(d, plot(Date_time,Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
with(d, plot(Date_time,Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
plot(d$Date_time, d$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(d$Date_time, d$Sub_metering_2, type = "l", col = "red")
lines(d$Date_time, d$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty = "n")
with(d, plot(Date_time,Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()
