# Load common setup
source("setup.R")

# Open PNG device
png("plot1.png", width = 480, height = 480)

# Create histogram for Global Active Power
hist(data_filtered$Global_active_power, col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency")

# Close the PNG file
dev.off()
