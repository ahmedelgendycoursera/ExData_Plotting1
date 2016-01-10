#Read all data but save in the workspace part of based on a condition
data <- subset(read.table(file="household_power_consumption.txt",header = TRUE,na.strings = "?",sep=';'),(Date=="2/2/2007"|Date=="1/2/2007"))
#Format Date column from d/m/y format into Date class format to be mergable with Time column.
data$x1 <- as.Date(data$Date, format = "%d/%m/%Y")
#Merge Date and Time columns to create one a single datetime column.
data$x2 <- paste(data$x1,data$Time,sep=" ")
#Coerce datetime to POSIXct to be used in circular statistics.
data$x2 <- as.POSIXct(data$x2)
library("lubridate")
#Draw Plot then add two more lines for a total of three then a legend.
plot(round_date(data$x2,"minute"),y = data$Sub_metering_1, type = "l",ylab = "Energy sub metering")
lines(round_date(data$x2,"minute"),y = data$Sub_metering_2, type = "l",col = "red")
lines(round_date(data$x2,"minute"),y = data$Sub_metering_3, type = "l",col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red", "blue"), pch = "__" , bty = "o")
dev.copy(png,file="plot3.png")
dev.off()