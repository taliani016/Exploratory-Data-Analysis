# Open PNG device
png("plot4.png", width = 480, height = 480)

# Set up a 2x2 plotting area
par(mfrow = c(2, 2))

# 1. Plot Global Active Power over time
plot(data_filtered$DateTime, data_filtered$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power")

# 2. Plot Voltage over time
plot(data_filtered$DateTime, data_filtered$Voltage, type = "l", 
     xlab = "datetime", ylab = "Voltage")

# 3. Plot Energy sub-metering
plot(data_filtered$DateTime, data_filtered$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering")
lines(data_filtered$DateTime, data_filtered$Sub_metering_2, col = "red")
lines(data_filtered$DateTime, data_filtered$Sub_metering_3, col = "blue")

# Add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1, bty = "n")

# 4. Plot Global Reactive Power over time
plot(data_filtered$DateTime, data_filtered$Global_reactive_power, type = "l", 
     xlab = "datetime", ylab = "Global Reactive Power")

# Close the PNG file
dev.off()
