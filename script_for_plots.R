# This is the R script for creating the 4 plots for the assignment and then saving
# them to .png graphics file devices.

# download the zipped file to wd
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "./zippedfile.zip", method = "curl")

library(tidyverse) # the dplyr package from tidyverse makes working with tables
# easier

# read the data from the .txt file in the downloaded zipped file
data <- as_tibble(read.table(unz("./zippedfile.zip", "household_power_consumption.txt"),
                   sep = ";", header = TRUE, na.strings = "?"))

# create a datetime variable (this will be helpful later on)
data <- mutate(data, datetime = paste(data$Date, data$Time, sep = " ")) %>%
        select(Date, Time, datetime, 3:9)

# set date, time and datetime variables to date and time classes
library(lubridate)
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)
data$datetime <- dmy_hms(data$datetime)

# this assignment only requires data from the dates 2007-02-01 and 2007-02-02
data <- filter(data, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))

# create plot 1
hist(data$Global_active_power, col = "red",
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
# copy it to a png file device
dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()

# create plot 2
plot(data$datetime, data$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
# copy it to a png file device
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()

# create plot 3
# open file device
png("plot3.png", width = 480, height = 480)
# create plot
plot(data$datetime, data$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright", legend = names(data[, 8:10]), lty = 1,
       col = c("black", "red", "blue"))
# close file device
dev.off()

# create plot 4
# open file device
png("plot4.png", width = 480, height = 480)
# create plots
par(mfcol = c(2, 2), mar = c(2, 4, 1, 1))
plot(data$datetime, data$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")
plot(data$datetime, data$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering")
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright", legend = names(data[, 8:10]), lty = 1,
       col = c("black", "red", "blue"), box.col = "white", inset = 0.02)
plot(data$datetime, data$Voltage, type = "l", xlab = "", ylab = "Voltage")
plot(data$datetime, data$Global_reactive_power, type = "l",
     xlab = "", ylab = "Global Reactive Power")
# close file device
dev.off()