# This is the R script for creating the 4 plots for the assignment and then saving
# them to a png graphics file device.

# download the zipped file to wd
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile = "./zippedfile.zip", method = "curl")

library(tidyverse) # the dplyr package from tidyverse makes working with tables
# easier

# read the data from the .txt file in the downloaded zipped file
data <- as_tibble(read.table(unz("./zippedfile.zip", "household_power_consumption.txt"),
                   sep = ";", header = TRUE, na.strings = "?"))

# set date and time variables to date and time classes
library(lubridate)
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

# this assignment only requires data from the dates 2007-02-01 and 2007-02-02
data <- filter(data, Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))

