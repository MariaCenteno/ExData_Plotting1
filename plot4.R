## Download and unzip the dataset
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  URL = "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  download.file(URL,destfile = "exdata-data-household_power_consumption.zip")  
}

unzip("exdata-data-household_power_consumption.zip")
energy = read.table("household_power_consumption.txt",header = TRUE, sep= ";")

## Convert the Date and Time variables to Date/Time classes
energy$Date = strptime(energy$Date, "%d/%m/%Y")

## Subset the data from 2007-02-01 to 2007-02-02
energy = energy[(energy$Date=="2007-02-01") | (energy$Date=="2007-02-02"),]

## Convert all the factor variables into numeric variables
energy$Global_active_power = as.numeric(as.character(energy$Global_active_power))
energy$Global_reactive_power = as.numeric(as.character(energy$Global_reactive_power))
energy$Voltage = as.numeric(as.character(energy$Voltage))
energy = transform(energy, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
energy$Sub_metering_1 = as.numeric(as.character(energy$Sub_metering_1))
energy$Sub_metering_2 = as.numeric(as.character(energy$Sub_metering_2))
energy$Sub_metering_3 = as.numeric(as.character(energy$Sub_metering_3))

# Create Plot 4 (4 plots)
par(mfcol=c(2,2))

# Create Plot (1,2)
plot(energy$timestamp,energy$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# Create Plot (1,1)
plot(energy$timestamp,energy$Sub_metering_1, type = "l", ylab = "Energy sub metering",xlab = "")
lines(energy$timestamp, energy$Sub_metering_2, col = "red")
lines(energy$timestamp, energy$Sub_metering_3, col = "blue")
legend("topright", col = c("black","red","blue"),c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = c(1,1,1), bty="n", cex = 0.8)

# Create Plot (2,2)
plot(energy$timestamp, energy$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# Create Plot (2,1)
plot(energy$timestamp,energy$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power" )

# Crate a PNG file 
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()

