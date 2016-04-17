# Load file and set numeric data types
power <- read.csv2("household_power_consumption.txt", stringsAsFactors = FALSE, na.strings = c("NA", "?"))

# Subset data to the dates Feb 1, 2007 to Feb 2, 2007
power <-power[power$Date == "1/2/2007" | power$Date == "2/2/2007", ]

# Create DateTime column
power$DateTime <- strptime(paste(power$Date, power$Time), "%d/%m/%Y %H:%M:%S")

# Convert date string to type Date
power$Date <- as.Date(power$Date, "%d/%m/%Y")

# Convert numeric data types
power$Global_active_power <- as.numeric(power$Global_active_power)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)
power$Sub_metering_3 <- as.numeric(power$Sub_metering_3)
power$Voltage <- as.numeric(power$Voltage)

# Plot 
with(power, plot(DateTime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering"))
with(power, lines(DateTime, power$Sub_metering_2, type = "l", col = "red"))
with(power, lines(DateTime, power$Sub_metering_3, type = "l", col = "blue"))
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1, 1, 1), 
       col = c("black", "red", "blue"))

# Output to PNG file
dev.copy(png, filename = "plot3.png", width = 480, height = 480, units = "px")
dev.off()
