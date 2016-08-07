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
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(df$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()