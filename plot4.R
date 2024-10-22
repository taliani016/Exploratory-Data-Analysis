# Load necessary libraries
library(dplyr)
library(lubridate)
library(data.table)

# Read the data, specifying the correct separator and na.strings
data <- read.table(file.choose(), sep = ";", header = TRUE, na.strings = "?")

# Convert Date and Time columns to POSIXct for easier manipulation
data$datetime <- as.POSIXct(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S")

# Filter data for the dates 2007-02-01 and 2007-02-02
filtered_data <- data %>% 
  filter(datetime >= as.POSIXct("2007-02-01") & datetime < as.POSIXct("2007-02-03"))

# Create a factor for weekdays, ensuring correct order and labels
filtered_data$weekday <- factor(weekdays(filtered_data$datetime), 
                                levels = c("Thursday", "Friday", "Saturday"))

# Create a data frame with the first datetime occurrence of each weekday
tick_positions <- filtered_data %>%
  group_by(weekday) %>%
  summarize(datetime = min(datetime))

# Add the last datetime for "Saturday" to tick_positions, but with a different label
tick_positions <- rbind(tick_positions, 
                        data.frame(weekday = "Sat", datetime = max(filtered_data$datetime)))

# Change "Thursday" to "Thu" and "Friday" to "Fri" in tick_positions
tick_positions$weekday <- factor(tick_positions$weekday, 
                                 levels = c("Thursday", "Friday", "Saturday", "Sat"),
                                 labels = c("Thu", "Fri", "Sat", "Sat")) 

# Create the plot with 2 rows and 2 columns
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2)) 

# Plot 1: Global Active Power
plot(filtered_data$datetime, filtered_data$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power",
     xaxt = "n")
axis(1, at = tick_positions$datetime, labels = tick_positions$weekday)

# Plot 2: Voltage
plot(filtered_data$datetime, filtered_data$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage",
     xaxt = "n")
axis(1, at = tick_positions$datetime, labels = tick_positions$weekday)

# Plot 3: Energy sub metering
plot(filtered_data$datetime, filtered_data$Sub_metering_1, 
     type = "l", 
     xlab = "", 
     ylab = "Energy sub metering",
     xaxt = "n", 
     col = "black")
lines(filtered_data$datetime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$datetime, filtered_data$Sub_metering_3, col = "blue")
axis(1, at = tick_positions$datetime, labels = tick_positions$weekday)
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1, 
       bty = "n") # No box around the legend

# Plot 4: Global_reactive_power
plot(filtered_data$datetime, filtered_data$Global_reactive_power, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power",
     xaxt = "n")
axis(1, at = tick_positions$datetime, labels = tick_positions$weekday)

dev.off()
