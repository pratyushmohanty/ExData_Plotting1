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

## convert Global_active_power to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

## plot
with (data, { 
        plot(DateTime, Global_active_power, 
             type = "n",
             xlab = "",
             ylab="Global Active Power (kilowatts)")
        lines(DateTime, Global_active_power) 
        dev.copy(png, file = "Plot2.png", width = 480, height = 480)
        dev.off()
})

