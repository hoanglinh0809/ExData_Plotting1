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

#plot 2
data_for_report <- transform(data_for_report, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
plot(data_for_report$timestamp,data_for_report$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()