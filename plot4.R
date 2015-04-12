# run for once to download the data
URL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(URL,temp)
file <- unzip(temp)
unlink(temp)

#file <- file("household_power_consumption.txt")
power_data <- read.table(file, header=T, sep=";")
power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
data_for_report <- power_data[(power_data$Date=="2007-02-01") | (power_data$Date=="2007-02-02"),]
data_for_report$Global_active_power <- as.numeric(as.character(data_for_report$Global_active_power))

data_for_report$Sub_metering_1 <- as.numeric(as.character(data_for_report$Sub_metering_1))
data_for_report$Sub_metering_2 <- as.numeric(as.character(data_for_report$Sub_metering_2))
data_for_report$Sub_metering_3 <- as.numeric(as.character(data_for_report$Sub_metering_3))


#plot 4
par(mfrow=c(2,2))
plot(data_for_report$timestamp,data_for_report$Global_active_power, type="l", xlab="", ylab="Global Active Power")
plot(data_for_report$timestamp,data_for_report$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(data_for_report$timestamp,data_for_report$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(data_for_report$timestamp,data_for_report$Sub_metering_2,col="red")
lines(data_for_report$timestamp,data_for_report$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5)
plot(data_for_report$timestamp,data_for_report$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()