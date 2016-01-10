#Read all data but save in the workspace part of based on a condition
data <- subset(read.table(file="household_power_consumption.txt",header = TRUE,na.strings = "?",sep=';'),(Date=="2/2/2007"|Date=="1/2/2007"))
#Format Date column from d/m/y format into Date class format to be mergable with Time column.
data$x1 <- as.Date(data$Date, format = "%d/%m/%Y")
#Merge Date and Time columns to create one a single datetime column.
data$x2 <- paste(data$x1,data$Time,sep=" ")
#Coerce datetime to POSIXct to be used in circular statistics.
data$x2 <- as.POSIXct(data$x2)
#Draw histogram.
hist(data$Global_active_power,freq=TRUE, breaks = seq(from = 0, to = 7.500, by = .500), right = TRUE, col = "red", xlab = "Global Active Power (Kilowatts)" , main = "Global Active Power")
#Copy histogram from screen to a png file in the working directory.
dev.copy(png,file="plot1.png")
#close the graphics device of the file.
dev.off()