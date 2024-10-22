# Load necessary libraries
library(data.table)
library(dplyr)
library(lubridate)

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

# Create the plot
png("plot2.png", width = 480, height = 480)
plot(filtered_data$datetime, filtered_data$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)",
     xaxt = "n")  # Suppress default x-axis labels

# Set x-axis ticks and labels using the tick_positions data frame
axis(1, at = tick_positions$datetime, labels = tick_positions$weekday) 

dev.off()
