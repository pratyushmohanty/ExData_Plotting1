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

## plot
with (data, { 
        png(file = "Plot3.png", width = 480, height = 480)
        par(mar=c(4,4,2,2)) ## adjust margin for the legend to appear properly
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
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        dev.off()
})
