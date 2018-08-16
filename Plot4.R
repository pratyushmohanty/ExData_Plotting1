## read the data 
url <- "household_power_consumption.txt"
data <- read.csv(url, sep = ';', header = TRUE, stringsAsFactors=FALSE)

## Add a column date time
data$DateTime <- paste(data$Date, data$Time, sep = " ")

## convert Date column from character to Date
data$Date = as.Date(data$Date, format = "%d/%m/%Y")

## filter on dates - 2007-02-01 and 2007-02-02
startDate <- as.Date("2007-02-01", format = "%Y-%m-%d")
endDate <- as.Date("2007-02-02", format = "%Y-%m-%d")

data <- data[data$Date >= startDate & data$Date <= endDate, ]

## convert DateTime column from character to datetime
data$DateTime <- strptime(x = data$DateTime, format = "%d/%m/%Y %H:%M:%S") 

## convert the sub metering values to numeric
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

## convert voltage to numeric
data$Voltage <- as.numeric(data$Voltage)

## convert Global_reactive_power to numeric
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)

## plot
with (data, { 
        png(file = "Plot4.png", width = 480, height = 480)
        ## split the area into a 2x2 grid column wise
        par(mfcol = c(2,2))
        ## 1st plot
        plot(DateTime, Global_active_power, 
             type = "n",
             xlab = "",
             ylab="Global Active Power (kilowatts)")
        lines(DateTime, Global_active_power) 
        ## 2nd plot
        plot(DateTime, Sub_metering_1, 
             type = "n",
             xlab = "",
             ylab="Energy sub metering")
        lines(DateTime, Sub_metering_1, col = "black") 
        lines(DateTime, Sub_metering_2, col = "red") 
        lines(DateTime, Sub_metering_3, col = "blue") 
        legend("topright", 
               pch = "-", 
               col = c("black","red", "blue"),
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               bty = "n")
        ## 3rd plot
        plot(DateTime, Voltage, 
             type = "n",
             xlab = "datetime",
             ylab="Voltage")
        lines(DateTime, Voltage, col = "black") 
        ## 4th plot
        plot(DateTime, Global_reactive_power,
             type = "n",
             xlab = "datetime")
        lines(DateTime, Global_reactive_power, col = "black")
        dev.off()
})
