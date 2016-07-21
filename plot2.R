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

png("plot2.png", width = 480, height = 480, units = "px")
with(d, plot(Date_time,Global_active_power, type = "l", xlab = "", ylab = "Global Active Power(kilowatts"))
dev.off()
