## Create a folder named "data in WD, Download Files, unzip them

if(!file.exists("data")) 
{dir.create("data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest <- "./data/Electricpower.zip"
download.file(fileUrl, dest)
unzip(dest, exdir = "./data")

## Read the data and save it into object x
x <- read.table("./data/household_power_consumption.txt", sep = ";", 
                header = TRUE, na.strings= "?")

## Subset the data: Only Measurements with Date = 1/2/2007 or 2/2/2007
data <- x[x$Date %in% c("1/2/2007","2/2/2007") ,]

## Add a new date-variable as a combination from "Date" and "Time"
data$datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

## Change the language to "English" (necessary for Step 2 - 4)
Sys.setenv(LANG = "en")
Sys.setlocale("LC_TIME", "C")


## Create and save Plot 3 as .png (480x480)
png("plot3.png", width=480, height=480)
Sys.setenv(LANG = "en")
Sys.setlocale("LC_TIME", "C")
with(data, plot(datetime, Sub_metering_1, type="l", xlab = "",
                ylab="Energy sub metering"))
with(data, points(datetime, Sub_metering_2, col = "red", type = "l"))
with(data, points(datetime, Sub_metering_3, col = "blue", type = "l"))
legend("topright", lwd = 1 , col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()


