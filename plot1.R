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



png("plot1.png", height = 480, width = 480, units = "px")
hist(d$Global_active_power, main = "Global Active Power", xlab = "Global Active Power(kilowatts)", col = "red")
dev.off()
