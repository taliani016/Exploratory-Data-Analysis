# Open PNG device
png("plot3.png", width = 480, height = 480)

# Plot Energy sub-metering
plot(data_filtered$DateTime, data_filtered$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering")
lines(data_filtered$DateTime, data_filtered$Sub_metering_2, col = "red")
lines(data_filtered$DateTime, data_filtered$Sub_metering_3, col = "blue")

# Add legend
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

# Close the PNG file
dev.off()
