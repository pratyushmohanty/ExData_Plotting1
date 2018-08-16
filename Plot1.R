## read the data 
url <- "household_power_consumption.txt"
data <- read.csv(url, sep = ';', header = TRUE, stringsAsFactors=FALSE)

## convert Date column from character to Date
data$Date = as.Date(data$Date, format = "%d/%m/%Y")

## filter on dates - 2007-02-01 and 2007-02-02
startDate <- as.Date("2007-02-01", format = "%Y-%m-%d")
endDate <- as.Date("2007-02-02", format = "%Y-%m-%d")

data <- data[data$Date >= startDate & data$Date <= endDate, ]

## convert Global_active_power to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

## plot
with (data, { 
        hist(Global_active_power, 
             main = "Global Active Power", 
             col = "red",
             xlab="Global Active Power (kilowatts)")
        dev.copy(png, file = "Plot1.png", width = 480, height = 480)
        dev.off()
})


