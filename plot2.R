

# Open PNG device
png("plot2.png", width = 480, height = 480)

# Plot Global Active Power over time
plot(data_filtered$DateTime, data_filtered$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")

# Close the PNG file
dev.off()

