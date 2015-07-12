library("data.table", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./data/epc.zip")
unzip("./data/epc.zip")

file <- "household_power_consumption.txt"
start <- "2/1/2007"
end <- "2/2/2007"

getDataRange <- function(file, start, end) {
        data <- fread(file, na.strings=c("?"))
        data <- data[data$Date==start | data$Date==end,]
}

epcData <- getDataRange(file, start, end)

epcData$Date <- as.Date(epcData$Date, format="%m/%d/%Y")
epcData$Time <- chron::times(epcData$Time)
epcData$Global_active_power <- as.numeric(epcData$Global_active_power)
epcData$Global_reactive_power <- as.numeric(epcData$Global_reactive_power)
epcData$Voltage <- as.numeric(epcData$Voltage)
epcData$Global_intensity <- as.numeric(epcData$Global_intensity)
epcData$Sub_metering_1 <- as.numeric(epcData$Sub_metering_1)
epcData$Sub_metering_2 <- as.numeric(epcData$Sub_metering_2)
epcData$Sub_metering_3 <- as.numeric(epcData$Sub_metering_3)



## Begin plotting functions

png(filename="plot1.png", width=480, height=480)
with(epcData, hist(epcData$Global_active_power, col="red", main = "Global Active Power",
             xlab="Global Active Power (kilowatts)", ylab="Frequency", ylim=c(0, 1200),  breaks = 12))
dev.off()


