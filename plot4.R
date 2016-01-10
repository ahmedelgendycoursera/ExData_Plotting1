#Read all data but save in the workspace part of based on a condition
data <- subset(read.table(file="household_power_consumption.txt",header = TRUE,na.strings = "?",sep=';'),(Date=="2/2/2007"|Date=="1/2/2007"))
#Format Date column from d/m/y format into Date class format to be mergable with Time column.
data$x1 <- as.Date(data$Date, format = "%d/%m/%Y")
#Merge Date and Time columns to create one a single datetime column.
data$x2 <- paste(data$x1,data$Time,sep=" ")
#Coerce datetime to POSIXct to be used in circular statistics.
data$x2 <- as.POSIXct(data$x2)
library("lubridate")
#Create a panel 2 rows by 2 columns
par(mfrow = c(2,2))
# fours plots. The third is made of 3 graphs
plot(round_date(data$x2,"minute"),data$Global_active_power, type = "l",ylab = "Global Active Power",xlab=NA)
plot(round_date(data$x2,"minute"),data$Voltage, type = "l",ylab = "Voltage",xlab="datetime")
plot(round_date(data$x2,"minute"),y = data$Sub_metering_1, type = "l",ylab = "Energy sub metering")
lines(round_date(data$x2,"minute"),y = data$Sub_metering_2, type = "l",col = "red")
lines(round_date(data$x2,"minute"),y = data$Sub_metering_3, type = "l",col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red", "blue"), pch = "__" , bty = "n")
plot(round_date(data$x2,"minute"),data$Global_reactive_power, type = "l",xlab="datetime",ylab = "Global_reactive_power")
dev.copy(png,file="plot4.png")
dev.off()