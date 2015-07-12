library("data.table", lib.loc="/Library/Frameworks/R.framework/Versions/3.1/Resources/library")
library("lubridate", lib.loc="~/R/win-library/3.2")

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

epcData$Date <- mdy(epcData$Date)
epcData$Time <- hms(epcData$Time)

epcData <- cbind(dateTime=0, epcData)
epcData$dateTime <- epcData$Date + epcData$Time

epcData$Global_active_power <- as.numeric(epcData$Global_active_power)
epcData$Global_reactive_power <- as.numeric(epcData$Global_reactive_power)
epcData$Voltage <- as.numeric(epcData$Voltage)
epcData$Global_intensity <- as.numeric(epcData$Global_intensity)
epcData$Sub_metering_1 <- as.numeric(epcData$Sub_metering_1)
epcData$Sub_metering_2 <- as.numeric(epcData$Sub_metering_2)
epcData$Sub_metering_3 <- as.numeric(epcData$Sub_metering_3)



## Begin plotting functions


png(filename="plot3.png", width=480, height=480)
plot(epcData$dateTime, epcData$Sub_metering_1, type="n", ylim=c(0,30), ylab="Energy sub metering", xlab="")
lines(epcData$dateTime, epcData$Sub_metering_1)
lines(epcData$dateTime, epcData$Sub_metering_2, col="red")
lines(epcData$dateTime, epcData$Sub_metering_3, col="blue")
legend("topright", col=c("black", "red", "blue"), lty="solid", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
