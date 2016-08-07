## The code placed here into comments downloads the household_power_consumption.zip 
##file from the link provided and unzips the file into the text file household_power_consumption.txt
## it will placed into comments for the plot2.R, plot3.R and plot4.R codes
#
# fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
# temp <- tempfile()
# download.file(fileUrl,temp)
# unzip(temp,"household_power_consumption.txt")
# unlink(temp)

## read data from the txt file household_power_consumption.txt
## the data frame is named: df
df <- read.table(
        file = "household_power_consumption.txt", 
        header = TRUE, 
        sep = ";", 
        na.strings = "?", 
        colClasses = c("character", "character", "numeric","numeric", "numeric", "numeric", "numeric",
                       "numeric", "numeric")
)

## creation of a new column datetime pasting Date and Time and suppression of columns Date and Time:
cols <- c("Date", "Time")
df$datetime <- apply(df[, cols], 1, paste, collapse = " ")
df <- df[ , c("datetime", "Global_active_power", "Global_reactive_power", "Voltage", 
              "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]

## conversion of datetime character column to time format:
df$datetime <- strptime(df$datetime, "%d/%m/%Y %H:%M:%S")

## subsetting the data frame to dates between 2007-02-01 and 2007-02-02.
df <- subset(df,df$datetime >= "2007-02-01 00:00:00" & df$datetime <= "2007-02-02 23:59:59")

## creating plot1.png directly using the png graphics device:
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))
        ## topleft graph        
        plot(df$datetime, df$Global_active_power, 
                type="l", 
                xlab="", 
                ylab="Global Active Power")
        ## toptight graph
        plot(df$datetime, df$Voltage, 
                type="l", 
                xlab="datetime", 
                ylab="Voltage")
        ## bottomleft graph
        plot(df$datetime, df$Sub_metering_1, type="l", xlab = "", ylab="Energy Sub Metering")
        lines(df$datetime, df$Sub_metering_2, col="red")
        lines(df$datetime, df$Sub_metering_3, col="blue")
        legend("topright", lty=c(1,1,1), col = c("black","red","blue"), 
                legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
        ## bottomright graph
        plot(df$datetime, df$Global_reactive_power, 
                type="l", 
                xlab="datetime", 
                ylab="Global_reactive_power")
dev.off()