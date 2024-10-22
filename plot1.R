# Load necessary packages
library(data.table)

# Read the data
data <- read.table(file.choose(), header = TRUE, sep = ";", na.strings = "?")

# Convert the Date and Time variables to Date/Time classes
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")

# Subset the data for the dates 2007-02-01 and 2007-02-02
data_subset <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

# Create the histogram
png("plot1.png", width = 480, height = 480)
hist(data_subset$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()
